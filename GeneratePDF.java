import java.io.*;
import java.util.*;
import java.text.*;
import javax.xml.transform.*;
import javax.xml.transform.sax.*;
import javax.xml.transform.stream.*;
import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;
import org.apache.fop.apps.*;
import org.apache.fop.pdf.*;
import org.xml.sax.*;

import com.sun.mail.smtp.SMTPTransport;


public class GeneratePDF {

    private static final FopFactory FOP_FACTORY = FopFactory.newInstance(new File(".").toURI());
    private static final TransformerFactory T_FACTORY = TransformerFactory.newInstance();
    private static final String PROPS_FILE = "generatepdf.properties";

    private Properties generatePdfProperties = null;
    private String[] headerArray = null;
    private ArrayList dataList = null;
    private String[] emailAddressArray = null;
    private String[] fileNameArray = null;
    private String[] employeeNameArray = null;
    private String[] employeePasswordArray = null;
    private String templateFileName = null;
    private String dataFileName = null;
    private String targetDirName = null;
    private Transformer transformer = null;

    public GeneratePDF() {
    }

    public GeneratePDF(String _templateFileName, String _dataFileName, String _targetDirName) {
        this.templateFileName = _templateFileName;
        this.dataFileName = _dataFileName;
        this.targetDirName = _targetDirName;
        this.dataList = new ArrayList();
        this.loadGeneratePdfProperties();
    }

    public static void main(String args[]) {

        if (args == null || args.length != 3) {
            System.out.println("Wrong Usage. It should be:\njava GeneratePDF <Template Name (XSL)> <Data File> <Target File Directory>");
            System.exit(0);
        }
        String _templateFileName = args[0];
        String _dataFileName = args[1];
        String _targetDirName = args[2];

        GeneratePDF instance = new GeneratePDF(_templateFileName, _dataFileName, _targetDirName);

        instance.readDataFile();
        instance.validateAllValuesPresent();
        instance.loadTemplateFile();
        instance.createDocumentsFromData();

    }

    private void validateAllValuesPresent() {
        List<String> headerList = Arrays.asList(this.headerArray);
        ArrayList<String> missingFieldList = new ArrayList<String>();
        boolean validationFailedFlag = false;
        if (!headerList.contains("Employee-Id")) {
            missingFieldList.add("Employee-Id");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Employee-Name")) {
            missingFieldList.add("Employee-Name");
            validationFailedFlag = true;
        }
        if (!headerList.contains("PAN")) {
            missingFieldList.add("PAN");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Email")) {
            missingFieldList.add("Email");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Designation")) {
            missingFieldList.add("Designation");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Is-Promoted")) {
            missingFieldList.add("Is-Promoted");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Basic-Monthly")) {
            missingFieldList.add("Basic-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Last-Year-Performance-Bonus")) {
            missingFieldList.add("Last-Year-Performance-Bonus");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Telephone-Reimbursements-Monthly")) {
            missingFieldList.add("Telephone-Reimbursements-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("HRA-Monthly")) {
            missingFieldList.add("HRA-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Food-Allowance-Monthly")) {
            missingFieldList.add("Food-Allowance-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Special-Allowance-Monthly")) {
            missingFieldList.add("Special-Allowance-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Total-Fixed-Salary-Monthly")) {
            missingFieldList.add("Total-Fixed-Salary-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("PF-Monthly")) {
            missingFieldList.add("PF-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Total-Monthly")) {
            missingFieldList.add("Total-Monthly");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Basic-Annual")) {
            missingFieldList.add("Basic-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Education-Allowance-Annual")) {
            missingFieldList.add("Education-Allowance-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Telephone-Reimbursements-Annual")) {
            missingFieldList.add("Telephone-Reimbursements-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("HRA-Annual")) {
            missingFieldList.add("HRA-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Food-Allowance-Annual")) {
            missingFieldList.add("Food-Allowance-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Special-Allowance-Annual")) {
            missingFieldList.add("Special-Allowance-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Total-Fixed-Salary-Annual")) {
            missingFieldList.add("Total-Fixed-Salary-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Performance-Bonus-Annual")) {
            missingFieldList.add("Performance-Bonus-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("PF-Annual")) {
            missingFieldList.add("PF-Annual");
            validationFailedFlag = true;
        }
        if (!headerList.contains("Total-Annual")) {
            missingFieldList.add("Total-Annual");
            validationFailedFlag = true;
        }
        if (validationFailedFlag) {
            String missingFields = String.join("\", \"", missingFieldList);
            System.out.println("Input data (csv file) is missing the following fields: \"" + missingFields + "\"\nPlease note that the fields names are case-sensitive.");
            System.exit(-1);
        }
    }

    private void createDocumentsFromData() {

        String[] dataArray = null;
        byte[] pdfData = null;
        StringBuffer processedNames = new StringBuffer();
        int processedCount = 0;
        for (int i=0; i<this.dataList.size(); i++) {
            dataArray = (String[])dataList.get(i);
            pdfData = generateTemplate(dataArray, this.employeePasswordArray[i]);
            saveDocument(pdfData, this.fileNameArray[i]);
            if (i==0) {
                processedNames.append("Generated the files in [" + targetDirName + "] directory.\n");
            }
            processedNames.append(this.fileNameArray[i]);
            processedNames.append("\n");
            processedCount++;
        }
        System.out.println("\n\n\nFinal Report :::");
        System.out.println("Total Files Generated = " + processedCount + ".");
        System.out.println(processedNames.toString());

        if (this.generatePdfProperties.getProperty("SEND_EMAIL").equals("true")) {
            emailDocument();
        }
    }

    private void readDataFile() {
        FileReader fr = null;
        BufferedReader br = null;
        HashMap dataMap = new HashMap();
        int lineCounter = 0;
        int numElementsInHeader = 0;
        int numElementsInData = 0;
        double tempNumber = 0d;
        try {
            File dataFile = new File(this.dataFileName);
            if (!dataFile.exists()) {
                throw new FileNotFoundException ("'" + this.dataFileName + "' does not exist");
            }
            fr = new FileReader(this.dataFileName);
            br = new BufferedReader(fr);
            String thisLine = null;
            StringTokenizer strTok = null;
            ArrayList tempDataList = null;
            ArrayList emailAddressList = new ArrayList();
            ArrayList fileNameList = new ArrayList();
            ArrayList employeeNameList = new ArrayList();
            ArrayList employeePasswordList = new ArrayList();
            String[] tempDataArray = null;
            String textElement = null;
            while ((thisLine = br.readLine()) != null) {
                lineCounter++;

                if (thisLine.replace(",","").trim().equals("")) {
                    continue;
                }

                strTok = new StringTokenizer(thisLine, ",");
                tempDataList = new ArrayList();
                while (strTok.hasMoreElements()) {
                    textElement = (String)strTok.nextElement();
                    tempDataList.add(textElement.trim());
                }
                if (lineCounter == 1) {
                    this.headerArray = (String[])tempDataList.toArray(new String[0]);
                    numElementsInHeader = this.headerArray.length;

                    for (int i=0; i<numElementsInHeader; i++) {
                        if (headerArray[i].contains("Employee-Id")) {
                            headerArray[i] = "Employee-Id";
                        }
                    }
                } else {
                    tempDataArray = (String[])tempDataList.toArray(new String[0]);
                    numElementsInData = tempDataArray.length;
                    if (numElementsInData != numElementsInHeader) {
                        throw new Exception("Columns Mismatch. Line # " + (lineCounter-1) + " has " + tempDataArray.length + " values, while header has " + numElementsInHeader + " values. \nPossible reason could be empty values or empty cells.");
                    }
                    String employeeId = null;
                    String employeeName = null;
                    String emailAddress = null;
                    String pan = null;
                    for (int i=0; i<numElementsInData; i++) {
                        if (!headerArray[i].contains("Employee-Id") && !headerArray[i].contains("Address-Pin")) {
                            try {
                                tempNumber = Double.parseDouble(tempDataArray[i]);
                                if(tempNumber < 1000) {
                                    tempDataArray[i] = formatNumber("###", tempNumber);
                                } else {
                                    double hundreds = tempNumber % 1000;
                                    int other = (int) (tempNumber / 1000);
                                    tempDataArray[i] = formatNumber(",##", other) + ',' + formatNumber("000", hundreds);
                                }
                            } catch (NumberFormatException nfe) {
                                // do nothing
                            }
                        }
                        if (headerArray[i].contains("Email")) {
                            emailAddress = tempDataArray[i];
                        }
                        if (headerArray[i].contains("Employee-Id")) {
                            employeeId = tempDataArray[i];
                        }
                        if (headerArray[i].contains("Employee-Name")) {
                            employeeName = tempDataArray[i];
                        }
                        if (headerArray[i].contains("PAN")) {
                            pan = tempDataArray[i];
                        }

                    }
                    emailAddressList.add(emailAddress);
                    employeeNameList.add(employeeName);
                    fileNameList.add(employeeId + "_" + employeeName + ".pdf");
                    employeePasswordList.add(pan);
                    this.dataList.add(tempDataArray);
                }
            }
            this.emailAddressArray = (String[]) emailAddressList.toArray(new String[0]);
            this.fileNameArray = (String[]) fileNameList.toArray(new String[0]);
            this.employeeNameArray = (String[]) employeeNameList.toArray(new String[0]);
            this.employeePasswordArray = (String[]) employeePasswordList.toArray(new String[0]);

        } catch (FileNotFoundException fnfe) {
            System.out.println("****** Not able to load data file '" + dataFileName + "' ******");
            System.out.println("Error is :: " + fnfe.getMessage());
            System.out.println("\nMore details on the error provided below:");
            fnfe.printStackTrace();
            System.exit(-1);
        } catch (IOException ioe) {
            System.out.println("****** Not able to read from data file '" + dataFileName + "' ******");
            System.out.println("Error is :: " + ioe.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ioe.printStackTrace();
            System.exit(-1);
        } catch (Exception ex) {
            System.out.println("****** Error in processing data file '" + dataFileName + "' ******");
            System.out.println("Error is :: " + ex.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ex.printStackTrace();
            System.exit(-1);
        }
    }

    private void loadTemplateFile() {

        try {
            //Load the stylesheet
            Templates templates = T_FACTORY.newTemplates(new StreamSource(new File(this.templateFileName)));
            this.transformer = templates.newTransformer();
        } catch (TransformerConfigurationException tce) {
            System.out.println("****** Not able to load stylesheet '" + this.templateFileName + "' ******");
            System.out.println("Error is :: " + tce.getMessage());
            System.out.println("\nMore details on the error provided below:");
            tce.printStackTrace();
            System.exit(-1);
        }
    }

    private byte[] generateTemplate(String[] dataArray, String employeePassword) {

        ByteArrayOutputStream out = null;
        byte[] pdfData = null;
        Fop fop = null;
        File xmlFile = null;

        String generateDateString = this.generatePdfProperties.getProperty("GENERATE_DATE");
        String effectiveDateString = this.generatePdfProperties.getProperty("EFFECTIVE_DATE");
        String watermark = this.generatePdfProperties.getProperty("WATERMARK");
        String pdfAdminPasswordEncoded = this.generatePdfProperties.getProperty("PDF_ADMIN_PASSWORD");
        Base64.Decoder decoder = Base64.getDecoder();
        String pdfAdminPassword = new String(decoder.decode(pdfAdminPasswordEncoded));

        try {
            xmlFile = new File("in.xml");
            if (!xmlFile.exists()) {
                throw new FileNotFoundException ("The dummy XML not found");
            }
            out = new ByteArrayOutputStream();

            FOUserAgent foUserAgent = FOP_FACTORY.newFOUserAgent();
            foUserAgent.getRendererOptions().put("encryption-params", new PDFEncryptionParams(
                employeePassword, pdfAdminPassword, true, false, false, false, false));

            fop = FOP_FACTORY.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

            double tempNumber = 0;
            String formattedValue = null;
            for (int i=0; i<headerArray.length; i++) {
                this.transformer.setParameter(headerArray[i], dataArray[i]);
            }
            this.transformer.setParameter("Generate-Date", generateDateString);
            this.transformer.setParameter("Effective-Date", effectiveDateString);
            this.transformer.setParameter("Watermark", watermark);
            this.transformer.transform(new StreamSource(xmlFile), new SAXResult(fop.getDefaultHandler()));

            pdfData = out.toByteArray();
        } catch (FOPException fope) {
            System.out.println("****** Error loading FOP (PDF Creation) Utility ******");
            System.out.println("Error is :: " + fope.getMessage());
            System.out.println("\nMore details on the error provided below:");
            fope.printStackTrace();
            System.exit(-1);
        } catch (TransformerException te) {
            System.out.println("****** Error generating PDF ******");
            System.out.println("Error is :: " + te.getMessage());
            System.out.println("\nMore details on the error provided below:");
            te.printStackTrace();
            System.exit(-1);
        } catch (FileNotFoundException fnfe) {
            System.out.println("****** Error loading the dummy XML file in.xml. Make sure it is in the same location as this executable. ******");
            System.out.println("Error is :: " + fnfe.getMessage());
            System.out.println("\nMore details on the error provided below:");
            fnfe.printStackTrace();
            System.exit(-1);
        } catch (Exception ex) {
            System.out.println("****** Error generating Template ******");
            System.out.println("Error is :: " + ex.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ex.printStackTrace();
            System.exit(-1);
        }
        return pdfData;
    }

    private void saveDocument(byte[] pdfData, String fileName) {
        FileOutputStream fos = null;
        BufferedOutputStream bos = null;
        String fileNameWithPath = null;
        try {
            fileNameWithPath = this.targetDirName + "/" + fileName;
            File targetDir = new File(this.targetDirName);
            if (!targetDir.exists()) {
                throw new Exception ("'" + this.targetDirName + "' does not exist");
            }
            if (!targetDir.isDirectory()) {
                throw new Exception ("'" + this.targetDirName + "' is not a directory");
            }
            fos = new FileOutputStream(fileNameWithPath);
            bos = new BufferedOutputStream(fos);
            bos.write(pdfData, 0, pdfData.length);
        } catch (Exception ex) {
            System.out.println("****** Not able to write to file '" + fileName + "' ******");
            System.out.println("Error is :: " + ex.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ex.printStackTrace();
            System.exit(-1);
        } finally {
            if (bos!=null) {
                try { bos.close(); }catch (IOException ioe) {}
            }
            if (fos!=null) {
                try { fos.close(); }catch (IOException ioe) {}
            }
        }
    }

    private static String formatNumber(String pattern, Object value) {
        return new DecimalFormat(pattern).format(value);
    }


    private void emailDocument() {

        System.out.println("About to send email.... ");
        Properties prop = System.getProperties();
        prop.put("mail.smtp.host", this.generatePdfProperties.getProperty("SMTP_HOST"));
        prop.put("mail.smtp.port", this.generatePdfProperties.getProperty("SMTP_PORT"));
        prop.put("mail.smtp.starttls.enable", this.generatePdfProperties.getProperty("SMTP_STARTTLS_ENABLE"));
        prop.put("mail.smtp.auth", this.generatePdfProperties.getProperty("SMTP_AUTH"));
        prop.put("mail.debug", this.generatePdfProperties.getProperty("DEBUG"));

        String password = null;

        Session session = Session.getInstance(prop, null);
        String fileNameWithPath = null;
        String emailAddress = null;
        String employeeName = null;
        String messageText = null;
        String effectiveDate = this.generatePdfProperties.getProperty("EFFECTIVE_DATE");
        try {
            String encodedPassword = this.generatePdfProperties.getProperty("PASSWORD");
            Base64.Decoder decoder = Base64.getDecoder();
            password = new String(decoder.decode(encodedPassword));
        } catch (Exception ex) {
            System.out.println("****** Password decryption failed for '" + this.generatePdfProperties.getProperty("USERNAME") + "' ******");
            System.out.println("Error is :: " + ex.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ex.printStackTrace();
            System.exit(-1);
        }

        try {
            Message msg = null;

            for (int i=0; i<this.emailAddressArray.length; i++) {
                fileNameWithPath = this.targetDirName + "/" + this.fileNameArray[i];
                emailAddress = this.emailAddressArray[i];
                employeeName = this.employeeNameArray[i];

                msg = new MimeMessage(session);
                msg.setFrom(new InternetAddress(this.generatePdfProperties.getProperty("USERNAME")));
                msg.setSubject(this.generatePdfProperties.getProperty("EMAIL_SUBJECT"));
                msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailAddress, false));

                // text
                MimeBodyPart p1 = new MimeBodyPart();

                messageText = this.generatePdfProperties.getProperty("EMAIL_TEXT");
                messageText = messageText.replace("[Employee-Name]", employeeName);
                messageText = messageText.replace("[Effective-Date]", effectiveDate);
                p1.setText(messageText, "UTF-8", "html");

                // file
                MimeBodyPart p2 = new MimeBodyPart();
                FileDataSource fds = new FileDataSource(fileNameWithPath);
                p2.setDataHandler(new DataHandler(fds));
                p2.setFileName(fds.getName());

                Multipart mp = new MimeMultipart();
                mp.addBodyPart(p1);
                mp.addBodyPart(p2);

                msg.setContent(mp);

                SMTPTransport t = (SMTPTransport) session.getTransport("smtp");

                // connect
                t.connect(this.generatePdfProperties.getProperty("SMTP_HOST"),
                            this.generatePdfProperties.getProperty("USERNAME"),
                            password);

                // send
                t.sendMessage(msg, msg.getAllRecipients());
                t.close();
                System.out.println("Email sent to [" + emailAddress + "] with file [" + fileNameWithPath + "]");
            }

        } catch (MessagingException me) {
            System.out.println("****** Email send failed for '" + emailAddress + "' ******");
            System.out.println("Error is :: " + me.getMessage());
            System.out.println("\nMore details on the error provided below:");
            me.printStackTrace();
            System.exit(-1);
        }
    }

    private void loadGeneratePdfProperties() {

        String propFile = "generatepdf.properties";
        try {
            InputStream input = new FileInputStream(propFile);

            generatePdfProperties = new Properties();

            // load a properties file
            generatePdfProperties.load(input);

            // validate if all required entries are present
            validatePropertyPresent("GENERATE_DATE");
            validatePropertyPresent("EFFECTIVE_DATE");
            validatePropertyPresent("WATERMARK");
            validatePropertyPresent("SEND_EMAIL");
            validatePropertyPresent("SMTP_HOST");
            validatePropertyPresent("SMTP_PORT");
            validatePropertyPresent("SMTP_STARTTLS_ENABLE");
            validatePropertyPresent("SMTP_AUTH");
            validatePropertyPresent("DEBUG");
            validatePropertyPresent("PDF_ADMIN_PASSWORD");
            validatePropertyPresent("USERNAME");
            validatePropertyPresent("PASSWORD");
            validatePropertyPresent("EMAIL_SUBJECT");
            validatePropertyPresent("EMAIL_TEXT");

        } catch (FileNotFoundException fnfe) {
            System.out.println("****** Not able to load data file '" + propFile + "'. Please ensure the file is in the same directory as you are executing the program. ******");
            System.out.println("Error is :: " + fnfe.getMessage());
            System.out.println("\nMore details on the error provided below:");
            fnfe.printStackTrace();
            System.exit(-1);
        } catch (IOException ioe) {
            System.out.println("****** Not able to load data file '" + propFile + "'. Please ensure the file is in the same directory as you are executing the program. ******");
            System.out.println("Error is :: " + ioe.getMessage());
            System.out.println("\nMore details on the error provided below:");
            ioe.printStackTrace();
            System.exit(-1);
        }
    }

    private void validatePropertyPresent(String propertyName) {
        if (generatePdfProperties.getProperty(propertyName) == null) {
            System.out.println("****** Not able to find entry '" + propertyName + "' in the properties file. Please add the entry with the right value. ******");
            System.exit(-1);
        }

    }

/*
    public class DataObject {

        private String emailAddress;
        private DataElements[] dataElementsArray;

        public DataObject() {
        }

        public void setEmailAddress(String _emailAddress) {
            this.emailAddress = _emailAddress;
        }

        public String getEmailAddress() {
            return this.emailAddress;
        }

        public void setDataElements(DataElements[] _dataElementsArray) {
            this.dataElementsArray = _dataElementsArray;
        }

        public DataElements[] getDataElements() {
            return this.dataElementsArray;
        }
    }

    public class DataElements {
        private String header;
        private String value;

        public DataElements() {
        }

        public void setHeader(String _header) {
            this.header = _header;
        }

        public String getHeader() {
            return this.header;
        }

        public void setValue(String _value) {
            this.value = _value;
        }

        public String getValue() {
            return this.value;
        }

    }
*/

}