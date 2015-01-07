/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ualberta.xsl;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.regex.Pattern;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.resources.FileResource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author mpm1
 */
public class CEWWXSLExtractor {
    private static Pattern pattern = Pattern.compile("[^0-9a-zA-Z ]");
    private FileSet fileset;

    public void addFileset(FileSet fileset) {
        this.fileset = fileset;
    }

    public void execute() {
        Iterator iterator = fileset.iterator();

        while (iterator.hasNext()) {
            FileResource file = (FileResource) iterator.next();

            convertFile(file.getFile());
        }
    }

    private boolean parseName(Document doc, Element root, String name) {
        String[] parts = name.split(",");

        if (parts.length < 2) {
            Element namePart = doc.createElement("namePart");
            namePart.setTextContent(name);
            root.appendChild(namePart);
            return false;
        } else {
            Element family = doc.createElement("namePart");
            family.setAttribute("partType", "family");
            family.setTextContent(parts[0].trim());
            root.appendChild(family);

            Element given = doc.createElement("namePart");
            given.setAttribute("partType", "given");

            StringBuilder newName = new StringBuilder(parts[1].trim());
            for (int index = 2; index < parts.length; ++index) {
                newName.append(", ");
                newName.append(parts[index].trim());
            }
            given.setTextContent(newName.toString());
            root.appendChild(given);
        }

        return true;
    }

    private void writeIdentity(Document doc, Element identity, String name, String altNames) {
        Element preferredForm = doc.createElement("preferredForm");
        parseName(doc, preferredForm, name);
        identity.appendChild(preferredForm);

        Element variantForms = doc.createElement("variantForms");
        writeVariants(doc, variantForms, altNames);
        identity.appendChild(variantForms);
    }

    private String writeDate(Document doc, Element parent, String date, String dateType, String appendYear) {
        String currDate = null;
        String newYear = "";

        boolean textDateApplied = false;
        if (date.startsWith("d.")) {
            Element textDate = doc.createElement("textDate");
            textDate.setTextContent(date);
            parent.appendChild(textDate);
            textDateApplied = true;
            
            currDate = date.substring(2).trim();
        } else if (date.startsWith("c.")) {
            Element textDate = doc.createElement("textDate");
            textDate.setTextContent(date);
            parent.appendChild(textDate);
            textDateApplied = true;
            
            currDate = date.substring(2).trim();
        } else {
            currDate = date.trim();
        }

        if (pattern.matcher(currDate).find()) {
            if(!textDateApplied){
                Element textDate = doc.createElement("textDate");
                textDate.setTextContent(currDate);
                parent.appendChild(textDate);
                textDateApplied = true;
            }
            
            newYear = currDate.substring(0, 2);
        } else {
            String[] dateParts = currDate.split(" ");

            StringBuilder builder = null;
            if(dateParts[0].length() <= 2){
                builder = new StringBuilder(appendYear);
                builder.append(dateParts[0]);
                newYear = appendYear;
            }else{
                builder = new StringBuilder(dateParts[0]);
                newYear = currDate.substring(0, 2);
            }
            
            builder.append('-');

            if (dateParts.length > 1) {
                builder.append(DateUtil.convertMonth(dateParts[1]));
            }
            builder.append('-');

            if (dateParts.length > 2) {
                builder.append(dateParts[2].length() == 1 ? "0" + dateParts[2] : dateParts[2]);
            }

            Element standardDate = doc.createElement("standardDate");
            standardDate.setTextContent(builder.toString());
            parent.appendChild(standardDate);
        }

        Element dateTypeElement = doc.createElement("dateType");
        dateTypeElement.setTextContent(dateType);
        parent.appendChild(dateTypeElement);
        
        return newYear;
    }

    private Element getProjectId(Document doc) {
        Element projectId = doc.createElement("projectId");
        projectId.setTextContent("ceww");

        return projectId;
    }

    private boolean extractDates(Document doc, Element existDates, String date) {
        if(date.isEmpty()){
            return false;
        }
        
        // Element dateRange = doc.createElement("dateRange");
        String[] dates = date.split("-");

        boolean found = false;
        for (int index = 0; index < dates.length; ++index) {
            Element dateSection = null;
            String currDate = dates[index].trim();

            if (currDate.length() == 0) {
                continue;
            }

            found = true;
            String appendYear = "";
            if (index > 0 || currDate.startsWith("d.")) {
                dateSection = doc.createElement("dateSingle");
                writeDate(doc, dateSection, currDate, "death", appendYear);
            } else {
                dateSection = doc.createElement("dateSingle");
                appendYear = writeDate(doc, dateSection, currDate, "birth", appendYear);
            }

            // dateRange.appendChild(dateSection);
            existDates.appendChild(dateSection);
        }

        if (!found) {
            return false;
        }

        // existDates.appendChild(dateRange);

        return true;
    }

    private void writeVariants(Document doc, Element variantForms, String altNames) {
        String[] names = altNames.split(";");

        for (String name : names) {
            if (!name.isEmpty()) {
                boolean isBirth = false;
                if (name.startsWith("née ")) {
                    isBirth = true;
                    name = name.substring(4);
                }

                Element variant = doc.createElement("variant");
                parseName(doc, variant, name.trim());

                if (isBirth) {
                    Element variantType = doc.createElement("variantType");
                    variantType.setTextContent("birthName");
                    variant.appendChild(variantType);
                }


                /*Element authorizedBy = doc.createElement("authorizedBy");
                authorizedBy.appendChild(getProjectId(doc));
                variant.appendChild(authorizedBy);*/

                variantForms.appendChild(variant);
            }
        }
    }

    private boolean writeDescription(Document doc, Element description, String date, String notes) {
        Element existDates = doc.createElement("existDates");
        boolean datesExtracted = extractDates(doc, existDates, date);

        if (datesExtracted) {
            description.appendChild(existDates);
        }

        Element descriptiveNote = doc.createElement("descriptiveNotes");
        Element note = doc.createElement("note");
        
        //Element access = doc.createElement("access");
        //access.setTextContent("public");
        //note.appendChild(access);
        
        // Element p = doc.createElement("p");

        // p.setTextContent(notes);
        note.setTextContent(notes);

        // note.appendChild(p);
        descriptiveNote.appendChild(note);
        description.appendChild(descriptiveNote);

        if (notes != null && notes.trim().startsWith("To be included in CEWW")) {
            return false; // This tells us that it may be a duplicate in the excel file. We should move this to a separate file for merging.
        }

        return true;
    }
    
    public static Element createAccessCondition(Document doc){
        Element parent = doc.createElement("accessCondition");
        parent.setAttribute("type", "use and reproduction");
        
        parent.appendChild(doc.createTextNode("Use of this public-domain resource is governed by the "));
        
        Element child = doc.createElement("a");
        child.setAttribute("rel", "license");
        child.setAttribute("href", "http://creativecommons.org/licenses/by-nc/4.0/");
        child.setTextContent("Creative Commons Attribution-NonCommercial 4.0 International License");
        parent.appendChild(child);
        
        parent.appendChild(doc.createTextNode("."));
        
        return parent;
    }

    private void writeToXml(Document doc, Element root, Document doc2, Element root2, String name, String note, String date, String altNames) throws ParserConfigurationException {
        Element entity = doc.createElement("entity");
        Element person = doc.createElement("person");

        Element recordInfo = doc.createElement("recordInfo");
        Element originInfo = doc.createElement("originInfo");
        originInfo.appendChild(getProjectId(doc));
        recordInfo.appendChild(originInfo);
        Element personTypes = doc.createElement("personTypes");
        recordInfo.appendChild(personTypes);
        
        recordInfo.appendChild(createAccessCondition(doc));
        
        person.appendChild(recordInfo);

        Element identity = doc.createElement("identity");
        writeIdentity(doc, identity, name, altNames);
        person.appendChild(identity);

        Element description = doc.createElement("description");
        boolean result = writeDescription(doc, description, date, note);
        Element factuality = doc.createElement("factuality");
        factuality.setTextContent("real");
        description.appendChild(factuality);
        person.appendChild(description);

        entity.appendChild(person);

        if (result) {
            root.appendChild(entity);
        } else {
            entity = (Element) doc2.adoptNode(entity);
            root2.appendChild(entity);
        }
    }

    private void transformDocument(Document doc, File output) throws TransformerConfigurationException, TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer();
        DOMSource source = new DOMSource(doc);

        StreamResult result = new StreamResult(output);

        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.transform(source, result);
    }

    private void convertFile(File file) {
        try {
            System.out.println("Reading File: " + file.getName());

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            Document doc = builder.newDocument();
            Element root = doc.createElement("cwrc");
            doc.appendChild(root);

            Document doc2 = builder.newDocument();
            Element root2 = doc2.createElement("cwrc");
            doc2.appendChild(root2);

            Workbook book;
            book = Workbook.getWorkbook(file);
            Sheet sheet = book.getSheet(0);

            for (int index = 1; index < sheet.getRows(); ++index) {
                Cell[] row = sheet.getRow(index);

                String name = row[0].getContents().trim();
                String note = row[1].getContents().trim();
                String date = row[2].getContents().trim();
                String altNames = row[3].getContents().trim();

                writeToXml(doc, root, doc2, root2, name, note, date, altNames);
            }

            book.close();

            File output = new File("./author_build/" + file.getName().substring(0, file.getName().length() - 4) + ".mgxml");
            System.out.println("Writing File: " + output.getName());
            transformDocument(doc, output);

            output = new File("./author_build/" + file.getName().substring(0, file.getName().length() - 4) + "_possibleDuplicates.mgxml");
            System.out.println("Writing File: " + output.getName());
            transformDocument(doc2, output);
        } catch (IOException ex) {
            System.err.println("Error reading file: " + ex.getMessage());
        } catch (BiffException ex) {
            System.err.println("Error converting file: " + ex.getMessage());
        } catch (ParserConfigurationException ex) {
            System.err.println("Error creating xml document: " + ex.getMessage());
        } catch (TransformerConfigurationException ex) {
            System.err.println("Error writing xml document: " + ex.getMessage());
        } catch (TransformerException ex) {
            System.err.println("Error writing xml document: " + ex.getMessage());
        }
    }
}
