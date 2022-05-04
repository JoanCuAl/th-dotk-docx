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
               xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
               xmlns:opentopic="http://www.idiominc.com/opentopic"
               xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
               xmlns:x="com.elovirta.ooxml"
               exclude-result-prefixes="x xs opentopic opentopic-index ot-placeholder"
               version="2.0">

	<!-- Tradeheader Update -->
	<!-- Document : 2020-Def -->
	<!-- Date : 2020/10/07 -->
    <!-- Target: Set the depth of the table of contents -->
  <xsl:variable name="tocMaximumLevel" select="3" as="xs:integer"/>
	<!-- End of TradeHeader Update-->
	
  <xsl:template match="ot-placeholder:toc">
    <xsl:apply-templates select="/" mode="toc"/>
  </xsl:template>

  <xsl:template match="/" mode="toc" name="toc">
    <xsl:comment>TOC</xsl:comment>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="TOCHeading"/>
      </w:pPr>
      <w:r>
        <w:lastRenderedPageBreak/>
        <w:t>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'Table of Contents'"/>
          </xsl:call-template>
        </w:t>
      </w:r>
      <xsl:apply-templates select="." mode="toc-field"/>
    </w:p>
    <xsl:apply-templates select="*[contains(@class, ' map/map ')]/*[contains(@class, ' topic/topic ')]" mode="x:toc"/>
    <!-- End TOC field -->
	
	<!-- Tradeheader Update -->
	<!-- Document : 2020-Def -->
	<!-- Date : 2020/10/07 -->
    <!-- Target: Add a breakpage at the end of the table of contents -->
    <w:p>
      <w:r>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
      <w:r>
        <w:br w:type="page"/>
      </w:r>
    </w:p>
	<!-- End of Tradeheader Update -->
	
	<!-- Tradeheader Update -->
	<!-- Document : 2020-Def -->
	<!-- Date : 2021/05/19 -->
    <!-- Target: Add a section for the toc to control toc page numeration -->
	<w:p>
		<w:pPr>
			<w:sectPr>
				<w:pgSz w:w="{$docx.config/body/docx.toc.pageSize.width}" w:h="{$docx.config/body/docx.toc.pageSize.height}"/>
				<w:pgMar w:top="{$docx.config/body/docx.toc.pageMargin.top}" w:right="{$docx.config/body/docx.toc.pageMargin.right}" w:bottom="{$docx.config/body/docx.toc.pageMargin.bottom}" w:left="{$docx.config/body/docx.toc.pageMargin.left}" w:header="{$docx.config/body/docx.toc.pageMargin.header}" w:footer="{$docx.config/body/docx.toc.pageMargin.footer}" w:gutter="{$docx.config/body/docx.toc.pageMargin.gutter}"/>
				<w:footerReference w:type="{$docx.config/body/docx.toc.footerReference.type}" r:id="{$docx.config/body/docx.toc.footerReference.id}"/>
				<w:pgNumType w:fmt="{$docx.config/body/docx.toc.pageNumerationType.format}" w:start="{$docx.config/body/docx.toc.pageNumerationType.start}"/>
				<w:headerReference r:id="{$docx.config/body/docx.toc.headerReference.id}"/>
			</w:sectPr>
		</w:pPr>
	</w:p>
  <!-- End of Tradeheader Update -->
  </xsl:template>
  
  
  <xsl:template match="/" mode="toc-field">
    <w:r>
      <w:fldChar w:fldCharType="begin"/>
    </w:r>
    <w:r>
      <w:instrText>
        <xsl:attribute name="xml:space">preserve</xsl:attribute>
        <xsl:apply-templates select="." mode="toc-prefix"/> 
      </w:instrText>
    </w:r>
    <w:r>
      <w:fldChar w:fldCharType="separate"/>
    </w:r>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Date : 2021/04/19 -->
    <!-- Origin: validation publication -->
    <!-- Target: hyperlink option added in the TOC generation -->
    <!--TODO: add the functionality to also deal when $docx.toc.mode='both' -->
  <xsl:template match="*" mode="toc-prefix">
    <xsl:choose>
      <xsl:when test="($docx.config/body/docx.toc.mode = 'heading')">
        <xsl:value-of>TOC \o "1-<xsl:value-of select="$tocMaximumLevel"/>" \w \h \* MERGEFORMAT</xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of>TOC \f \w \h \* MERGEFORMAT</xsl:value-of> 
      </xsl:otherwise>
    </xsl:choose>   
  </xsl:template>
	<!-- End of TradeHeader Update -->
  
  <xsl:variable name="toc.increment-base" select="422" as="xs:integer"/>
  
  <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="x:toc">
    <xsl:param name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
    <xsl:param name="prefix" as="node()*"/>
    <xsl:variable name="target" select="concat($bookmark-prefix.toc, x:generate-id(.))" as="xs:string"/>
    <xsl:variable name="style-numbered" as="xs:boolean"
      select="exists($styles/w:styles/w:style[@w:styleId = concat('Heading', $depth)]/w:pPr/w:numPr)"/>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="TOC{$depth}"/>
        <xsl:if test="*[contains(@class, ' topic/topic ')]">
          <w:keepNext/>
        </xsl:if>
        <w:tabs>
          <xsl:choose>
            <xsl:when test="($generate-header-number and exists(@x:header-number)) or $style-numbered">
              <w:tab w:val="left" w:pos="{$toc.increment-base * $depth}"/>
              <w:tab w:val="right" w:leader="dot" w:pos="{$body-width}"/>
            </xsl:when>
            <xsl:otherwise>
              <!--w:tab w:val="left" w:pos="{$toc.increment-base * ($depth - 1)}"/-->
              <w:tab w:val="right" w:leader="dot" w:pos="{$body-width}"/>
            </xsl:otherwise>
          </xsl:choose>
        </w:tabs>
        <w:rPr>
          <w:noProof/>
        </w:rPr>
      </w:pPr>
      <xsl:copy-of select="$prefix"/>
      <xsl:choose>
        <xsl:when test="($generate-header-number and exists(@x:header-number)) or $style-numbered">
          <w:r>
			<w:rPr>
				<w:b w:val="false"/>
			</w:rPr>
            <w:t>
              <xsl:value-of select="@x:header-number"/>
            </w:t>
          </w:r>
          <w:r>
            <w:tab/>
          </w:r>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$depth gt 1">
            <!--w:r>
              <w:tab/>
            </w:r-->
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
      <w:r>
        <w:t>
          <xsl:apply-templates select="*[contains(@class, ' topic/title ')]/node()"/>
        </w:t>
      </w:r>
      <w:r>
        <w:tab/>
      </w:r>
		<!--<xsl:variable name="anchor" select="$target"/>
		<w:hyperlink w:anchor="{$anchor}">
			<w:r>
				<w:rPr>
					<w:rStyle w:val="Hyperlink"/>
				</w:rPr>
				<w:t>
					0
				</w:t>
			</w:r>
		</w:hyperlink>-->
      <w:r>
        <w:fldChar w:fldCharType="begin" w:dirty="true"/>
      </w:r>
      <w:r>
        <w:instrText xml:space="preserve"> PAGEREF <xsl:value-of select="$target"/> \h </w:instrText>
      </w:r>
      <w:r>
        <w:fldChar w:fldCharType="separate"/>
      </w:r>
      <w:r>
        <w:t>0</w:t>
      </w:r>
      <w:r>
        <w:fldChar w:fldCharType="end"/>
      </w:r>
    </w:p>
    <xsl:if test="$depth lt $tocMaximumLevel">
      <xsl:apply-templates select="*[contains(@class, ' topic/topic ')]" mode="x:toc">
        <xsl:with-param name="depth" select="$depth + 1"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' glossentry/glossentry ')]" mode="x:toc" priority="1000"/>

</xsl:stylesheet>
