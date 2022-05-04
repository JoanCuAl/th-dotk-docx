<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"
  xmlns:o="urn:schemas-microsoft-com:office:office"
  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
  xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
  xmlns:v="urn:schemas-microsoft-com:vml"
  xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
  xmlns:w10="urn:schemas-microsoft-com:office:word"
  xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
  xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:x="com.elovirta.ooxml"
  version="2.0" exclude-result-prefixes="x xs">

  <xsl:import href="document.xsl"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.publication parameter in this scope. -->
  <xsl:param name="docx.publication"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge generate_links parameter in this scope. -->
  <xsl:param name="generate_links"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge dita.dir parameter in this scope. -->
  <xsl:param name="dita.dir"/>
  
   <xsl:param name="docx.config" as="document-node()?">
     <xsl:variable name="docx.configFile" select="concat(concat(concat($dita.dir,'/plugins/com.elovirta.ooxml/resources/'),$docx.publication),'_config.xml')"/>
	<xsl:choose>
		
		<xsl:when test="string-length($docx.configFile) = 0"/>
		<xsl:when test="starts-with($docx.configFile, 'file')">
			<xsl:copy-of select="document($docx.configFile, /)"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="starts-with($docx.configFile, '/')">
					<xsl:copy-of select="document(concat('file://', $docx.configFile), /)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="document(concat('file:/', $docx.configFile), /)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:param>

	<!-- Tradeheader Update -->
	<!-- Origin: validation -->
	<!-- Output: Add post process to the spaces of the footnotes -->
	<!-- Date : 2020/03/17 -->
  <xsl:template match="/">
	<xsl:variable name="content_footnotes" as="node()*">
		<w:footnotes>
		  <w:footnote w:type="separator" w:id="-1">
			<w:p>
			  <w:pPr>
				<w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
			  </w:pPr>
			  <w:r>
				<w:separator/>
			  </w:r>
			</w:p>
		  </w:footnote>
		  <w:footnote w:type="continuationSeparator" w:id="0">
			<w:p>
			  <w:pPr>
				<w:spacing w:after="0" w:line="240" w:lineRule="auto"/>
			  </w:pPr>
			  <w:r>
				<w:continuationSeparator/>
			  </w:r>
			</w:p>
		  </w:footnote>
		  <xsl:apply-templates select="//*[contains(@class, ' topic/fn ')]"/>
		</w:footnotes>
	</xsl:variable>
	<xsl:apply-templates select="$content_footnotes" mode="whitespace"/>
  </xsl:template>
	<!-- End of Tradeheader Update -->

  <xsl:template match="*[contains(@class, ' topic/fn ')]">
    <w:footnote w:id="{@x:fn-number}">
      <xsl:variable name="contents" as="element()*" select="*"/>
      <w:p>
        <w:pPr>
          <w:pStyle w:val="FootnoteText"/>
        </w:pPr>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="FootnoteReference"/>
          </w:rPr>
          <w:footnoteRef/>
        </w:r>
        <w:r>
          <w:t xml:space="preserve"> </w:t>
        </w:r>
		<!-- Tradeheader Update -->
		<!-- Origin: validation 2021 -->
		<!-- Output: Add tabulation after footnote number to match footnote tabulation -->
		<!-- Date : 2021/05/19 -->
		<w:r>
			<w:tab/>
		</w:r>
		<!-- End of Tradeheader Update -->
        <xsl:apply-templates select="$contents[1]/node()"/>
      </w:p>
      <xsl:apply-templates select="$contents[position() ne 1]"/>
    </w:footnote>
  </xsl:template>

  <xsl:template match="node()" mode="block-style.default">
    <w:pStyle w:val="FootnoteText"/>
  </xsl:template>

</xsl:stylesheet>
