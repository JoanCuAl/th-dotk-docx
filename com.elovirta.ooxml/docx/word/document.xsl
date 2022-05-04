<?xml version="1.0" encoding="UTF-8"?>
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
               xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
               xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"
               xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"
               xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main"
               xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
               xmlns:opentopic="http://www.idiominc.com/opentopic"
               xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
               xmlns:x="com.elovirta.ooxml"
               exclude-result-prefixes="x xs opentopic opentopic-index ot-placeholder"
               version="2.0">

  <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
  <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>

  <xsl:import href="document.utils.xsl"/>
  <xsl:import href="document.topic.xsl"/>
  <xsl:import href="document.abbrev-d.xsl"/>
  <xsl:import href="document.hi-d.xsl"/>
  <xsl:import href="document.markup-d.xsl"/>
  <xsl:import href="document.pr-d.xsl"/>
  <xsl:import href="document.sw-d.xsl"/>
  <xsl:import href="document.ui-d.xsl"/>
  <xsl:import href="document.xml-d.xsl"/>
  <xsl:import href="document.toc.xsl"/>
  <xsl:import href="document.table.xsl"/>
  <xsl:import href="document.task.xsl"/>
  <xsl:import href="document.link.xsl"/>
  <xsl:import href="document.mathml-d.xsl"/>
  <xsl:import href="document.mml.xsl"/>
  <xsl:import href="document.root.xsl"/>

  <xsl:output indent="no"/>

  <xsl:param name="input.dir.url"/>
  <xsl:param name="debug" as="xs:boolean?" select="false()"/>
  
  <!-- Tradeheader Update Cover -->
  <!-- Desc: Aknowledge docx.cover.file parameter in this cope and creates custom.cover if the resource exists. -->
  <!--<xsl:param name="docx.cover.file"/>-->
  
  <!-- Tradeheader Update No Bold Footnotes -->
  <!-- Desc: Aknowledge docx.bold.footnotes parameter in this scope. -->
  <xsl:param name="docx.bold.footnotes"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.toc parameter in this scope. -->
  <xsl:param name="docx.toc"/>

  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.toc.mode parameter in this scope. -->
  <xsl:param name="docx.toc.mode"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.indexOfTerms parameter in this scope. -->
  <xsl:param name="docx.indexOfTerms"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableSpacing.before parameter in this scope. -->
  <xsl:param name="docx.tableSpacing.before"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableSpacing.after parameter in this scope. -->
  <xsl:param name="docx.tableSpacing.after"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableIdent.value parameter in this scope. -->
  <xsl:param name="docx.tableIdent.value"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableIdent.type parameter in this scope. -->
  <xsl:param name="docx.tableIdent.type"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableWidth.value parameter in this scope. -->
  <xsl:param name="docx.tableWidth.value"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableWidth.type parameter in this scope. -->
  <xsl:param name="docx.tableWidth.type"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableColWidth.source parameter in this scope. -->
  <xsl:param name="docx.tableColWidth.source"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableTheadVerticalAligment parameter in this scope. -->
  <xsl:param name="docx.tableTheadVerticalAligment"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableTbody.cantSplit parameter in this scope. -->
  <xsl:param name="docx.tableTbody.cantSplit"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.tableThead.cantSplit parameter in this scope. -->
  <xsl:param name="docx.tableThead.cantSplit"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.configFile parameter in this scope. -->
  <!--<xsl:param name="docx.configFile"/>-->
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.publication parameter in this scope. -->
  <xsl:param name="docx.publication"/>
  
  <!-- Tradeheader Update -->
  <!-- Desc: Aknowledge docx.publication parameter in this scope. -->
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
  
  <xsl:param name="custom.cover" as="document-node()?">
	<xsl:variable name="docx.coverFile" select="concat(concat(concat($dita.dir,'/plugins/com.elovirta.ooxml/resources/'),$docx.publication),'_cover.xml')"/>
	<xsl:choose>
		<xsl:when test="string-length($docx.coverFile) = 0"/>
		<xsl:when test="starts-with($docx.coverFile, 'file')">
			<xsl:copy-of select="document($docx.coverFile, /)"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="starts-with($docx.coverFile, '/')">
					<xsl:copy-of select="document(concat('file://', $docx.coverFile), /)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="document(concat('file:/', $docx.coverFile), /)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:param>
  <!-- End of Tradeheader Update Cover -->
  
  
  <xsl:variable name="template" select="document(concat($template.dir, '/word/document.xml'))" as="document-node()?"/>
  <xsl:variable name="root" select="/" as="document-node()"/>
  <xsl:variable name="language" select="string((//@xml:lang)[1])" as="xs:string"/>

  <xsl:variable name="sectPr" select="$template/w:document/w:body/w:sectPr[last()]" as="element()"/>
  <xsl:variable name="body-width" as="xs:integer">
    <xsl:sequence select="xs:integer($sectPr/w:pgSz/@w:w) - xs:integer($sectPr/w:pgMar/@w:left) - xs:integer($sectPr/w:pgMar/@w:right)"/>
  </xsl:variable>

</xsl:stylesheet>
