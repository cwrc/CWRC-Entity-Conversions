/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.ualberta.xsl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
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
public class ECCJIXSLAuthorExtractor {
    private FileSet fileset;
    private List<String> names = new ArrayList<String>();
    
    public void addFileset(FileSet fileset) {
        this.fileset = fileset;
    }
    
    public void execute(){
        Iterator iterator = fileset.iterator();
        
        while(iterator.hasNext()) {
            FileResource file = (FileResource)iterator.next();
            
            convertFile(file.getFile());
        }
    }
    
    private static Element addIdentity(Document doc, String firstName, String lastName){
        Element identity = doc.createElement("identity");
        Element preferredForm = doc.createElement("preferredForm");
        Element namePart = doc.createElement("namePart");
        
        if(firstName == null){
            namePart.setTextContent(lastName);
            preferredForm.appendChild(namePart);
        }else if(lastName == null){
            namePart.setTextContent(firstName);
            preferredForm.appendChild(namePart);
        }else{
            namePart.setTextContent(lastName);
            namePart.setAttribute("partType", "family");
            preferredForm.appendChild(namePart);
            
            namePart = doc.createElement("namePart");
            namePart.setTextContent(firstName);
            namePart.setAttribute("partType", "given");
            preferredForm.appendChild(namePart);
        }
        
        identity.appendChild(preferredForm);
        return identity;
    }
    
    private static Element addRecordInfo(Document doc){
        Element recordInfo = doc.createElement("recordInfo");
        
        Element parent = doc.createElement("originInfo");
        Element child = doc.createElement("projectId");
        child.setTextContent("eccji");
        parent.appendChild(child);
        recordInfo.appendChild(parent);
        
        parent = doc.createElement("personTypes");
        child = doc.createElement("personType");
        child.setTextContent("creator");
        parent.appendChild(child);
        
        recordInfo.appendChild(createAccessCondition(doc));
        
        recordInfo.appendChild(parent);
        
        return recordInfo;
    }
    
    private static String convertName(String name){
        if(name == null){
            return null;
        }
        
        char[] chars = name.trim().toLowerCase().toCharArray();
        
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
    
    private boolean isAuthorAdded(String firstName, String lastName){
        StringBuilder nameKey = new StringBuilder();
        
        nameKey.append(lastName);
        
        if(firstName != null){
            nameKey.append(", ");
            nameKey.append(firstName);
        }
        
        if(names.contains(nameKey.toString())){
            for(String name : names){
                if(name.compareTo(nameKey.toString()) == 0){
                    return true;
                }
            }
        }
        
        names.add(nameKey.toString());
        
        return false;
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
    
    private static Element createPerson(Document doc, String firstName, String lastName){
        Element person = doc.createElement("person");
        person.appendChild(addRecordInfo(doc));
        person.appendChild(addIdentity(doc, firstName, lastName));
        Element description = doc.createElement("description");
        Element factuality = doc.createElement("factuality");
        factuality.setTextContent("real");
        description.appendChild(factuality);
        person.appendChild(description);
        
        return person;
    }
    
    private void transformDocument(Document doc, File output) throws TransformerConfigurationException, TransformerException {
        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer();
        DOMSource source = new DOMSource(doc);

        StreamResult result = new StreamResult(output);

        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.transform(source, result);
    }
    
    private void convertFile(File file){
        try{
            System.out.println("Reading File: " + file.getName());
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            
            Document doc = builder.newDocument();
            Element root = doc.createElement("cwrc");
            doc.appendChild(root);
            
            Workbook book;
            book = new XSSFWorkbook(new FileInputStream(file));
            Sheet sheet = book.getSheetAt(0);
            
            for(int i = 0; i <= sheet.getLastRowNum(); ++i){
                Row row = sheet.getRow(i);
                
                String sname = convertName(row.getCell(2) == null ? null : row.getCell(2).toString());
                String fname = convertName(row.getCell(3) == null ? null : row.getCell(3).toString());
                
                if(!isAuthorAdded(fname, sname)){
                    Element entity = doc.createElement("entity");
                    entity.appendChild(createPerson(doc, fname, sname));
                    root.appendChild(entity);
                }
            }
            
            File output = new File("./author_build/" + file.getName().substring(0, file.getName().length() - 5) + ".mgxml");
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
}
