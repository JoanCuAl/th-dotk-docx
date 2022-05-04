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


	<!-- Tradeheader Update -->
    <!-- Origin: validation -->
    <!-- Output: generate an index of terms at the end of the document -->
	<!-- Date : 2021/04/21 -->
	<xsl:template match="/">
		<xsl:variable name="content" as="node()*">
			<w:document>
				<xsl:comment>external variables publication <xsl:value-of select="$docx.publication"/></xsl:comment><!-- -->
				<xsl:comment>external variables dita dir <xsl:value-of select="$dita.dir"/></xsl:comment><!-- -->
				<xsl:comment>external variables concat <xsl:value-of select="concat(concat(concat($dita.dir,'/plugins/com.elovirta.ooxml/resources/'),$docx.publication),'_config.xml')"/></xsl:comment><!-- -->
				<xsl:comment>docx.config <xsl:value-of select="$docx.config"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 1 <xsl:value-of select="$docx.config/body/docx.bold.footnotes"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 2 <xsl:value-of select="$docx.config/body/docx.indexOfTerms"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 3 <xsl:value-of select="$docx.config/body/docx.tableColWidth.source"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 4 <xsl:value-of select="$docx.config/body/docx.tableIdent.type"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 5 <xsl:value-of select="$docx.config/body/docx.tableIdent.value"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 6 <xsl:value-of select="$docx.config/body/docx.tableSpacing.after"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 7 <xsl:value-of select="$docx.config/body/docx.tableSpacing.before"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 8 <xsl:value-of select="$docx.config/body/docx.tableTbody.cantSplit"/></xsl:comment>
				<xsl:comment>external variables body variable 9 <xsl:value-of select="$docx.config/body/docx.tableThead.cantSplit"/></xsl:comment>
				<xsl:comment>external variables body variable 10 <xsl:value-of select="$docx.config/body/docx.tableTheadVerticalAligment"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 11 <xsl:value-of select="$docx.config/body/docx.tableWidth.type"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 12 <xsl:value-of select="$docx.config/body/docx.tableWidth.value"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 12 <xsl:value-of select="$docx.config/body/docx.toc"/></xsl:comment><!-- -->
				<xsl:comment>external variables body variable 12 <xsl:value-of select="$docx.config/body/docx.toc.mode"/></xsl:comment><!-- -->
				<w:body>
					<xsl:apply-templates select="*" mode="portada"/>
					<xsl:apply-templates select="*" mode="root"/>
					<xsl:if test="($docx.config/body/docx.indexOfTerms = 'true')">
						<xsl:apply-templates select="*" mode="indexEntry"/>
					</xsl:if>				
				</w:body>
			</w:document>
		</xsl:variable>
		<xsl:variable name="fixup" as="node()*">
			<xsl:apply-templates select="$content" mode="fixup">
				<xsl:with-param name="bookmarks" as="xs:string*" tunnel="yes">
					<xsl:for-each-group select="$content//w:bookmarkStart" group-by="@w:id">
						<xsl:value-of select="current-grouping-key()"/>
					</xsl:for-each-group>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:apply-templates select="$fixup" mode="whitespace"/>
	</xsl:template>
	<!-- End of Tradeheader Update -->
	
	<xsl:variable name="toc.increment-base" select="422" as="xs:integer"/>
	
	<!-- Tradeheader Extension -->
    <!-- Origin: validation -->
    <!-- Output: generate an index of terms. The objective of this template is to add a tc field in each dita term -->
	<!-- Date : 2021/04/21 -->
	<xsl:template match="*" mode="indexEntry">
		<w:p>
		  <w:r>
			<w:br w:type="page" />
		  </w:r>
		</w:p>
		<w:p>
			<w:r>
			  <w:fldChar w:fldCharType="begin"/>
			</w:r>
			<w:r>
				<w:instrText>
					<xsl:attribute name="xml:space">preserve</xsl:attribute>
					<xsl:text> INDEX \e "	"\c "2" \z "3082" </xsl:text>
				</w:instrText>
			</w:r>
			<w:r>
				<w:fldChar w:fldCharType="separate"/>
			</w:r>
			<w:pPr>
				<w:pStyle w:val="BodyText"/>
			</w:pPr>
			<w:r>
				<w:t>temporal content</w:t>
			</w:r>
			<w:r>
			  <w:fldChar w:fldCharType="end"/>
			</w:r>
		</w:p>
	</xsl:template>
	<!-- End of Tradeheader Extension -->
	
	<xsl:template match="*[contains(@class, ' map/map ')]" mode="root">
		<xsl:apply-templates select="/" mode="legal"/>
		<xsl:if test="($docx.config/body/docx.toc = 'true')">
			<xsl:apply-templates select="/" mode="toc"/>
		</xsl:if>
		<xsl:apply-templates select="." mode="body"/>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' bookmap/bookmap ')]" mode="root" priority="10">
		<xsl:apply-templates select="/" mode="cover"/>
		<xsl:apply-templates select="/" mode="legal"/>
		<xsl:apply-templates select="." mode="body"/>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' topic/topic ')]" mode="root">
		<xsl:apply-templates select="."/>
	</xsl:template>

	<xsl:variable name="body-section" as="node()*">
    <xsl:for-each select="$template/w:document/w:body/w:sectPr[position() = last()]">
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:variable>

	<xsl:template match="*[contains(@class, ' map/map ')]" mode="body">
		<xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' bookmap/bookmap ')]" mode="body" priority="10">
		<xsl:apply-templates select="ot-placeholder:toc | *[contains(@class, ' topic/topic ')]"/>
	</xsl:template>
	
	<!-- Tradeheader Extension -->
    <!-- Origin: validation -->
    <!-- Output: Copy an external cover if it has been defined. If it hasn't, generate a default one -->
	<!-- Date : 2021/04/29 -->
	<xsl:template match="*" mode="portada">
		<xsl:choose>
			<xsl:when test="exists($custom.cover/w:body/*)">
				<xsl:copy-of select="$custom.cover/w:body/w:p"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- Define a default cover if required -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- End of Tradeheader Extension -->

	<!-- Tradeheader Update -->
    <!-- Origin: 2020 IRD Definitions -->
    <!-- Target: remove Title from 2020 def documents -->
    <!-- Output: removes title -->
	<!--<xsl:template match="/" mode="cover">
		<w:p>
			<w:pPr>
				<w:pStyle w:val="Title"/>
				<w:spacing w:before="720"/>
				<w:rPr>
					<w:lang w:val="{$language}"/>
				</w:rPr>
			</w:pPr>
			<w:r>
				<w:fldChar w:fldCharType="begin"/>
			</w:r>
			<w:r>
				<w:rPr>
					<w:lang w:val="{$language}"/>
				</w:rPr>
				<w:instrText xml:space="preserve">TITLE \* MERGEFORMAT</w:instrText>
			</w:r>
			<w:r>
				<w:fldChar w:fldCharType="separate"/>
			</w:r>
			<w:r>
				<w:rPr>
					<w:lang w:val="{$language}"/>
				</w:rPr>
				<w:t>
					<xsl:call-template name="get-title"/>
				</w:t>
			</w:r>
			<w:r>
				<w:fldChar w:fldCharType="end"/>
			</w:r>
		</w:p>
	</xsl:template>-->
	<!-- End of Tradeheader Update -->
	<xsl:template match="/" mode="legal"/>

	<xsl:template name="get-title">
		<xsl:for-each select="/*[contains(@class, ' map/map ')]">
			<xsl:choose>
				<xsl:when test="@title">
					<xsl:value-of select="@title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="opentopic:map">
						<xsl:choose>
							<xsl:when test="*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]">
								<xsl:apply-templates select="*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]/node()"/>                
							</xsl:when>
							<xsl:when test="*[contains(@class, 'topic/title ')]">
								<xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/>                
							</xsl:when>
						</xsl:choose>            
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
