# Document-Generation
A simple code to help with auto generation of documents. Example: Many micro and small companies do not have to buy a costly license, instead can use this code to generate salary revision or offer letters. Can be easily customized to suit any needs 

# Steps to Execute
The required third party libraries are added to the lib folder
1. Execute the setenv.bat to add required libraries to classpath
2. Execute as follows: java GeneratePDF templates/revision-template.xsl data/Data.csv output  

# Properties file
Some of the control variables are also there in the generatepdf.properties
This code can also automate and send email.
Set SEND_EMAIL=true and modify the SMTP and EMAIL CREDENTIALS
Set WATERMARK=false or true to denote the pdf is a draft vs. final copy

# Set PDF Password
The pdf by default is password protected. There are two passwords - admin and user password
Admin password is set in generatepdf.properties (Key = PDF_ADMIN_PASSWORD). Admin password should not be shared with users
User password is picked from PAN and hardcoded in code
User password avoids copy content from the PDF. Admin password provides all control.

# For simple customization
1. The template or xsl file contains the template rules for PDF generation - the static text, margins, header, footer details, etc. Modify the static content directly here 
2. If there is a change to the data available in csv file, 
   - The column names modified / added / deleted should be updated in the Generatepdf.java file in validateAllValuesPresent() method
   - The column names should match in the xsl file in the <xsl:param></xsl:param> and <xsl:call-template name="generate"> sections
   - Finally the column names should be the same in the exact places where it is supposed to be used

# For larger customizations
Code change may be required

