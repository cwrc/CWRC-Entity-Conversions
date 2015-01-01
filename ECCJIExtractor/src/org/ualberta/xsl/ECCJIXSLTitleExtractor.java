package org.ualberta.xsl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.resources.FileResource;
import org.dom4j.Namespace;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 *
 * @author mpm1
 */
public class ECCJIXSLTitleExtractor {

    private static SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-DD");
    
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
    
    private String convertToTitleCase(String title){
        if(title == null){
            return null;
        }
        
        char[] chars = title.trim().toLowerCase().toCharArray();
        
        if(chars.length == 0){
            return null;
        }
        
        StringBuilder output = new StringBuilder();
        boolean nextCapital = true;
        
        for(char c : chars){
            if(!Character.isAlphabetic(c)){
                nextCapital = true;
            }else if(nextCapital){
                c = Character.toTitleCase(c);
                nextCapital = false;
            }
            
            output.append(c);
        }
        
        return output.toString();
    }
    
    private String getCellStringAsInt(Cell cell){
        String value = cell.toString();
        
        if(value.endsWith(".0")){
            return value.substring(0, value.length() - 2);
        }
        
        return value;
    }

    private void convertFile(File file) {
        try {
            System.out.println("Reading File: " + file.getName());
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            Document doc = builder.newDocument();
            
            Namespace namespace = Namespace.get("xsi", "http://www.w3.org/2001/XMLSchema-instance");
            
            Element root = doc.createElement("modsCollectionDefinition");
            doc.appendChild(root);

            Workbook book;
            book = new XSSFWorkbook(new FileInputStream(file));
            Sheet sheet = book.getSheetAt(0);

            for (int i = 1; i <= sheet.getLastRowNum(); ++i) {
                Row row = sheet.getRow(i);

                String JNL = row.getCell(0) == null ? null : row.getCell(0).toString();
                String NDX = row.getCell(1) == null ? null : getCellStringAsInt(row.getCell(1));
                String SNAME = convertToTitleCase(row.getCell(2) == null ? null : row.getCell(2).toString());
                String FNAME = convertToTitleCase(row.getCell(3) == null ? null : row.getCell(3).toString());
                String TI = convertToTitleCase(row.getCell(4) == null ? "---" : row.getCell(4).toString());
                String MAG = row.getCell(5) == null ? null : convertToTitleCase(row.getCell(5).toString());
                String VOL = row.getCell(6) == null ? null : getCellStringAsInt(row.getCell(6));
                String NUM = row.getCell(7) == null ? null : getCellStringAsInt(row.getCell(7));
                String MO = row.getCell(8) == null ? null : row.getCell(8).toString();
                String YR = row.getCell(9) == null ? null : getCellStringAsInt(row.getCell(9));
                String PG = row.getCell(10) == null ? null : row.getCell(10).toString();
                String S1 = row.getCell(11) == null ? null : convertToTitleCase(row.getCell(11).toString());
                String S2 = row.getCell(12) == null ? null : convertToTitleCase(row.getCell(12).toString());
                String GEN = row.getCell(13) == null ? null : row.getCell(13).toString();
                String ORG = row.getCell(14) == null ? null : row.getCell(14).toString();
                String FLINE = row.getCell(15) == null ? null : row.getCell(15).toString().toLowerCase() + "[First line of poetry.]";
                String SP = row.getCell(16) == null ? null : row.getCell(16).toString();
                         
                String id = JNL + NDX;
                
                //TODO: Check if entry exists;
                root.appendChild(createTitle(doc, GEN, TI, FNAME, SNAME, FLINE, S1, S2, MAG, ORG, VOL, NUM, PG, MO, YR, id, SP));
            }

            File output = new File("./title_build/" + file.getName().substring(0, file.getName().length() - 5) + ".mgxml");
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
    
    private Element createGenre(Document doc, String authority, String value){
        Element genre = doc.createElement("genre");
        
        genre.setAttribute("authority", authority);
        genre.setTextContent(value);
        
        return genre;
    }
    
    private Element createTitle(Document doc, String title){
        Element parent = doc.createElement("titleInfo");
        
        Element child = doc.createElement("title");
        child.setTextContent(title);
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createName(Document doc, String first, String last){
        Element parent = doc.createElement("name");
        parent.setAttribute("type", "personal");
        
        Element child = doc.createElement("namePart");
        
        StringBuilder builder = new StringBuilder();
        
        if(first != null){
            builder.append(first);
            builder.append(' ');
        }
        
        if(last != null){
            builder.append(last);
        }
        
        child.setTextContent(builder.toString().trim());
        parent.appendChild(child);
        
        child = doc.createElement("role");
        
        Element term = doc.createElement("roleTerm");
        term.setAttribute("type", "code");
        term.setAttribute("authority", "marcrelator");
        term.setTextContent("aut");
        child.appendChild(term);
        
        term = doc.createElement("roleTerm");
        term.setAttribute("type", "text");
        term.setAttribute("authority", "marcrelator");
        term.setTextContent("Author");
        child.appendChild(term);
        
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createFirstLine(Document doc, String note){
        Element parent = doc.createElement("note");
        
        StringBuilder builder = new StringBuilder(note.substring(0, 1).toUpperCase());
        builder.append(note.substring(1));
        builder.append(" [First line of poetry.]");
        parent.setTextContent(builder.toString());
        
        return parent;
    }
    
    private Element createSubject(Document doc, String topic){
        Element parent = doc.createElement("subject");
        
        Element child = doc.createElement("topic");
        child.setTextContent(topic);
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createBasicChild(Document doc, String elementName, String textValue){
        Element child = doc.createElement(elementName);
        child.setTextContent(textValue);
        
        return child;
    }
    
    private Element createLanguage(Document doc){
        Element parent = doc.createElement("language");
        
        Element child = doc.createElement("languageTerm");
        child.setAttribute("type", "text");
        child.setTextContent("English");
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createPhysicalDescription(Document doc){
        Element parent = doc.createElement("physicalDescription");
        
        Element child = doc.createElement("form");
        child.setAttribute("authority", "marcform");
        child.setTextContent("print");
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createRelatedItem(Document doc, String MAG, String VOL, String NUM, String PG, String MO, String YR){
        Element subSub;
        Element parent = doc.createElement("relatedItem");
        parent.setAttribute("type", "host");
        
        parent.appendChild(createTitle(doc, MAG));
        
        // originInfo
        Element child = doc.createElement("originInfo");
        
        Element subChild = doc.createElement("issuance");
        subChild.setTextContent("continuing");
        child.appendChild(subChild);
        
        parent.appendChild(child);
        
        // part
        child = doc.createElement("part");
        
        if(VOL != null){
            subChild = doc.createElement("detail");
            subChild.setAttribute("type", "volume");
            
            subSub = doc.createElement("number");
            subSub.setTextContent(VOL);
            subChild.appendChild(subSub);
            
            child.appendChild(subChild);
        }
        
        if(NUM != null){
            subChild = doc.createElement("detail");
            subChild.setAttribute("type", "issue");
            
            subSub = doc.createElement("number");
            subSub.setTextContent(NUM);
            subChild.appendChild(subSub);
            
            child.appendChild(subChild);
        }
        
        if(PG != null){
            subChild = doc.createElement("extent");
            subChild.setAttribute("unit", "pages");
            
            subSub = doc.createElement("list");
            subSub.setTextContent(PG);
            subChild.appendChild(subSub);
            
            child.appendChild(subChild);
        }
        
        subChild = doc.createElement("date");
        subChild.setTextContent(MO + " " + YR);
        child.appendChild(subChild);
        
        parent.appendChild(child);
        
        return parent;
    }
    
    public Element createAccessCondition(Document doc){
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
    
    public Element createRecordInfo(Document doc, String id){
        Element parent = doc.createElement("recordInfo");
        
        Element child = doc.createElement("recordContentSource");
        child.setTextContent("Early Canadian Cultural Journals Index (ECCJI)");
        parent.appendChild(child);
        
        child = doc.createElement("recordCreationDate");
        child.setAttribute("encoding", "w3cdtf");
        child.setTextContent(dt.format(new Date()));
        parent.appendChild(child);
        
        child = doc.createElement("recordIdentifier");
        child.setAttribute("source", "ECCJI");
        child.setTextContent(id);
        parent.appendChild(child);
        
        child = doc.createElement("recordOrigin");
        child.setTextContent("Record has been transformed into a MODS record from an Oracle database record using Java code.");
        parent.appendChild(child);
        
        child = doc.createElement("languageOfCataloging");
        Element subChild = doc.createElement("languageTerm");
        
        subChild.setAttribute("type", "text");
        subChild.setTextContent("English");
        
        child.appendChild(subChild);
        parent.appendChild(child);
        
        return parent;
    }
    
    private Element createTitle(
            Document doc,
            String GEN,
            String TI,
            String FNAME,
            String SNAME,
            String FLINE,
            String S1,
            String S2,
            String MAG,
            String ORG,
            String VOL,
            String NUM,
            String PG,
            String MO,
            String YR,
            String id,
            String SP) {
        
        Element entity = doc.createElement("mods");
        entity.setAttributeNS("http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation", "http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/mods.xsd");
        String value;
        
        entity.appendChild(createTitle(doc, TI));
        entity.appendChild(createName(doc, FNAME, SNAME));
        
        entity.appendChild(createBasicChild(doc, "typeOfResource", "text"));
        
        entity.appendChild(createGenre(doc, "format", "Part"));
        entity.appendChild(createGenre(doc, "cwrc:entity", "work"));
        
        if(GEN != null){
            if("M".compareTo(GEN) == 0){
                value = "miscellaneous";
            }else if("P".compareTo(GEN) == 0){
                value = "prose";
            }else if("F".compareTo(GEN) == 0){
                value = "fiction";
            }else if("V".compareTo(GEN) == 0){
                value = "verse";
            }else if("I".compareTo(GEN) == 0){
                value = "illustration";
            }else if("R".compareTo(GEN) == 0){
                value = "report/news";
            }else{
                value = GEN;
            }
            
            entity.appendChild(createGenre(doc, "eccji", value));
        }
        
        entity.appendChild(createGenre(doc, "tei:level", "a"));
        
        entity.appendChild(createLanguage(doc));
        entity.appendChild(createPhysicalDescription(doc));
        
        if(FLINE != null){
            entity.appendChild(createFirstLine(doc, FLINE));
        }
        
        if(S1 != null){
            entity.appendChild(createSubject(doc, S1));
        }
        
        if(S2 != null){
            entity.appendChild(createSubject(doc, S2));
        }
        
        entity.appendChild(createRelatedItem(doc, MAG, VOL, NUM, PG, MO, YR));
        entity.appendChild(createAccessCondition(doc));
        entity.appendChild(createRecordInfo(doc, id));
        
        return entity;
    }

    private void transformDocument(Document doc, File output) throws TransformerConfigurationException, TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer();
        DOMSource source = new DOMSource(doc);

        StreamResult result = new StreamResult(output);

        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.transform(source, result);
    }
}
