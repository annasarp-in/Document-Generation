<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" indent="yes"/>
  <xsl:param name="Generate-Date" select="'Not Available'"/>
  <xsl:param name="Effective-Date" select="'Not Available'"/>
  <xsl:param name="Watermark" select="'Not Available'"/>
  <xsl:param name="Employee-Id" select="'Not Available'"/>
  <xsl:param name="Employee-Name" select="'Not Available'"/>
  <xsl:param name="Designation" select="'Not Available'"/>
  <xsl:param name="Is-Promoted" select="'Not Available'"/>
  <xsl:param name="Last-Year-Performance-Bonus" select="'Not Available'"/>
  <xsl:param name="Basic-Monthly" select="'Not Available'"/>
  <xsl:param name="Telephone-Reimbursements-Monthly" select="'Not Available'"/>
  <xsl:param name="HRA-Monthly" select="'Not Available'"/>
  <xsl:param name="Food-Allowance-Monthly" select="'Not Available'"/>
  <xsl:param name="Special-Allowance-Monthly" select="'Not Available'"/>
  <xsl:param name="Total-Fixed-Salary-Monthly" select="'Not Available'"/>
  <xsl:param name="PF-Monthly" select="'Not Available'"/>
  <xsl:param name="Total-Monthly" select="'Not Available'"/>
  <xsl:param name="Basic-Annual" select="'Not Available'"/>
  <xsl:param name="Education-Allowance-Annual" select="'Not Available'"/>
  <xsl:param name="Telephone-Reimbursements-Annual" select="'Not Available'"/>
  <xsl:param name="HRA-Annual" select="'Not Available'"/>
  <xsl:param name="Food-Allowance-Annual" select="'Not Available'"/>
  <xsl:param name="Special-Allowance-Annual" select="'Not Available'"/>
  <xsl:param name="Total-Fixed-Salary-Annual" select="'Not Available'"/>
  <xsl:param name="Performance-Bonus-Annual" select="'Not Available'"/>
  <xsl:param name="PF-Annual" select="'Not Available'"/>
  <xsl:param name="Total-Annual" select="'Not Available'"/>
  <xsl:template match="/">
    <xsl:call-template name="generate">
      <xsl:with-param name="Generate-Date" select="$Generate-Date"/>
      <xsl:with-param name="Effective-Date" select="$Effective-Date"/>
      <xsl:with-param name="Watermark" select="$Watermark"/>
      <xsl:with-param name="Employee-Id" select="$Employee-Id"/>
      <xsl:with-param name="Employee-Name" select="$Employee-Name"/>
      <xsl:with-param name="Designation" select="$Designation"/>
      <xsl:with-param name="Is-Promoted" select="$Is-Promoted"/>
      <xsl:with-param name="Last-Year-Performance-Bonus" select="$Is-Promoted"/>
      <xsl:with-param name="Basic-Monthly" select="$Basic-Monthly"/>
      <xsl:with-param name="Telephone-Reimbursements-Monthly" select="$Telephone-Reimbursements-Monthly"/>
      <xsl:with-param name="HRA-Monthly" select="$HRA-Monthly"/>
      <xsl:with-param name="Food-Allowance-Monthly" select="$Food-Allowance-Monthly"/>
      <xsl:with-param name="Special-Allowance-Monthly" select="$Special-Allowance-Monthly"/>
      <xsl:with-param name="Total-Fixed-Salary-Monthly" select="$Total-Fixed-Salary-Monthly"/>
      <xsl:with-param name="PF-Monthly" select="$PF-Monthly"/>
      <xsl:with-param name="Total-Monthly" select="$Total-Monthly"/>
      <xsl:with-param name="Basic-Annual" select="$Basic-Annual"/>
      <xsl:with-param name="Education-Allowance-Annual" select="$Education-Allowance-Annual"/>
      <xsl:with-param name="Telephone-Reimbursements-Annual" select="$Telephone-Reimbursements-Annual"/>
      <xsl:with-param name="HRA-Annual" select="$HRA-Annual"/>
      <xsl:with-param name="Food-Allowance-Annual" select="$Food-Allowance-Annual"/>
      <xsl:with-param name="Special-Allowance-Annual" select="$Special-Allowance-Annual"/>
      <xsl:with-param name="Total-Fixed-Salary-Annual" select="$Total-Fixed-Salary-Annual"/>
      <xsl:with-param name="Performance-Bonus-Annual" select="$Performance-Bonus-Annual"/>
      <xsl:with-param name="PF-Annual" select="$PF-Annual"/>
      <xsl:with-param name="Total-Annual" select="$Total-Annual"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="generate" match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4-portrait" page-height="29.7cm" page-width="21.0cm">
          <xsl:choose>
            <xsl:when test="$Watermark='true'">
              <fo:region-body region-name="xsl-region-body" margin-bottom="4cm" margin-top="5cm" margin-left="2cm" margin-right="2cm" background-position-horizontal="right" background-image="./images/watermark.png"  background-repeat="no-repeat"/>
            </xsl:when>
            <xsl:otherwise>
              <fo:region-body region-name="xsl-region-body" margin-bottom="4cm" margin-top="5cm" margin-left="2cm" margin-right="2cm"/>
            </xsl:otherwise>
          </xsl:choose>
          <fo:region-before region-name="xsl-region-before" extent="5cm"/>
          <fo:region-after region-name="xsl-region-after" extent="2.5cm"/>
          <fo:region-end region-name="xsl-region-end" extent="1cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="A4-portrait">
        <fo:static-content flow-name="xsl-region-before">
          <fo:table>
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell>
                  <fo:block text-align="left">
                    <fo:external-graphic src="url('images/short-logo.png')" content-height="scale-to-fit" height="100px" scaling="uniform">
                    </fo:external-graphic>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block text-align="right">
                     <fo:external-graphic src="url('images/logo.png')" content-height="scale-to-fit" height="45px" scaling="uniform">
                    </fo:external-graphic>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="center" font-size="10pt" font-family="sans-serif" color="#666666" font-weight="bold" space-before="2mm">
            XYZ Pvt. Ltd.
          </fo:block>
          <fo:block text-align="center" font-size="10pt" font-family="sans-serif" color="#666666" font-weight="none" space-before="2mm">
            Address Line 1 | Address Line 2 | City | State | Country
          </fo:block>
          <fo:block text-align="center" font-size="10pt" font-family="sans-serif" color="#666666" font-weight="none" space-before="2mm">
            Phone: xxx-xxxxxxxx | contact@xyz.com | www.xyz.com 
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-end">
          <fo:block-container reference-orientation="90" height="29.7cm" padding="2pt"> 
            <fo:block text-align="center" vertical-align="top">
              <fo:external-graphic display-align="center" src="url('images/www.xyz.com.png')" content-height="scale-to-fit" height="20px" scaling="uniform"/>
            </fo:block>
          </fo:block-container>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="5mm">
            <xsl:value-of select="$Generate-Date"/>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="4mm">
            Employee Name: <xsl:value-of select="$Employee-Name"/>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="4mm">
            Employee ID: <xsl:value-of select="$Employee-Id"/>
          </fo:block>
          <fo:block text-align="center" font-size="12pt" font-family="sans-serif" color="black" font-weight="bold" text-decoration="underline" space-before="8mm">
            Salary Revision Letter 
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="8mm">
            Dear <xsl:value-of select="$Employee-Name"/>,
          </fo:block>
          <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
            This year has been eventful and challenging for all of us; we are pleased to announce that we have done very well in terms of customer appreciation, competency development and the over-all business. This was possible only because of your efforts, time and commitment towards fulfilling our work goals. We take this opportunity to thank you for all the effort rendered for XYZ and extended support from your family.
          </fo:block>
          <xsl:if test="($Is-Promoted='N') and (($Last-Year-Performance-Bonus='0') or ($Last-Year-Performance-Bonus=''))">
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              Based on your performance and in line with the market trend, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Offer Letter will remain unchanged.
            </fo:block>
          </xsl:if>
          <xsl:if test="($Is-Promoted='N') and (($Last-Year-Performance-Bonus!='0') and ($Last-Year-Performance-Bonus!=''))">
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              Based on your performance and in line with the market trend, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Offer Letter will remain unchanged.
            </fo:block>
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              Once again, we deeply appreciate your contributions towards XYZ’s performance in the FY 2019 – 2020 and are pleased to inform that you have been provided with the one - time performance bonus of <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Last-Year-Performance-Bonus"/>/-</fo:inline> for the FY 2019 – 2020.
            </fo:block>
          </xsl:if>
          <xsl:if test="($Is-Promoted='Y') and (($Last-Year-Performance-Bonus='0') or ($Last-Year-Performance-Bonus=''))">
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              We are hereby glad to inform you that you have been promoted as <fo:inline font-weight="bold"><xsl:value-of select="$Designation"/></fo:inline> and based on your performance, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Appointment Letter will remain unchanged.
            </fo:block>
          </xsl:if>
          <xsl:if test="($Is-Promoted='Y') and (($Last-Year-Performance-Bonus!='0') and ($Last-Year-Performance-Bonus!=''))">
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              We are hereby glad to inform you that you have been promoted as <fo:inline font-weight="bold"><xsl:value-of select="$Designation"/></fo:inline> and based on your performance, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Appointment Letter will remain unchanged.
            </fo:block>
            <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
              Once again, we deeply appreciate your contributions towards XYZ’s performance in the FY 2019 – 2020 and are pleased to inform that you have been provided with the one - time performance bonus of <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Last-Year-Performance-Bonus"/>/-</fo:inline> for the FY 2019 – 2020.
            </fo:block>
          </xsl:if>
          <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
            We look forward to your continued support in helping us to realize our organization goals and hope for you to reach new heights in your career.
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="8mm">
            Yours sincerely,
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="1mm">
            For XYZ Pvt. Ltd.
          </fo:block>
          <fo:block text-align="left" space-before="1mm">
            <fo:external-graphic src="url('images/signature.png')" content-height="scale-to-fit" height="30px" scaling="uniform">
            </fo:external-graphic>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="2mm">
            Alpha Man
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="2mm">
            Vice President
          </fo:block>
          <fo:block text-align="center" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="5mm" page-break-before="always">
            Annexure-A
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="5mm">
            Employee Name: <xsl:value-of select="$Employee-Name"/>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="4mm">
            Employee ID: <xsl:value-of select="$Employee-Id"/>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" space-before="4mm">
            Designation: <xsl:value-of select="$Designation"/>
          </fo:block>
          <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" space-before="5mm">
            <fo:table>
              <fo:table-body>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm" width="80mm">
                    <fo:block text-align="center" font-weight="bold">
                      Description
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm" width="45mm">
                    <fo:block text-align="center" font-weight="bold">
                      Monthly (Rs.)
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm" width="45mm">
                    <fo:block text-align="center" font-weight="bold">
                      Annually (Rs.)
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-weight="bold">
                      Basic
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-weight="none">
                      <xsl:value-of select="$Basic-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-weight="none">
                      <xsl:value-of select="$Basic-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-weight="bold">
                      Education Allowance
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-weight="none">
                      
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-weight="none">
                      <xsl:value-of select="$Education-Allowance-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Telephone Reimbursements
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Telephone-Reimbursements-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Telephone-Reimbursements-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-weight="bold">
                      House Rent Allowance
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-weight="none" >
                      <xsl:value-of select="$HRA-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$HRA-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Food Allowance
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Food-Allowance-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Food-Allowance-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Special Allowance
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Special-Allowance-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Special-Allowance-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Total Fixed Salary
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Total-Fixed-Salary-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Total-Fixed-Salary-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Performance Bonus*
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >

                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Performance-Bonus-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Employer PF Contribution
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$PF-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$PF-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="left" font-size="11pt" font-family="sans-serif" color="black" font-weight="bold" >
                      Total CTC
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Total-Monthly"/>
                    </fo:block>
                  </fo:table-cell>
                  <fo:table-cell border="solid 0.1mm black" padding="1mm">
                    <fo:block text-align="right" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" >
                      <xsl:value-of select="$Total-Annual"/>
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:block>
          <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="6mm" line-height="6mm">
            <fo:inline font-weight="bold">*Performance Bonus</fo:inline>: Performance amount may be higher, lower, or nil as per the terms described herein. The bonus program is discretionary based on the Individual’s and Company’s performance and is subject to change. The performance bonus will be paid on a quarterly basis. You will not be eligible for performance bonus if you are serving notice period or have exited the Company at the time of payout.
          </fo:block>
          <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="6mm" line-height="6mm">
            In addition to the above-mentioned pay compensation, you are eligible to avail following benefits at no extra cost:
          </fo:block>
          <fo:list-block space-before="6mm" provisional-distance-between-starts="10cm" provisional-label-separation="10cm">
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>•</fo:block>
              </fo:list-item-label>
              <fo:list-item-body>
                <fo:block start-indent="5mm" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="6mm" line-height="6mm">Term Life Insurance coverage of 5 times of your Current Compensation</fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>•</fo:block>
              </fo:list-item-label>
              <fo:list-item-body>
                <fo:block start-indent="5mm" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="6mm" line-height="6mm">Group Personal Accidental Coverage of Rs.15,00,000/- Per annum</fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label>
                <fo:block>•</fo:block>
              </fo:list-item-label>
              <fo:list-item-body>
                <fo:block start-indent="5mm" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="6mm" line-height="6mm">
                  Group Medical Insurance Coverage of Rs.5,00,000/- for Self, Spouse and 2 Children defined by the organization policy
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
<!--
  <xsl:template name="revision-salary-template" match="/">
    <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
      Based on your performance and in line with the market trend, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Offer Letter will remain unchanged.
    </fo:block>
  </xsl:template>
  <xsl:template name="revision-salary-promotion-template" match="/">
    <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
      We are hereby glad to inform you that you have been promoted as <fo:inline font-weight="bold"><xsl:value-of select="$Designation"/></fo:inline> and based on your performance, your Annual Total Compensation has been revised to <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Total-Annual"/>/-</fo:inline> effective <xsl:value-of select="$Effective-Date"/>. A detailed break up of your remuneration is presented in Annexure-A. All other terms &amp; conditions of your Appointment Letter will remain unchanged.
    </fo:block>
  </xsl:template>
  <xsl:template name="bonus-template" match="/">
    <fo:block text-align="justify" font-size="11pt" font-family="sans-serif" color="black" font-weight="none" space-before="5mm" line-height="6mm">
      Once again, we deeply appreciate your contributions towards XYZ company's performance in the FY 2019 – 2020 and are pleased to inform that you have been provided with the one - time performance bonus of <fo:inline font-weight="bold">Rs. <xsl:value-of select="$Performance-Bonus-Annual"/>/-</fo:inline> for the FY 2019 – 2020.
    </fo:block>
  </xsl:template>
  <xsl:template name="revision-salary-bonus-template" match="/">
    <xsl:call-template name="revision-salary-template">
      <xsl:with-param name="Total-Annual" select="$Total-Annual"/>
      <xsl:with-param name="Effective-Date" select="$Effective-Date"/>
    </xsl:call-template>
    <xsl:call-template name="bonus-template">
      <xsl:with-param name="Performance-Bonus-Annual" select="$Performance-Bonus-Annual"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="revision-salary-promotion-bonus-template" match="/">
    <xsl:call-template name="revision-salary-promotion-template">
      <xsl:with-param name="Total-Annual" select="$To tal-Annual"/>
      <xsl:with-param name="Effective-Date" select="$Effective-Date"/>
      <xsl:with-param name="Designation" select="$Designation"/>
    </xsl:call-template>
    <xsl:call-template name="bonus-template">
      <xsl:with-param name="Performance-Bonus-Annual" select="$Performance-Bonus-Annual"/>
    </xsl:call-template>
  </xsl:template>
-->  
</xsl:stylesheet>