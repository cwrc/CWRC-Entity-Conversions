package org.ualberta.xsl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
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
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.resources.FileResource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author mpm1
 */
public class ECCJIXSLOrganizationExtractor {

    private FileSet fileset;
    private List<String> names = new ArrayList<String>();

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

    private static void splitNames(String orgName, String orgLoc, List<String> outNames, List<String> outLocs) {
        if (orgName.toUpperCase().compareTo("SPECTATOR PRINTING CO (V. 1); GRIFFIN & KIDNER (V. 2)") == 0) {
            outNames.add("Spectator Printing Co");
            outNames.add("Griffin & Kinder");

            outLocs.add(orgLoc);
            outLocs.add(orgLoc);
        } else if(orgName.toLowerCase().compareTo("published for the st. nicholas home") == 0){
            outNames.add("St. Nicholas Home");
            
            outLocs.add(orgLoc);
        }else if (orgName.toUpperCase().compareTo("CALLAHAN, F. (V. 1)|GILLIES & CALLAHAN (V. 2 & 4)|SADLIER, D. & J. (V. 3, 5-7)|CALLAHAN (V. 8)") == 0) {
            outNames.add("Callahan, F.");
            outNames.add("Gillies & Callahan");
            outNames.add("Sadlier, D. & J.");
            outNames.add("Callahan");

            outLocs.add(orgLoc);
            outLocs.add(orgLoc);
            outLocs.add(orgLoc);
            outLocs.add(orgLoc);
        } else if (orgName.toUpperCase().compareTo("W.B. BAIKIE (BARRIE); JOHN ROW (MONTREAL); GRAHAM BRYSON (OTTAWA); M. SPRINGER (STRATHROY); E. & C. GURNEY (TORONTO); LEWIS & PATTERSON (BROCKVILLE)") == 0) {
            outNames.add("W.B. Baikie");
            outNames.add("John Row");
            outNames.add("Graham Bryson");
            outNames.add("M. Springer");
            outNames.add("E. & C. Gurney");
            outNames.add("Lewis & Patterson");

            outLocs.add("Barrie");
            outLocs.add("Montreal");
            outLocs.add("Ottawa");
            outLocs.add("Strathroy");
            outLocs.add("Toronto");
            outLocs.add("Brockville");
        } else {
            outNames.add(orgName);
            outLocs.add(orgLoc);
        }
    }

    private void convertFile(File file) {
        try {
            System.out.println("Reading File: " + file.getName());
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            Document doc = builder.newDocument();
            Element root = doc.createElement("cwrc");
            doc.appendChild(root);

            Workbook book;
            book = new XSSFWorkbook(new FileInputStream(file));
            Sheet sheet = book.getSheetAt(0);

            for (int i = 1; i <= sheet.getLastRowNum(); ++i) {
                Row row = sheet.getRow(i);

                String orgName = convertName(row.getCell(7) == null ? null : row.getCell(7).toString());
                String orgLoc = convertName(row.getCell(6) == null ? null : row.getCell(6).toString());

                if (orgName != null) {
                    List<String> orgNames = new ArrayList<String>();
                    List<String> orgLocs = new ArrayList<String>();
                    splitNames(orgName, orgLoc, orgNames, orgLocs);

                    for (int j = 0; j < orgNames.size(); ++j) {
                        if (!isOrganizationAdded(orgNames.get(j), orgLocs.get(j))) {
                            Element entity = doc.createElement("entity");
                            entity.appendChild(createOrganization(doc, orgNames.get(j), orgLocs.get(j)));
                            root.appendChild(entity);
                        }
                    }
                }
            }

            File output = new File("./organization_build/" + file.getName().substring(0, file.getName().length() - 5) + ".mgxml");
            System.out.println("Writing File: " + output.getName());
            transformDocument(doc, output);
        } catch (IOException ex) {
            System.err.println("Error reading file: " + ex.getMessage());
        } catch (ParserConfigurationException ex) {
            System.err.println("Error creating xml document: " + ex.getMessage());
        } catch (TransformerConfigurationException ex) {
            System.err.println("Error writing xml document: " + ex.getMessage());
        } catch (TransformerException ex) {
            System.err.println("Error writing xml document: " + ex.getMessage());
        }
    }

    private boolean isOrganizationAdded(String orgName, String orgLoc) {
        if (orgName == null) {
            return true;
        }

        String newName = orgName + " - " + orgLoc;

        if (names.contains(newName)) {
            for (String name : names) {
                if (name.compareTo(newName) == 0) {
                    return true;
                }
            }
        }

        return false;
    }

    private static Element addRecordInfo(Document doc) {
        Element recordInfo = doc.createElement("recordInfo");

        Element parent = doc.createElement("orgTypes");
        Element child = doc.createElement("orgType");
        child.setTextContent("publishing");
        parent.appendChild(child);
        recordInfo.appendChild(parent);
        
        Element parent2 = doc.createElement("originInfo");
        Element child2 = doc.createElement("projectId");
        child2.setTextContent("eccji");
        parent2.appendChild(child2);
        Element recordCreationDate = doc.createElement("recordCreationDate");
        Element recordChangeDate = doc.createElement("recordChangeDate");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String dateInISO8601 = df.format(new Date());
        recordCreationDate.setTextContent(dateInISO8601);
        recordChangeDate.setTextContent(dateInISO8601);
        parent2.appendChild(recordCreationDate);
        parent2.appendChild(recordChangeDate);
        recordInfo.appendChild(parent2);
        
        recordInfo.appendChild(createAccessCondition(doc));

        return recordInfo;
    }

    private static Element addIdentity(Document doc, String orgName) {
        Element identity = doc.createElement("identity");

        Element parent = doc.createElement("preferredForm");
        Element child = doc.createElement("namePart");
        child.setTextContent(orgName);
        parent.appendChild(child);
        identity.appendChild(parent);

        return identity;
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

    private static Element createOrganization(Document doc, String orgName, String orgLoc) {
        Element organization = doc.createElement("organization");
        organization.appendChild(addRecordInfo(doc));
        organization.appendChild(addIdentity(doc, orgName));

        return organization;
    }

    private void transformDocument(Document doc, File output) throws TransformerConfigurationException, TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer();
        DOMSource source = new DOMSource(doc);

        StreamResult result = new StreamResult(output);

        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.transform(source, result);
    }

    private static String convertName(String name) {
        if (name == null) {
            return null;
        }

        char[] chars = name.trim().toLowerCase().toCharArray();

        if (chars.length == 0) {
            return null;
        }

        StringBuilder output = new StringBuilder();
        boolean nextCapital = true;

        for (char c : chars) {
            if (!Character.isAlphabetic(c)) {
                nextCapital = true;
            } else if (nextCapital) {
                c = Character.toTitleCase(c);
                nextCapital = false;
            }

            output.append(c);
        }

        return output.toString();
    }
}
