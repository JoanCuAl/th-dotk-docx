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
               xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
               xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
               xmlns:opentopic="http://www.idiominc.com/opentopic"
               xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
               xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main"
               xmlns:x="com.elovirta.ooxml"
               exclude-result-prefixes="x xs dita-ot opentopic opentopic-index ot-placeholder"
               version="2.0">

  <xsl:param name="image.dir"/>
  <!-- FIXME this should be xs:integer -->
  <xsl:param name="indent-base" as="xs:string?" select="string((x:get-style-indent('BodyText'), 0)[1])"/>
  
  <!-- Tradeheader Update -->
	<!-- Date : 2020/05/05 -->
	<!-- Origin: validation 2021 -->
	<!-- Target: Retrieve BodyText1 Identation so it can be used later -->
  <xsl:param name="indent-baseBodyText1" as="xs:string?" select="string((x:get-style-indent('BodyText1'), 0)[1])"/>
	<!-- End of Tradeheader Update -->
  
  <!-- FIXME this should be xs:integer -->
	<!-- Tradeheader Update -->
	<!-- Date : 2021/03/11 -->
    <!-- Origin: validation publication -->
    <!-- Target: Set and incrementBase for bodyText -->
  <xsl:param name="increment-base" select="'567'"/>
  
	<!-- Tradeheader Update -->
	<!-- Date : 2020/10/23 -->
    <!-- Origin: 2020 IRD Definitions -->
    <!-- Target: Set and incrementBase for bodyText -->
  <xsl:param name="increment-base-bodyText" select="'567'"/>
	<!-- End of Tradeheader Update -->

  <xsl:variable name="auto-number" select="true()" as="xs:boolean"/>

  <xsl:key name="id" match="*[@id]" use="@id"/>
  <xsl:key name="topic-id"
           match="*[@id][contains(@class, ' topic/topic ')] |
           ot-placeholder:*[@id]"
           use="@id"/>

  <!--xsl:template match="*[contains(@class, ' topic/entry ') or
    contains(@class, ' topic/stentry ') or
    contains(@class, ' topic/dt ') or
    contains(@class, ' topic/dd ')]"
    mode="block-style">
    <w:ind w:left="0"/>
  </xsl:template-->

  <xsl:template match="w:pgNumType" mode="body-section">
    <xsl:param name="overrides" as="attribute()*" tunnel="yes"/>
    <xsl:copy>
      <xsl:apply-templates select="@* except @w:start" mode="#current"/>
      <xsl:if test="exists($overrides)">
        <xsl:copy-of select="$overrides"/>
      </xsl:if>
      <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="node() | @*" mode="body-section" priority="-10">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- block -->

  <xsl:template match="node()" mode="block-style" priority="-10">
    <xsl:apply-templates select="." mode="block-style.default"/>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Date : 2021/05/03 -->
	<!-- Target: select body text identation depending on its depth -->
  <xsl:template match="node()" mode="block-style.default">
	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Date : 2021/05/04 -->
	<!-- Target: select body text align depending on input outputclass -->
	<xsl:choose>
		<xsl:when test="exists(self::*[contains(@outputclass, 'align_right')])">
			<w:pPr>
				<w:jc w:val="right"/>
			</w:pPr>
		</xsl:when>
		<xsl:when test="exists(self::*[contains(@outputclass, 'align_center')])">
			<w:pPr>
				<w:jc w:val="center"/>
			</w:pPr>
		</xsl:when>
    <xsl:when test="exists(self::*[contains(@outputclass, 'align_both')])">
			<w:pPr>
				<w:jc w:val="both"/>
			</w:pPr>
		</xsl:when>
    <xsl:when test="exists(self::*[contains(@outputclass, 'align_left')])">
			<w:pPr>
				<w:jc w:val="left"/>
			</w:pPr>
		</xsl:when>
	</xsl:choose>
	<!-- End of Tradeheader Update -->
	
	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Date : 2021/06/21 -->
	<!-- Target: select body text depth depending on input outputclass. Text inside tables has an special style associated. 
		It also supports text identation inside tables depending on input outputclass -->
	<xsl:choose>
		<xsl:when test="exists(ancestor-or-self::*[contains(@class, ' topic/table ')])">
			<xsl:choose>
				<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'cellIndent_03')])">
					<w:pStyle w:val="BodyTextTableIdent03"/>
				</xsl:when>
				<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'cellIndent_06')])">
					<w:pStyle w:val="BodyTextTableIdent06"/>
				</xsl:when>
        <xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'cellIndent_075')])">
					<w:pStyle w:val="BodyTextTableIdent075"/>
				</xsl:when>
        <xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'cellIndent_15')])">
					<w:pStyle w:val="BodyTextTableIdent15"/>
				</xsl:when>
				<xsl:when test="exists(ancestor-or-self::*[contains(@class, ' topic/thead ')])">
					<w:pStyle w:val="BodyTextTableThead"/>
				</xsl:when>
				<xsl:otherwise>
					<w:pStyle w:val="BodyTextTable"/>
				</xsl:otherwise>
			</xsl:choose>
		
			
		</xsl:when>
		<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'right_indent1')])">
			<xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')]) + 1" as="xs:integer"/>
			<w:pStyle w:val="BodyText{$depth}"/>
		</xsl:when>
  <!-- Tradeheader Update -->
	<!-- Document : Conf templates V3 -->
	<!-- Date : 2021/11/03 -->
	<!-- Target: Indent text from left in cm, left_indent1067, means a left indent to the left of 10.57 cm -->
    <xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent1067')])">
      <w:ind w:left="{ 10.67 * xs:long($increment-base)}"/>
              <w:pStyle w:val="BodyText2"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
			<w:pStyle w:val="BodyText{$depth}"/>
		</xsl:otherwise>
	</xsl:choose>
  <!-- End of Tradeheader Update -->

	<!-- Tradeheader Update -->
	<!-- Date : 2021/07/05 -->
    <!-- Origin: validation 2021 -->
    <!-- Target: add horizontal border if required by input dita -->
    <xsl:choose>
      <xsl:when test="self::*[contains(@outputclass, 'hr_line_both')]">
          <w:pBdr>
            <w:top w:val="single" w:sz="4" w:space="1" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" w:space="1" w:color="auto"/>
          </w:pBdr>
      </xsl:when>
      <xsl:when test="self::*[contains(@outputclass, 'hr_line_before')]">
          <w:pBdr>
            <w:top w:val="single" w:sz="4" w:space="1" w:color="auto"/>
          </w:pBdr>
      </xsl:when>
      <xsl:when test="self::*[contains(@outputclass, 'hr_line_after')]">
          <w:pBdr>
            <w:bottom w:val="single" w:sz="4" w:space="1" w:color="auto"/>
          </w:pBdr>
      </xsl:when>
    </xsl:choose>
    <!-- End of Tradeheader Update -->

  </xsl:template>
	<!-- End of Tradeheader Update -->

  <xsl:variable name="body-section" as="element()*">
    <w:p>
      <w:pPr>
        <xsl:for-each select="$sectPr">
          <xsl:apply-templates select="." mode="body-section">
            <xsl:with-param name="overrides" as="attribute()*" select="()" tunnel="yes"/>
          </xsl:apply-templates>
        </xsl:for-each>
      </w:pPr>
    </w:p>
  </xsl:variable>

	<!-- Tradeheader Update -->
	<!-- Document : fx-matrix-poc -->
	<!-- Date : 2020/03/25 -->
	<!-- Target: Control orientation of the page depending on the oputclass of the dita -->
	<xsl:template match="node()" mode="docOrientation">
		<xsl:if test="not(following-sibling::*[contains(@class, ' topic/p ')]) and not(following-sibling::*[contains(@class, ' topic/section ')])
	 and not(following-sibling::*[contains(@class, ' topic/ol ')]) and not(following-sibling::*[contains(@class, ' topic/table ')])">
		<xsl:choose>
			<xsl:when test="exists(parent::*[contains(@outputclass, 'landscape')][contains(@class, ' topic/body ')])">
				<!--<w:p>
					<w:r><w:t>landscape</w:t></w:r>
				</w:p>-->
				<w:p>
					<w:pPr>
						<w:sectPr>
							<w:pgSz w:w="{$docx.config/body/docx.landscapePageSize.width}" w:h="{$docx.config/body/docx.landscapePageSize.height}" w:orient="landscape"/>
							<w:pgMar w:header="{$docx.config/body/docx.landscapePageMargin.header}" w:footer="{$docx.config/body/docx.landscapePageMargin.footer}" 
							w:top="{$docx.config/body/docx.landscapePageMargin.top}" w:right="{$docx.config/body/docx.landscapePageMargin.right}"
							w:bottom="{$docx.config/body/docx.landscapePageMargin.bottom}" w:left="{$docx.config/body/docx.landscapePageMargin.left}"/>
							<xsl:if test="$docx.config/body/docx.landscapeHeaderId">
								<w:headerReference r:id="{$docx.config/body/docx.landscapeHeaderId}" w:type="{$docx.config/body/docx.landscapeHeaderType}"/>
							</xsl:if>
							<xsl:if test="$docx.config/body/docx.landscapeFooterId">
								<w:headerReference r:id="{$docx.config/body/docx.landscapeFooterId}" w:type="{$docx.config/body/docx.landscapeFooterType}"/>
							</xsl:if>
						</w:sectPr>
					</w:pPr>
				</w:p>
			</xsl:when>
			<xsl:when test="exists(parent::*[contains(@outputclass, 'horizontal')][contains(@class, ' topic/body ')])">
				
					<!--<w:p>
						<w:r><w:t>horizontal</w:t></w:r>
					</w:p>-->
					<w:p>
						<w:pPr>
							<w:sectPr>
								<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
								<w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" 
								w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
								w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
								<xsl:if test="$docx.config/body/docx.portraitHeaderId">
									<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
								</xsl:if>
								<xsl:if test="$docx.config/body/docx.portraitFooterId">
									<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
								</xsl:if>
							</w:sectPr>
						</w:pPr>
					</w:p>
				
			</xsl:when>
		</xsl:choose>
	</xsl:if>
	</xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : validation -->
	<!-- Date : 2020/04/19 -->
	<!-- Target: Add bookmark generation logic in the topics -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]" name="topic">
    <xsl:comment>Topic <xsl:value-of select="@id"/></xsl:comment>
	<xsl:comment>outputclass <xsl:value-of select="@outputclass"/></xsl:comment>
	<xsl:comment>x:header-number <xsl:value-of select="@x:header-number"/></xsl:comment>
	
	<xsl:call-template name="start-bookmark">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
	<xsl:choose>
		<xsl:when test="self::*[contains(@outputclass, 'tabledef')]">
			<xsl:comment>tabledef detected <xsl:value-of select="@outputclass"/></xsl:comment>
			<xsl:apply-templates select=".//table/*[contains(@class, ' topic/title ')]"/>
			<w:tbl>
				<xsl:apply-templates select="descendant::*[contains(@class, ' topic/tgroup ')]"/>
				<xsl:for-each select="following::*[contains(@outputclass, 'tablerow')]">
					<xsl:apply-templates select="descendant-or-self::*[contains(@class, ' topic/tbody ')]"/>
				</xsl:for-each>
			</w:tbl>
			<xsl:apply-templates select="." mode="docOrientation"/>
		</xsl:when>
		<xsl:when test="not(self::*[contains(@outputclass, 'tabledef')]) and not(self::*[contains(@outputclass, 'tablerow')])">
			<xsl:comment>no tabledef no tablerow detected <xsl:value-of select="@outputclass"/></xsl:comment>
			<xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
			<xsl:apply-templates select="*[contains(@class, ' topic/shortdesc ')] | *[contains(@class, ' topic/abstract ')]"/>
			<xsl:apply-templates select="*[contains(@class, ' topic/body ')]"/>
			<xsl:apply-templates select="*[contains(@class, ' topic/related-links ')]"/>
			<xsl:apply-templates select="*[contains(@class, ' topic/topic ')]"/>
			
			<xsl:choose>
				<xsl:when test="empty(parent::*[contains(@class, ' topic/topic ')])">
					<xsl:comment>inside emptyParent</xsl:comment>
				  <xsl:copy-of select="$body-section"/>
				  <!-- Tradeheader Update -->
					<!-- Document: validation 2021 -->
					<!-- Date : 2021/08/10 -->
					<!-- Output: Set if the footnote numbering should be reset for the current section. Set page orientation, margins, header references and footer references  -->
					<xsl:choose>
						<xsl:when test="exists(parent::*[contains(@outputclass, 'landscape')])">
							<!--<w:p>
								<w:r><w:t>landscape</w:t></w:r>
							</w:p>-->
							<w:p>
								<w:pPr>
									<w:sectPr>
										<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
											<w:footnotePr>
												<w:numRestart w:val="eachSect" />
											</w:footnotePr>
										</xsl:if>
										<xsl:if test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
											<w:footnotePr>
												<w:numRestart w:val="continous" />
											</w:footnotePr>
										</xsl:if>
										<w:pgSz w:w="{$docx.config/body/docx.landscapePageSize.width}" w:h="{$docx.config/body/docx.landscapePageSize.horizontal}" w:orient="landscape"/>
										<w:pgMar w:header="{$docx.config/body/docx.landscapePageMargin.header}" w:footer="{$docx.config/body/docx.landscapePageMargin.footer}" w:top="{$docx.config/body/docx.landscapePageMargin.top}" w:right="{$docx.config/body/docx.landscapePageMargin.right}"
										w:bottom="{$docx.config/body/docx.landscapePageMargin.bottom}" w:left="{$docx.config/body/docx.landscapePageMargin.left}"/>
										<xsl:if test="$docx.config/body/docx.landscapeHeaderId">
											<w:headerReference r:id="{$docx.config/body/docx.landscapeHeaderId}" w:type="{$docx.config/body/docx.landscapeHeaderType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.landscapeFooterId">
											<w:headerReference r:id="{$docx.config/body/docx.landscapeFooterId}" w:type="{$docx.config/body/docx.landscapeFooterType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.sectionType">
											<w:type w:val="{$docx.config/body/docx.sectionType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.pageNumerationType">
											<w:pgNumType w:val="{$docx.config/body/docx.pageNumerationType}"/>
										</xsl:if>
									</w:sectPr>
								</w:pPr>
							</w:p>
							<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')] or parent::*[contains(@outputclass, 'pageBreak')]">
								<xsl:comment>inside section break reset footnotes with breakpage landscape topic</xsl:comment>
								<w:p>
									<w:r>
										<w:br w:type="page"/>
									</w:r>
								</w:p>

							</xsl:if>
						</xsl:when>
						<xsl:when test="exists(parent::*[contains(@outputclass, 'horizontal')])">
							
								<!--<w:p>
									<w:r><w:t>horizontal</w:t></w:r>
								</w:p>-->
								<w:p>
									<w:pPr>
										<w:sectPr>
											<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
												<w:footnotePr>
													<w:numRestart w:val="eachSect" />
												</w:footnotePr>
											</xsl:if>
											<xsl:if test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
												<w:footnotePr>
													<w:numRestart w:val="continous" />
												</w:footnotePr>
											</xsl:if>
											<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
											<w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
											w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
											<xsl:if test="$docx.config/body/docx.portraitHeaderId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
											</xsl:if>
											<xsl:if test="$docx.config/body/docx.portraitFooterId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
											</xsl:if>
											<xsl:if test="$docx.config/body/docx.sectionType">
												<w:type w:val="{$docx.config/body/docx.sectionType}"/>
											</xsl:if>
											<xsl:if test="$docx.config/body/docx.pageNumerationType">
												<w:pgNumType w:val="{$docx.config/body/docx.pageNumerationType}"/>
											</xsl:if>
											
										</w:sectPr>
									</w:pPr>
								</w:p>
								<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')] or parent::*[contains(@outputclass, 'pageBreak')]">
									<xsl:comment>inside section break reset footnotes with breakpage horizontal topic</xsl:comment>
									<w:p>
										<w:r>
											<w:br w:type="page"/>
										</w:r>
									</w:p>

								</xsl:if>

						</xsl:when>
						<xsl:otherwise>
							<xsl:comment>inside otherwise no landscape no horizontal topic <xsl:value-of select="@outputclass"/></xsl:comment>
							<xsl:choose>
							  <xsl:when test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
									<w:p>
										<w:pPr>
										  <w:sectPr>
											<w:footnotePr>
											  <w:numRestart w:val="eachSect" />
											</w:footnotePr>
											<w:type w:val="continuous"/>
											<w:pgNumType w:fmt="decimal"/>
						<!-- The below lines might be error prone. In previous documents @Joan commented the section of code using values from the configuration since it did not pass some tests-->      
											<!--<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
											<w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
											w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
											
											<xsl:if test="$docx.config/body/docx.portraitHeaderId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
											</xsl:if>
											<xsl:if test="$docx.config/body/docx.portraitFooterId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
											</xsl:if>-->
										  </w:sectPr>
										</w:pPr>
									</w:p>
							  </xsl:when>
							  <xsl:when test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
									<w:p>
										<w:pPr>
										  <w:sectPr>
											<w:footnotePr>
											  <w:numRestart w:val="continous" />
											</w:footnotePr>
											<w:type w:val="continuous"/>
											<w:pgNumType w:fmt="decimal" w:start="1"/>
						<!-- The below lines might be error prone. In previous documents @Joan commented the section of code using values from the configuration since it did not pass some tests-->    
											<!--<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
											<w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
											w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
											
											<xsl:if test="$docx.config/body/docx.portraitHeaderId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
											</xsl:if>
											<xsl:if test="$docx.config/body/docx.portraitFooterId">
												<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
											</xsl:if>-->
										  </w:sectPr>
										</w:pPr>
									</w:p>
							  </xsl:when>
							  <xsl:when test="parent::*[contains(@outputclass, 'pageBreak')]">
									<xsl:comment>inside otherwise no landscape no horizontal topic pageBreak</xsl:comment>
									<w:p>
										<w:r>
											<w:br w:type="page"/>
										</w:r>
									</w:p>

								</xsl:when>
							  </xsl:choose>
							  
						</xsl:otherwise>
					</xsl:choose>
					
				  
					</xsl:when>
				<xsl:when test="self::*[contains(@outputclass, 'pageBreak')]">
									<xsl:comment>inside otherwise no landscape no horizontal topic pageBreak</xsl:comment>
									<w:p>
										<w:r>
											<w:br w:type="page"/>
										</w:r>
									</w:p>

				</xsl:when>
			</xsl:choose>
			
		</xsl:when>
	</xsl:choose>  
	<xsl:call-template name="end-bookmark">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
  </xsl:template>
  <!-- End of Tradeheader Update -->
  <xsl:template match="*[contains(@class, ' topic/body ')]" name="body">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/bodydiv ')]" name="bodydiv">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/abstract ')]" name="abstract">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Document : 1998 Fx Def -->
	<!-- Date : 2021/02/16 -->
	<!-- Target: Remove unnecesary information (used in bookmarks) to comply with the 40 character limit of the word bookmarks -->
  <xsl:variable name="bookmark-prefix.ref" select="'r'" as="xs:string"/>
  <xsl:variable name="bookmark-prefix.toc" select="'t'" as="xs:string"/>
  <xsl:variable name="bookmark-prefix.num" select="'n'" as="xs:string"/>
  <xsl:variable name="bookmark-prefix.note" select="'o'" as="xs:string"/>
	<!-- End of Tradeheader Update -->
  
  <xsl:function name="x:bookmark-name" as="xs:string">
    <xsl:param name="prefix" as="xs:string"/>
    <xsl:param name="node" as="element()"/>
    
    <xsl:variable name="name" select="concat($prefix, x:generate-id($node))"/>
    <xsl:if test="string-length($name) gt 40">
      <xsl:message terminate="yes">FATAL: Bookmark <xsl:value-of select="$name"/> longer than 40 characters</xsl:message>
    </xsl:if>
    <xsl:value-of select="$name"/>
  </xsl:function>
	
	<xsl:template name="start-bookmark">
    <xsl:param name="node" select=".[@id]" as="element()?"/>
    <xsl:param name="type" as="xs:string?" select="()"/>
    <xsl:if test="exists($node)">
      <w:bookmarkStart w:id="ref_{$type}{x:generate-id($node)}" w:name="{x:bookmark-name(concat($bookmark-prefix.ref, $type), $node)}"/>
      <w:bookmarkStart w:id="toc_{$type}{x:generate-id($node)}" w:name="{x:bookmark-name(concat($bookmark-prefix.toc, $type), $node)}"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="end-bookmark">
    <xsl:param name="node" select=".[@id]" as="element()?"/>
    <xsl:param name="type" as="xs:string?" select="()"/>
    <xsl:if test="exists($node)">
      <w:bookmarkEnd w:id="ref_{$type}{x:generate-id($node)}"/>
      <w:bookmarkEnd w:id="toc_{$type}{x:generate-id($node)}"/>
    </xsl:if>
  </xsl:template>
	
  <xsl:template name="start-bookmark-number">
    <xsl:param name="node" select=".[@id]" as="element()?"/>
    <xsl:param name="type" as="xs:string?" select="()"/>
    <xsl:if test="exists($node)">
      <w:bookmarkStart w:id="num_{$type}{x:generate-id($node)}" w:name="{x:bookmark-name(concat($bookmark-prefix.num, $type), $node)}"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="end-bookmark-number">
    <xsl:param name="node" select=".[@id]" as="element()?"/>
    <xsl:param name="type" as="xs:string?" select="()"/>
    <xsl:if test="exists($node)">
      <w:bookmarkEnd w:id="num_{$type}{x:generate-id($node)}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/topic ')]/
                         *[contains(@class, ' topic/title ')]"
                name="topic.title">
	<xsl:comment>inside topic title template</xsl:comment>
    <xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
    <w:p>
      <w:pPr>
        <xsl:apply-templates select="." mode="block-style"/>
      </w:pPr>
	  <!-- Tradeheader Update -->
		<!-- Document : validation -->
		<!-- Date : 2020/04/19 -->
		<!-- Target: Add bookmark generation logic in the topic titles -->
	  <xsl:call-template name="start-bookmark-number">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      <xsl:call-template name="start-bookmark">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      <xsl:apply-templates select="." mode="numbering"/>
      <xsl:apply-templates/>
      <xsl:call-template name="end-bookmark">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      <xsl:call-template name="end-bookmark-number">
        <xsl:with-param name="node" select="."/>
      </xsl:call-template>
      <!--<xsl:call-template name="start-bookmark">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <xsl:apply-templates select="." mode="numbering"/>
      <xsl:apply-templates/>
      <xsl:call-template name="end-bookmark">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>-->
    </w:p>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Document : Validation -->
	<!-- Target: Change from outputclass notoc to toc="no" to recognize out of toc topics. Add depth to no toc topics -->
	<!-- Date : 2020/04/26 -->
  <xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]" mode="block-style" name="block-style-topic.title">
	<xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
	<xsl:comment>processing heading with outputclass: <xsl:value-of select="@outputclass"/> and depth: <xsl:value-of select="$depth"/></xsl:comment>
	<xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
	<xsl:choose>
          <xsl:when test="exists(ancestor-or-self::*[contains(@toc, 'no')])">
				<xsl:comment>processing heading no toc with outputclass: <xsl:value-of select="@outputclass"/></xsl:comment>
				<xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
				<w:pStyle w:val="HeadingNoToc{$depth}"/>
		  </xsl:when>
		  <xsl:when test="exists(parent::*[contains(@outputclass, 'headingNoNum')]) or exists(self::*[contains(@outputclass, 'headingNoNum')])">
				<xsl:comment>processing heading no toc with outputclass: <xsl:value-of select="@outputclass"/></xsl:comment>
				<xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
				<w:pStyle w:val="HeadingNoNum"/>
		  </xsl:when>
		  <xsl:when test="self::*[contains(@outputclass, 'subtitle')]">
			  <xsl:comment>processing heading subtitle with outputclass: <xsl:value-of select="@outputclass"/></xsl:comment>
			  <xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
			  <xsl:comment>self class: <xsl:value-of select="@class"/></xsl:comment>
			  <xsl:comment>parent class: <xsl:value-of select="../@class"/></xsl:comment>
			  <w:pStyle w:val="Subtitle"/>
		  </xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'reduceHeading')])">
						<xsl:comment>processing heading reduceHeading with outputclass: <xsl:value-of select="@outputclass"/></xsl:comment>
						<xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
						<xsl:comment>self class: <xsl:value-of select="@class"/></xsl:comment>
						<xsl:comment>parent class: <xsl:value-of select="../@class"/></xsl:comment>
						<w:pStyle w:val="Heading{$depth - 1}"/>
				    </xsl:when>
					<xsl:otherwise>
						<xsl:comment>processing heading normal with outputclass: <xsl:value-of select="@outputclass"/></xsl:comment>
						<xsl:comment>parent outputclass: <xsl:value-of select="../@outputclass"/></xsl:comment>
						<w:pStyle w:val="Heading{$depth}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>

    </xsl:choose>
	
	<xsl:choose>
		<xsl:when test="exists(parent::*[contains(@outputclass, 'align_right')])">
			<w:pPr>
				<w:jc w:val="right"/>
			</w:pPr>
		</xsl:when>
		<xsl:when test="exists(parent::*[contains(@outputclass, 'align_center')])">
			<w:pPr>
				<w:jc w:val="center"/>
			</w:pPr>
		</xsl:when>
		<xsl:when test="exists(parent::*[contains(@outputclass, 'align_both')])">
			<w:pPr>
				<w:jc w:val="both"/>
			</w:pPr>
		</xsl:when>
		<xsl:when test="exists(parent::*[contains(@outputclass, 'align_left')])">
			<w:pPr>
				<w:jc w:val="left"/>
				<w:ind w:left="992" w:hanging="992"/>
			</w:pPr>
		</xsl:when>
	</xsl:choose>
  </xsl:template>
	<!-- Tradeheader Update End -->
  
  <xsl:template match="*[contains(@class, ' topic/topic ')]/
                        *[contains(@class, ' topic/title ')]"
                mode="numbering">
    <xsl:if test="$generate-header-number and exists(../@x:header-number)">
      <xsl:call-template name="start-bookmark-number">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <w:r>
        <w:t>
          <xsl:value-of select="../@x:header-number"/>
        </w:t>
      </w:r>
      <xsl:call-template name="end-bookmark-number">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <w:r>
        <w:tab/>
      </w:r>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/sectiondiv ')]" name="sectiondiv">
    <xsl:apply-templates select="*"/>
  </xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : 1998 Fx Def -->
	<!-- Date : 2021/02/17 -->
	<!-- Target: Add bookmarks to sections -->
  <xsl:template match="*[contains(@class, ' topic/section ')]" name="section">
	<xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*"/>
	<xsl:apply-templates select="." mode="docOrientation"/>
	<xsl:call-template name="end-bookmark"/>
  </xsl:template>
  <!-- End of Tradeheader Update -->
  
  <xsl:template match="*[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')] |
                       *[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ')]"
                name="section.title">
    <xsl:param name="contents" as="node()*">
      <xsl:apply-templates/>
    </xsl:param>
    <xsl:param name="style">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:param>
	<xsl:comment>insdie section title template</xsl:comment>
    <w:p>
      <xsl:if test="exists($style)">
        <w:pPr>
          <xsl:copy-of select="$style"/>
        </w:pPr>  
      </xsl:if>
	  <!-- Tradeheader Update -->
	<!-- Document : 1998 Fx Def annex A -->
	<!-- Date : 2021/08/16 -->
	<!-- Target: Add support to breakPage outputclass -->
	  <xsl:if test="self::*[contains(@outputclass, 'breakPage')]">
		<xsl:comment>inside section title break page oputclass</xsl:comment>
		<w:br w:type="page"/>
	  </xsl:if>
	  <!-- End of Tradeheader Update -->
      <xsl:copy-of select="$contents"/>
    </w:p>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')][contains(@outputclass, 'styleSeparator')]"
                name="section.title.styleSeparator" priority="10">
    <xsl:param name="contents" as="node()*">
      <xsl:apply-templates/>
    </xsl:param>
    <xsl:param name="style">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:param>
	<xsl:comment>insdie section title template styleSeparator</xsl:comment>
    <w:p>
      <xsl:if test="exists($style)">
        <w:pPr>
          <xsl:copy-of select="$style"/>
		  <w:rPr>
			<w:vanish/>
			<w:specVanish/>
		</w:rPr>
        </w:pPr>  
      </xsl:if>
	  <!-- Tradeheader Update -->
	<!-- Document : 1998 Fx Def annex A -->
	<!-- Date : 2021/08/16 -->
	<!-- Target: Add support to breakPage outputclass -->
	  <xsl:if test="self::*[contains(@outputclass, 'breakPage')]">
		<xsl:comment>inside section title break page oputclass</xsl:comment>
		<w:br w:type="page"/>
	  </xsl:if>
	  <!-- End of Tradeheader Update -->
      <xsl:copy-of select="$contents"/>
	  <w:r>
				<w:t xml:space="preserve"> </w:t>
			</w:r>
    </w:p>
  </xsl:template>
  
  <!-- Tradeheader Update -->
		<!-- Document : clause library -->
		<!-- Date : 2021/10/07 -->
		<!-- Target: Choose to force special style on section titles -->
  <xsl:template match="*[contains(@class, ' topic/section ')]/*[contains(@class, ' topic/title ')] |
                       *[contains(@class, ' topic/example ')]/*[contains(@class, ' topic/title ')]"
                mode="block-style"
                name="block-style-section.title"
                as="element()*">
		<xsl:variable name="depth" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
		<xsl:choose>
          <xsl:when test="exists(ancestor-or-self::*[contains(@toc, 'no')])">
				<w:pStyle w:val="HeadingNoToc{$depth}"/>
		  </xsl:when>
		  <xsl:when test="exists(parent::*[contains(@outputclass, 'headingNoNum')]) or exists(self::*[contains(@outputclass, 'headingNoNum')])">
				<w:pStyle w:val="HeadingNoNum"/>
		  </xsl:when>
		  <xsl:when test="self::*[contains(@outputclass, 'subtitle')]">
			  <w:pStyle w:val="Subtitle"/>
		  </xsl:when>
		  <xsl:otherwise>
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'reduceHeading')])">
						<w:pStyle w:val="Heading{$depth - 1}"/>
				    </xsl:when>
					<xsl:otherwise>
						<w:pStyle w:val="{$docx.config/body/docx.sectionTitlesStyle}"/>
					</xsl:otherwise>
				</xsl:choose>
		  </xsl:otherwise>

    </xsl:choose>
    
  </xsl:template>
	<!-- End of Tradeheader Update -->
	
  <xsl:template match="*[contains(@class, ' topic/example ')]">
    <xsl:if test="empty(*[contains(@class, ' topic/title ')])">
     <xsl:call-template name="section.title">
       <xsl:with-param name="contents">
         <w:r>
           <w:t>Example</w:t>
         </w:r>
       </xsl:with-param>
       <xsl:with-param name="style">
         <xsl:call-template name="block-style-section.title"/>
       </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/figgroup ')]" name="figgroup">
    <xsl:apply-templates select="*"/>
  </xsl:template>
    
  <xsl:template match="*[contains(@class, ' topic/fig ')]" name="fig">
    <xsl:if test="empty(*[contains(@class, ' topic/title ')])">
      <xsl:call-template name="start-bookmark"/>
    </xsl:if>
    <xsl:apply-templates select="*"/>
    <xsl:if test="empty(*[contains(@class, ' topic/title ')])">
      <xsl:call-template name="end-bookmark"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]"
                name="fig.title">
    <w:p>
      <w:pPr>
        <xsl:apply-templates select="." mode="block-style"/>
      </w:pPr>
      <xsl:call-template name="start-bookmark">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <w:r>
        <w:t>
         <xsl:call-template name="getVariable">
           <xsl:with-param name="id" select="'Figure'"/>
         </xsl:call-template>
       </w:t>
      </w:r>
      <w:r>
        <w:t>
          <xsl:attribute name="xml:space">preserve</xsl:attribute>
          <xsl:call-template name="getVariable">
            <xsl:with-param name="id" select="'figure-number-separator'"/>
          </xsl:call-template>
        </w:t>
      </w:r>
      <xsl:call-template name="start-bookmark-number">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <xsl:variable name="number" as="xs:string">
        <xsl:number count="*[contains(@class, ' topic/fig ')]" level="any"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$auto-number">
          <w:fldSimple w:instr=" SEQ Figure \* ARABIC ">
            <w:r>
              <w:rPr>
                <w:noProof/>
              </w:rPr>
              <w:t>
                <xsl:copy-of select="$number"/>
              </w:t>
            </w:r>
          </w:fldSimple>
        </xsl:when>
        <xsl:otherwise>
          <w:r>
            <w:rPr>
              <w:noProof/>
            </w:rPr>
            <w:t>
              <xsl:copy-of select="$number"/>  
            </w:t>
          </w:r>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="end-bookmark-number">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <xsl:call-template name="end-bookmark">
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <w:r>
        <w:t xml:space="preserve">: </w:t>
      </w:r>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]" mode="block-style">
    <w:pStyle w:val="Caption"/>
    <w:keepNext/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/shortdesc ')]" name="shortdesc">
    <xsl:call-template name="p"/>
  </xsl:template>
    
  <xsl:template name="check-table-entry">
    <xsl:variable name="styles" as="node()*">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:variable>
    <xsl:if test="exists($styles)">
      <w:pPr>
        <xsl:copy-of select="$styles"/>
      </w:pPr>
    </xsl:if>
  </xsl:template>
    
	<!-- For any block that can appear as in list item content -->
	<!-- Tradeheader Update -->
	<!-- Date : 2020/10/23 -->
    <!-- Origin: 2020 IRD Definitions -->
    <!-- Target: Change BodyText identation acording to the depth of the paragraph -->
  <xsl:template name="generate-block-style">
    <xsl:variable name="root" select="(ancestor::*[contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ') or contains(@class, ' topic/fig ')][1], /*)[1]" as="element()?" />
    <xsl:variable name="ancestor-lis" select="ancestor::*[contains(@class, ' topic/li ')][. >> $root]" as="element()*"/>
    <xsl:variable name="styles" as="node()*">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:variable>
    <w:pPr>
      <xsl:copy-of select="$styles"/>
      <xsl:choose>
        <xsl:when test="exists($ancestor-lis)">
          <xsl:variable name="is-first" as="xs:boolean">
            <xsl:variable name="parent-li" select="$ancestor-lis[position() eq last()]/*[1]" as="element()?"/>
            <xsl:variable name="parents-until-li" select="ancestor-or-self::*[. >> $parent-li]" as="element()*"/>
            <xsl:sequence select="every $e in $parents-until-li satisfies empty($e/preceding-sibling::*)"/>
          </xsl:variable>
          <xsl:variable name="depth" as="xs:integer">
            <xsl:apply-templates select="." mode="block-depth"/>
          </xsl:variable>
          <xsl:comment>depth <xsl:value-of select="$depth"/></xsl:comment>
			<xsl:choose>  
				<xsl:when test="$is-first">
					<xsl:choose>
						<xsl:when test="ancestor::*[contains(@outputclass, 'startFrom_')]">
							<w:numPr>
								<w:ilvl w:val="{$depth}"/>
								<w:numId w:val="{ancestor::*[@x:list-number][1]/@x:list-number}"/>
							</w:numPr>
						</xsl:when>
						<xsl:otherwise>
							<w:numPr>
								<w:ilvl w:val="{if ($depth gt 0) then $depth - 1 else 0}"/>
								<w:numId w:val="{ancestor::*[@x:list-number][1]/@x:list-number}"/>
							</w:numPr>
						</xsl:otherwise>
					</xsl:choose>
					
				</xsl:when>
				<xsl:otherwise>
					<!-- Tradeheader Update -->
					<!-- Date : 2021/09/22 -->
					<!-- Origin: 2020 main book generic -->
					<!-- Target: Add extra identation to listed text if right_indent1 is present -->
					<xsl:choose>
						<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'right_indent1')])">
							<w:ind w:left="{x:get-indent($depth + 1)}"/>
						</xsl:when>
						<xsl:otherwise>
							<w:ind w:left="{x:get-indent($depth)}"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- End of Tradeheader Update -->
				</xsl:otherwise>
			  </xsl:choose>
        </xsl:when>
		<xsl:otherwise>
			  
          </xsl:otherwise>
      </xsl:choose>
    </w:pPr>
  </xsl:template>
	<!-- End of Tradeheader Update -->
  
  <xsl:function name="x:get-indent" as="xs:integer">
    <xsl:param name="depth" as="xs:integer"/>
    <xsl:sequence select="xs:integer($indent-base) + xs:integer($increment-base) * $depth"/>
  </xsl:function>
  
	<!-- Tradeheader Update -->
	<!-- Date : 2020/10/23 -->
    <!-- Origin: 2020 IRD Definitions -->
    <!-- Target: Change BodyText identation acording to the depth of the paragraph -->
  <xsl:function name="x:get-indent-bodyText" as="xs:integer">
	<xsl:param name="element" as="node()"/>
    <xsl:variable name="depth" select="count($element/ancestor-or-self::*[contains(@class, ' topic/topic ')])" as="xs:integer"/>
    <xsl:sequence select="xs:integer($increment-base-bodyText) * $depth"/>
  </xsl:function>
	<!-- End of Tradeheader Update -->
  
	<!-- Tradeheader Update -->
	<!-- Date : 2020/12/20 -->
    <!-- Origin: main book ird -->
    <!-- Target: listType outputclass resets depth if a list numeration is inside another list -->
  <xsl:template match="*" mode="block-depth" as="xs:integer">
    <xsl:variable name="root" select="(ancestor-or-self::*[contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ') or contains(@class, ' topic/fig ') or contains(@outputclass, 'listType')][1], /*)[1]" as="element()?" />
    <xsl:variable name="ancestor-lis" select="ancestor::*[contains(@class, ' topic/li ')][. >> $root]" as="element()*"/>
    <!--xsl:variable name="fig" select="ancestor-or-self::*[contains(@class, ' topic/fig ')][. >> $root][1]" as="element()?"/-->
    <xsl:variable name="lists" select="ancestor-or-self::*[contains(@class, ' topic/ul ') or
      contains(@class, ' topic/ol ')][. >> $root]" as="element()*"/>
    <!--xsl:variable name="depth"
      select="if ($fig)
      then count($lists[. >> $fig])
      else count($lists)" as="xs:integer"/-->
    <xsl:sequence select="count($lists)"/>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Date : 2021/02/15 -->
    <!-- Origin: 1998 Fx Definitions -->
    <!-- Target: Add link bookmarks to paragraphs -->
  <xsl:template match="*[contains(@class, ' topic/p ')]" name="p">
    <xsl:param name="prefix" as="node()*" select="()"/>
	<xsl:comment>inside p template</xsl:comment>
    	<!--<!-\- Tradeheader Update -\->
	<!-\- Date : 2021/05/05 -\->
    <!-\- Origin: validation 2021 -\->
    <!-\- Target: add horizontal line if required by input dita -\->
	<xsl:if test="self::*[contains(@outputclass, 'hr_line_before')] or self::*[contains(@outputclass, 'hr_line_both')]">
		<w:p>
			<xsl:call-template name="generate-block-style"/>
			<w:r>
				 <w:continuationSeparator />
			</w:r>
		</w:p>
	</xsl:if>
	<!-\- End of Tradeheader Update -\->-->
	
	<!-- Tradeheader Update -->
				<!-- Document: validation 2021 -->
				<!-- Date : 2021/08/10 -->
				<!-- Output: Set if the footnote numbering should be reset for the current section. Set page orientation, margins, header references and footer references  -->
				<xsl:choose>
					<xsl:when test="exists(self::*[contains(@outputclass, 'landscape')])">
					<xsl:comment>inside landscape paragraph <xsl:value-of select="@outputclass"/></xsl:comment>
						<!--<w:p>
							<w:r><w:t>landscape</w:t></w:r>
						</w:p>-->
						<w:p>
							<w:pPr>
								<w:sectPr>
									<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
										<w:footnotePr>
											<w:numRestart w:val="eachSect" />
										</w:footnotePr>
									</xsl:if>
									<xsl:if test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
										<w:footnotePr>
											<w:numRestart w:val="continous" />
										</w:footnotePr>
									</xsl:if>
									<w:pgSz w:w="{$docx.config/body/docx.landscapePageSize.width}" w:h="{$docx.config/body/docx.landscapePageSize.horizontal}" w:orient="landscape"/>
									<w:pgMar w:header="{$docx.config/body/docx.landscapePageMargin.header}" w:footer="{$docx.config/body/docx.landscapePageMargin.footer}" w:top="{$docx.config/body/docx.landscapePageMargin.top}" w:right="{$docx.config/body/docx.landscapePageMargin.right}"
									w:bottom="{$docx.config/body/docx.landscapePageMargin.bottom}" w:left="{$docx.config/body/docx.landscapePageMargin.left}"/>
									<xsl:if test="$docx.config/body/docx.landscapeHeaderId">
										<w:headerReference r:id="{$docx.config/body/docx.landscapeHeaderId}" w:type="{$docx.config/body/docx.landscapeHeaderType}"/>
									</xsl:if>
									<xsl:if test="$docx.config/body/docx.landscapeFooterId">
										<w:headerReference r:id="{$docx.config/body/docx.landscapeFooterId}" w:type="{$docx.config/body/docx.landscapeFooterType}"/>
									</xsl:if>
									<xsl:if test="$docx.config/body/docx.sectionType">
										<w:type w:val="{$docx.config/body/docx.sectionType}"/>
									</xsl:if>
									<xsl:if test="$docx.config/body/docx.pageNumerationType">
										<w:pgNumType w:val="{$docx.config/body/docx.pageNumerationType}"/>
									</xsl:if>
								</w:sectPr>
							</w:pPr>
						</w:p>
						<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
							<xsl:comment>inside section break reset footnotes with breakpage landscape paragraph</xsl:comment>
							<w:p>
								<w:r>
									<w:br w:type="page"/>
								</w:r>
							</w:p>

						</xsl:if>
					</xsl:when>
					<xsl:when test="exists(self::*[contains(@outputclass, 'horizontal')])">
						
							<!--<w:p>
								<w:r><w:t>horizontal</w:t></w:r>
							</w:p>-->
							<w:p>
								<w:pPr>
									<w:sectPr>
										<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
											<w:footnotePr>
												<w:numRestart w:val="eachSect" />
											</w:footnotePr>
										</xsl:if>
										<xsl:if test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
											<w:footnotePr>
												<w:numRestart w:val="continous" />
											</w:footnotePr>
										</xsl:if>
										<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
										<w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
										w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
										<xsl:if test="$docx.config/body/docx.portraitHeaderId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.portraitFooterId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.sectionType">
											<w:type w:val="{$docx.config/body/docx.sectionType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.pageNumerationType">
											<w:pgNumType w:val="{$docx.config/body/docx.pageNumerationType}"/>
										</xsl:if>
										
									</w:sectPr>
								</w:pPr>
							</w:p>
							<xsl:if test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
								<xsl:comment>inside section break reset footnotes with breakpage horizontal paragraph</xsl:comment>
								<w:p>
									<w:r>
										<w:br w:type="page"/>
									</w:r>
								</w:p>

							</xsl:if>

					</xsl:when>
					<xsl:otherwise>
						<xsl:comment>inside otherwise no landscape no horizontal paragraph <xsl:value-of select="@outputclass"/></xsl:comment>
						<xsl:choose>
              <!-- w:pgSz (pageSize) was added to solve an unexpected change in page size. This line of code might be error prone. In previous documents @Joan commented the section of code using values from the configuration since it did not pass some tests-->
						  <xsl:when test="self::*[contains(@outputclass, 'sectionBreak_resetFootnotes')]">
								<w:p>
									<w:pPr>
									  <w:sectPr>
                      <w:footnotePr>
                        <w:numRestart w:val="eachSect" />
                      </w:footnotePr>
                      <w:type w:val="continuous"/>
                      <w:pgNumType w:fmt="decimal"/>
                      <!-- Document: 2021 Ird MainBook v4  -->
                      <!-- Date : 2021/12/01 -->
                      <!-- Output: The below code is used to avoid:
                        - inconsistency in pages size
                        - inconsistency in footers  
                      TODO: for now it works well since we have only used this for when the pages are vertical(portrait), we might have some problems when we have landscape pages and/or a mix of landscape and portrait pages the logic should be updated to deal with it -->
									  	<w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
                      <w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
										w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
										<!-- 
										<xsl:if test="$docx.config/body/docx.portraitHeaderId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.portraitFooterId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
										</xsl:if> -->
									  </w:sectPr>
									</w:pPr>
                  <w:r>
										<w:br w:type="page"/>
									</w:r>
								</w:p>
						  </xsl:when>
						  <xsl:when test="following-sibling::*[1][contains(@outputclass, 'sectionBreak_resetFootnotes')]">
								<w:p>
									<w:pPr>
									  <w:sectPr>
                      <w:footnotePr>
                        <!-- After the section with the outputclass "sectionBreak_resetFootnotes", we want to restart the numeration of the footnotes,
                        for this reason we use "eachSect" -->
                        <w:numRestart w:val="eachSect" />
                      </w:footnotePr>
                      <w:type w:val="continuous"/>
                      
                      <!-- Document: 2021 Ird MainBook v4  -->
                      <!-- Date : 2021/12/01 -->
                      <!-- Output: The below code is used to avoid:
                        - inconsistency in pages size
                        - inconsistency in footers  
                      TODO: for now it works well since we have only used this for when the pages are vertical(portrait), we might have some problems when we have landscape pages and/or a mix of landscape and portrait pages the logic should be updated to deal with it -->
										  <w:pgSz w:w="{$docx.config/body/docx.portraitPageSize.width}" w:h="{$docx.config/body/docx.portraitPageSize.height}"/>
                      <w:pgMar w:header="{$docx.config/body/docx.portraitPageMargin.header}" w:footer="{$docx.config/body/docx.portraitPageMargin.footer}" w:top="{$docx.config/body/docx.portraitPageMargin.top}" w:right="{$docx.config/body/docx.portraitPageMargin.right}"
                      w:bottom="{$docx.config/body/docx.portraitPageMargin.bottom}" w:left="{$docx.config/body/docx.portraitPageMargin.left}"/>
										<!--
										<xsl:if test="$docx.config/body/docx.portraitHeaderId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitHeaderId}" w:type="{$docx.config/body/docx.portraitHeaderType}"/>
										</xsl:if>
										<xsl:if test="$docx.config/body/docx.portraitFooterId">
											<w:headerReference r:id="{$docx.config/body/docx.portraitFooterId}" w:type="{$docx.config/body/docx.portraitFooterType}"/>
										</xsl:if> -->
									  </w:sectPr>
									</w:pPr>
								</w:p>
						  </xsl:when>
						  </xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				
	<!-- Tradeheader Update -->
	<!-- Date : 2021/03/11 -->
    <!-- Origin: add provisions -->
    <!-- Target: correct how paragraph bookmarks are generated. generating bookmarks inside the p tag fixes paragraphs inside tables -->
	<w:p>
		<xsl:call-template name="start-bookmark">
			<xsl:with-param name="node" select="."/>
		</xsl:call-template>
		  <!--xsl:call-template name="check-table-entry"/-->
		  <xsl:call-template name="generate-block-style"/>
		  <xsl:if test="exists($prefix)">
			<xsl:copy-of select="$prefix"/>
		  </xsl:if>
		  <xsl:apply-templates/>
			<xsl:call-template name="end-bookmark">
				<xsl:with-param name="node" select="."/>
		 </xsl:call-template>
    </w:p>
	
<!--     	 <!-\- Tradeheader Update -\->
	<!-\- Date : 2021/05/05 -\->
    <!-\- Origin: validation 2021 -\->
    <!-\- Target: add horizontal line if required by input dita -\->
	 <xsl:if test="self::*[contains(@outputclass, 'hr_line_after')] or self::*[contains(@outputclass, 'hr_line_both')]">
		<w:p>
			<xsl:call-template name="generate-block-style"/>
			<w:r>
				 <w:continuationSeparator />
			</w:r>
		</w:p>
	</xsl:if>-->
	<!-- End of Tradeheader Update -->
	
	<!-- Tradeheader Update -->
	<!-- Date : 2021/07/20 -->
    <!-- Origin: 2021 bd matrix -->
    <!-- Target: Detect the landscape outputclass and apply a section when required -->
	<xsl:comment>checking doc orientation paragraph</xsl:comment>
	 <xsl:apply-templates select="." mode="docOrientation"/>
	<!-- End of Tradeheader Update -->
  </xsl:template>
	<!-- End of Tradeheader Update -->
  
  <xsl:template match="*[contains(@class, ' topic/pre ')]" name="pre">
    <xsl:param name="prefix" as="node()*" select="()"/>
    <w:p>
      <xsl:call-template name="generate-block-style"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, 'topic/pre ')]" mode="block-style">
    <w:pStyle w:val="HTMLPreformatted"/>
  </xsl:template>
   
  <xsl:template match="*[contains(@class, ' topic/lines ')]" name="lines">
    <w:p>
      <xsl:call-template name="generate-block-style"/>
      <xsl:apply-templates/>
    </w:p>
  </xsl:template>
      
  <xsl:template match="*[contains(@class, ' topic/image ')][@placement = 'inline' or empty(@placement)]" name="image.inline">
    <xsl:param name="styles" as="element()*" tunnel="yes">
      <xsl:apply-templates select="." mode="inline-style"/>
    </xsl:param>
    <xsl:variable name="image.url" select="concat($input.dir.url, @href)" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="exists(@dita-ot:image-height) or unparsed-text-available($image.url)">    
        <!-- Units are English metric units: 1 EMU = 1 div 914400 in = 1 div 360000 cm -->
        <xsl:variable name="width" as="xs:integer?">
          <xsl:if test="@dita-ot:image-width">
            <xsl:sequence select="x:to-emu(@dita-ot:image-width, @dita-ot:horizontal-dpi)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="height" as="xs:integer?">
          <xsl:if test="@dita-ot:image-height">
            <xsl:sequence select="x:to-emu(@dita-ot:image-height, @dita-ot:vertical-dpi)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="size" as="xs:integer*"
                      select="if (exists($width) and exists($height))
                               then x:scale-to-max-box($width, $height)
                              else ()"/>
        <w:r>
          <xsl:if test="exists($styles)">
            <w:rPr>
              <xsl:copy-of select="$styles"/>
            </w:rPr>
          </xsl:if>
          <w:drawing>
           <wp:inline distT="0" distB="0" distL="0" distR="0">
             <xsl:if test="exists($size[1]) and exists($size[2])">
               <wp:extent cx="{$size[1]}" cy="{$size[2]}"/>  
             </xsl:if>
             <wp:effectExtent l="0" t="0" r="0" b="0"/>
             <wp:docPr id="1" name="Picture 1"/>
             <wp:cNvGraphicFramePr>
               <a:graphicFrameLocks noChangeAspect="1"/>
             </wp:cNvGraphicFramePr>
             <a:graphic>
               <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                 <pic:pic>
                   <pic:nvPicPr>
                     <pic:cNvPr id="0">
                       <xsl:attribute name="name">
                         <xsl:text>media/</xsl:text>
                         <xsl:choose>
                           <xsl:when test="ends-with(@href, '.svg')">
                             <xsl:value-of select="replace(@href, '\.svg$', '.emf')"/>
                           </xsl:when>
                           <xsl:otherwise>
                             <xsl:value-of select="@href"/>
                           </xsl:otherwise>
                         </xsl:choose>
                       </xsl:attribute>
                     </pic:cNvPr>
                     <pic:cNvPicPr/>
                   </pic:nvPicPr>
                   <pic:blipFill>
                     <a:blip r:embed="rId{@x:image-number}">
                       <a:extLst>
                         <a:ext uri="{{28A0092B-C50C-407E-A947-70E740481C1C}}">
                           <a14:useLocalDpi val="0"/>
                         </a:ext>
                       </a:extLst>
                     </a:blip>
                     <a:stretch>
                       <a:fillRect/>
                     </a:stretch>
                   </pic:blipFill>
                   <pic:spPr>
                     <a:xfrm>
                       <a:off x="0" y="0"/>
                       <xsl:if test="exists($width) and exists($height)">
                         <a:ext cx="{$width}" cy="{$height}"/>  
                       </xsl:if>
                     </a:xfrm>
                     <a:prstGeom prst="rect">
                       <a:avLst/>
                     </a:prstGeom>
                   </pic:spPr>
                 </pic:pic>
               </a:graphicData>
             </a:graphic>
           </wp:inline>
         </w:drawing>
       </w:r>
      </xsl:when>
      <xsl:otherwise>
        <w:r>
          <w:t>
            <xsl:text>Image </xsl:text>
            <xsl:value-of select="@href"/>
            <xsl:text> missing</xsl:text>
          </w:t>
        </w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:function name="x:scale-to-max-box" as="xs:integer+">
    <xsl:param name="width" as="xs:integer"/>
    <xsl:param name="height" as="xs:integer"/>
    <xsl:choose>
      <xsl:when test="$width le $max-image-width and $height le $max-image-height">
        <xsl:sequence select="($width, $height)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="scale" select="min(($max-image-width div $width, $max-image-height div $height))" as="xs:double"/>
        <!--xsl:message>INFO: Scale graphic by <xsl:value-of select="$scale"/></xsl:message-->
        <xsl:sequence select="(xs:integer($width * $scale), xs:integer($height * $scale))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  <xsl:variable name="max-image-width" select="17 * 360000" as="xs:integer"/>
  <xsl:variable name="max-image-height" select="22 * 360000" as="xs:integer"/>
  
  <xsl:template match="*[contains(@class, ' topic/image ')][@placement = 'break']" name="image.break">
    <w:p>
      <!--xsl:call-template name="check-table-entry"/-->
      <xsl:call-template name="generate-block-style"/>
      <xsl:call-template name="image.inline"/>
    </w:p>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/image ')][@placement = 'break']" mode="block-style">
    <xsl:if test="exists(@align)">
      <w:jc w:val="{@align}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/dl ')]" name="dl">
    <w:tbl>
      <xsl:variable name="styles" as="node()*">
        <xsl:apply-templates select="." mode="block-style"/>
      </xsl:variable>
      <xsl:if test="exists($styles)">
        <w:tblPr>
          <xsl:copy-of select="$styles"/>
        </w:tblPr>
      </xsl:if>
      <w:tblGrid>
        <w:gridCol/>
        <w:gridCol/>
      </w:tblGrid>
      <xsl:apply-templates select="*[contains(@class, ' topic/dlentry ')]"/>
    </w:tbl>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/dl ')]" mode="block-style">
    <xsl:variable name="depth" as="xs:integer">
      <xsl:apply-templates select="." mode="block-depth"/>
    </xsl:variable>
    <w:tblLayout w:type="autofit"/>
    <w:tblStyle w:val="TableGrid"/>
    <w:tblW w:w="0" w:type="auto"/>
    <w:tblInd w:w="{x:get-indent($depth)}" w:type="dxa"/>
    <w:tblLook w:val="04A0"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/dlentry ')]">
    <w:tr>
      <xsl:apply-templates select="*[contains(@class, ' topic/dt ')]"/>
      <xsl:apply-templates select="*[contains(@class, ' topic/dd ')]"/>
    </w:tr>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/dt ')]">
    <w:tc>
      <w:tcPr>
        <w:tcW w:w="0" w:type="auto"/>
      </w:tcPr>
      <w:p>
        <xsl:call-template name="start-bookmark"/>
        <xsl:apply-templates/>
        <xsl:call-template name="end-bookmark"/>
      </w:p>
    </w:tc>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/dd ')]">
    <w:tc>
      <w:tcPr>
        <w:tcW w:w="0" w:type="auto"/>
      </w:tcPr>
      <xsl:apply-templates select="*"/>
    </w:tc>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/ul ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*[contains(@class, ' topic/li ')]"/>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Document : 2002-MA -->
	<!-- Date : 2020/08/05 -->
	<!-- Target: include pagragraph processing inside ordered lists -->
  <xsl:template match="*[contains(@class, ' topic/ol ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*"/>
    <xsl:call-template name="end-bookmark"/>
	
	<xsl:apply-templates select="." mode="docOrientation"/>
  </xsl:template>
	<!-- End of Tradeheader Update -->
  
  <xsl:template match="*[contains(@class, ' topic/sl ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*[contains(@class, ' topic/sli ')]"/>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*"/>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/li ')]/*" mode="block-style">
    <w:pStyle w:val="ListParagraph"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]/*[1]" priority="10" mode="block-style">
    <xsl:variable name="break" as="element()"
      select="ancestor::*[contains(@class, ' topic/topic ') or contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ')][1]"/>
    <xsl:variable name="depth" as="xs:integer"
      select="count(ancestor::*[contains(@class, ' topic/ul ') or contains(@class, ' topic/ol ')][. >> $break])"/>
    <w:pStyle w:val="ListParagraph">
      <xsl:attribute name="w:val">
        <xsl:text>ListBullet</xsl:text>
        <xsl:if test="$depth gt 1">
          <xsl:value-of select="$depth"/>
        </xsl:if>
      </xsl:attribute>
    </w:pStyle>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*"/>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
    
  <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]/*[1]" mode="block-style" priority="10">
    <xsl:variable name="break" as="element()"
      select="ancestor-or-self::*[contains(@class, ' topic/topic ') or contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ')][1]"/>
    <xsl:variable name="depth" as="xs:integer"
      select="count(ancestor::*[contains(@class, ' topic/ul ') or contains(@class, ' topic/ol ')][. >> $break])"/>
    <w:pStyle w:val="ListParagraph">
      <xsl:attribute name="w:val">
        <xsl:text>ListNumber</xsl:text>
        <xsl:if test="$depth gt 1">
          <xsl:value-of select="$depth"/>
        </xsl:if>
      </xsl:attribute>
    </w:pStyle>
  </xsl:template>
    
  <xsl:template match="*[contains(@class, ' topic/itemgroup ')]">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/sli ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*"/>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/note ')]">
    <xsl:call-template name="start-bookmark"/>
    <xsl:variable name="prefix" as="node()*">
      <xsl:apply-templates select="." mode="prefix"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="*[1][contains(@class, ' topic/p ')]">
        <xsl:apply-templates select="*[1]">
          <xsl:with-param name="prefix" select="$prefix"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="*[position() gt 1]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="p">
          <xsl:with-param name="prefix" select="$prefix"/>
        </xsl:call-template>
        <xsl:apply-templates select="*"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/note ')]" mode="prefix">
    <w:r>
      <w:rPr>
        <w:caps/>
        <w:b w:val="true"/>
      </w:rPr>
      <w:t>
        <xsl:variable name="type" select="x:note-type(.)" as="xs:string"/>
        <xsl:call-template name="getVariable">
          <xsl:with-param name="id" select="concat(upper-case(substring($type, 1, 1)),
                                                   substring($type, 2))"/>
        </xsl:call-template>
        <xsl:text>:</xsl:text>
      </w:t>
      <!--w:tab/-->
      <w:t>
        <xsl:attribute name="xml:space">preserve</xsl:attribute>
        <xsl:text> </xsl:text>
      </w:t>
    </w:r>
  </xsl:template>
  
  <xsl:function name="x:note-type" as="xs:string">
    <xsl:param name="note" as="element()"/>
    <xsl:choose>
      <xsl:when test="$note/@type = 'other' and $note/@othertype">
        <xsl:value-of select="$note/@othertype"/>
      </xsl:when>
      <xsl:when test="empty($note/@type)">
        <xsl:text>note</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$note/@type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <xsl:template match="*[contains(@class, ' topic/note ')]" mode="block-style">
    <w:pStyle w:val="Note"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/li ')]//*[contains(@class, ' topic/note ')]" mode="block-style" priority="10">
    <w:pStyle w:val="ListNote"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/note ')]//*[contains(@class, ' topic/li ')]//*" mode="block-style">
    <w:pStyle w:val="ListNote"/>
  </xsl:template>
    
  <!-- Glossary -->
    
  <xsl:template match="*[contains(@class, ' glossgroup/glossgroup ')]" name="glossgroup">
    <xsl:variable name="depth" as="xs:integer">
      <xsl:apply-templates select="." mode="block-depth"/>
    </xsl:variable>
    <xsl:call-template name="start-bookmark"/>
    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
    <w:tbl>
      <xsl:variable name="styles" as="node()*">
        <xsl:apply-templates select="." mode="block-style"/>
      </xsl:variable>
      <xsl:if test="exists($styles)">
        <w:tblPr>
          <xsl:copy-of select="$styles"/>
        </w:tblPr>
      </xsl:if>
      <w:tblGrid>
        <w:gridCol/>
        <w:gridCol/>
      </w:tblGrid>
      <xsl:apply-templates select="*[contains(@class, ' glossentry/glossentry ')]"/>
    </w:tbl>
    <xsl:call-template name="end-bookmark"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' glossgroup/glossgroup ')]" mode="block-style">
    <xsl:variable name="depth" as="xs:integer">
      <xsl:apply-templates select="." mode="block-depth"/>
    </xsl:variable>
    <w:tblLayout w:type="autofit"/>
    <w:tblStyle w:val="TableGrid"/>
    <w:tblW w:w="0" w:type="auto"/>
    <w:tblInd w:w="{x:get-indent($depth)}" w:type="dxa"/>
    <w:tblLook w:val="04A0"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' glossentry/glossentry ')]" name="glossentry">
    <w:tr>
      <!--xsl:apply-templates select="*[contains(@class, ' glossentry/glossBody ')]/*[contains(@class, ' glossentry/glossAlt ')]/*[contains(@class, ' glossentry/glossAbbreviation ')]"/-->
      <xsl:apply-templates select="*[contains(@class, ' glossentry/glossterm ')]"/>
      <xsl:apply-templates select="*[contains(@class, ' glossentry/glossdef ')]"/>
    </w:tr>
  </xsl:template>
  
  <!-- Fallback for ungrouped glossary entries -->
  <xsl:template match="*[contains(@class, ' glossentry/glossentry ')][empty(parent::*[contains(@class, ' glossgroup/glossgroup ')])]" priority="10">
    <w:tbl>
      <xsl:variable name="styles" as="node()*">
        <xsl:apply-templates select="." mode="block-style"/>
      </xsl:variable>
      <xsl:if test="exists($styles)">
        <w:tblPr>
          <xsl:copy-of select="$styles"/>
        </w:tblPr>
      </xsl:if>
      <w:tblGrid>
        <w:gridCol/>
        <w:gridCol/>
      </w:tblGrid>
      <xsl:call-template name="glossentry"/>      
    </w:tbl>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' glossentry/glossterm ')]" priority="10">
    <w:tc>
      <w:tcPr>
        <w:tcW w:w="0" w:type="auto"/>
        <xsl:apply-templates select="." mode="block-style"/>
      </w:tcPr>
      <w:p>
        <xsl:call-template name="start-bookmark">
          <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
        <xsl:apply-templates/>
        <xsl:call-template name="end-bookmark">
          <xsl:with-param name="node" select=".."/>
        </xsl:call-template>
      </w:p>
    </w:tc>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' glossentry/glossAbbreviation ')]">
    <w:tc>
      <w:tcPr>
        <w:tcW w:w="0" w:type="auto"/>
      </w:tcPr>
      <w:p>
        <xsl:call-template name="start-bookmark"/>
        <xsl:apply-templates/>
        <xsl:call-template name="end-bookmark"/>
      </w:p>
    </w:tc>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' glossentry/glossdef ')]" priority="10">
    <w:tc>
      <w:tcPr>
        <w:tcW w:w="0" w:type="auto"/>
        <xsl:apply-templates select="." mode="block-style"/>
      </w:tcPr>
      <xsl:apply-templates select="*"/>
    </w:tc>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' glossentry/glossterm ')]" mode="block-style" priority="10">
    <w:b w:val="true"/>
  </xsl:template> 
  
  <!-- inline -->
  
  <xsl:template match="node()" mode="inline-style" priority="-10"/>
  
	<!-- Tradeheader Update -->
    <!-- Origin: 2020 IRD Definitions -->
    <!-- Output: text with outputclass wgnotes yellow shade -->
	<!-- Date : 2020/10/14 -->
  <xsl:template match="text()">
    <xsl:param name="styles" as="element()*" tunnel="yes">
      <xsl:apply-templates select="ancestor::*" mode="inline-style"/>
    </xsl:param>
    <w:r>
		<xsl:if test="exists(ancestor::*[contains(@outputclass, 'wgnotes')])">
			<w:rPr>
				<w:shd w:val="clear" w:color="auto" w:fill="FFFF00"/>
			</w:rPr>
		</xsl:if>
      <xsl:if test="exists($styles)">
        <w:rPr>
          <xsl:copy-of select="$styles"/>
		  
		  <!-- Tradeheader Update -->
		  <!-- Origin: validation 2021 -->
		  <!-- Output: force footnote text not to be bold if external parametner $docx.config/body/docx.bold.footnotes is set to false -->
		  <!-- Date : 2021/05/12 -->
		  <xsl:if test="(ancestor::*[contains(@class, ' topic/fn ')] and ($docx.config/body/docx.bold.footnotes = 'false'))">
			<w:b w:val="false"/>
		  </xsl:if>
		  <!-- End of Tradeheader Update -->
		  
		  <!-- Tradeheader Update -->
		  <!-- Origin: validation 2021 -->
		  <!-- Output: force footnote text not to be in superscript or subscript -->
		  <!-- Date : 2021/05/12 -->
		  <xsl:if test="ancestor::*[contains(@class, ' topic/fn ')]">
			<w:vertAlign w:val="baseline"/>
		  </xsl:if>
		  <!-- End of Tradeheader Update -->
        </w:rPr>
      </xsl:if>
     <!-- Tradeheader Update -->
		  <!-- Origin: validation 2021 -->
		  <!-- Output: add break line to titles -->
		  <!-- Date : 2021/05/21 -->
		<xsl:choose>
			<xsl:when test="exists(parent::*[contains(@class, ' topic/title ')]) and exists(parent::*/..[contains(@outputclass, 'addLineBreak')])">

				<xsl:variable name="grandparentOutputclass" select="../../@outputclass"/>
				<xsl:variable name="valueToSplitWith" select="substring-after($grandparentOutputclass,'-')"/>
				<xsl:variable name="firstPart" select="substring-before(.,$valueToSplitWith)"/>
				<xsl:variable name="secondPart" select="substring-after(.,$valueToSplitWith)"/>
				<xsl:choose>
					<xsl:when test="contains(., '&#x2011;')">
						<xsl:for-each select="tokenize(., '&#x2011;')">
							<xsl:if test="position() ne 1">
							  <w:noBreakHyphen/>
							</xsl:if>
							<w:t>
							  <xsl:value-of select="."/>
							</w:t>
						 </xsl:for-each>
					</xsl:when>
					<xsl:when test="contains(.,$valueToSplitWith)">
						<w:t>
							<xsl:value-of select="concat($firstPart,$valueToSplitWith)"/>
						</w:t>
						<w:br/>
						<w:t>
							<xsl:value-of select="$secondPart"/>
						</w:t>
					</xsl:when>
					<xsl:otherwise>
						<w:t>
							<xsl:value-of select="."/>
						</w:t>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(parent::*/..[contains(@class, ' topic/title ')]) and exists(parent::*/../..[contains(@outputclass, 'addLineBreak')])">
				<xsl:variable name="grandparentOutputclass" select="../../../@outputclass"/>
				<xsl:variable name="valueToSplitWith" select="substring-after($grandparentOutputclass,'-')"/>
				<xsl:variable name="firstPart" select="substring-before(.,$valueToSplitWith)"/>
				<xsl:variable name="secondPart" select="substring-after(.,$valueToSplitWith)"/>
				<xsl:choose>
					<xsl:when test="contains(., '&#x2011;')">
						<xsl:for-each select="tokenize(., '&#x2011;')">
							<xsl:if test="position() ne 1">
							  <w:noBreakHyphen/>
							</xsl:if>
							<w:t>
							  <xsl:value-of select="."/>
							</w:t>
						 </xsl:for-each>
					</xsl:when>
					<xsl:when test="contains(.,$valueToSplitWith)">
						<w:t>
							<xsl:value-of select="concat($firstPart,$valueToSplitWith)"/>
						</w:t>
						<w:br/>
						<w:t>
							<xsl:value-of select="$secondPart"/>
						</w:t>
					</xsl:when>
					<xsl:otherwise>
						<w:t>
							<xsl:value-of select="."/>
						</w:t>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- Tradeheader Update -->
			  <!-- Origin: 2021 conf template-->
			  <!-- Output: add tabulation logic depending on input outputclass -->
			  <!-- Date : 2021/06/23 -->
			<xsl:when test="exists(parent::*[contains(@outputclass, 'addTab')])">
				<xsl:comment>addTab outputclass detected parent</xsl:comment>
				<xsl:variable name="grandparentOutputclass" select="../@outputclass"/>
				<xsl:variable name="valueToSplitWith" select="substring-after($grandparentOutputclass,'-')"/>
				<xsl:variable name="firstPart" select="substring-before(.,$valueToSplitWith)"/>
				<xsl:variable name="secondPart" select="substring-after(.,$valueToSplitWith)"/>
				<xsl:choose>
					<xsl:when test="contains(., '&#x2011;')">
						<xsl:for-each select="tokenize(., '&#x2011;')">
							<xsl:if test="position() ne 1">
							  <w:noBreakHyphen/>
							</xsl:if>
							<w:t>
							  <xsl:value-of select="."/>
							</w:t>
						 </xsl:for-each>
					</xsl:when>
					<xsl:when test="contains(.,$valueToSplitWith)">
						<w:t>
							<xsl:value-of select="concat($firstPart,$valueToSplitWith)"/>
						</w:t>
						<w:tab/>
						<w:t>
							<xsl:value-of select="$secondPart"/>
						</w:t>
					</xsl:when>
					<xsl:otherwise>
						<w:t>
							<xsl:value-of select="."/>
						</w:t>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(parent::*/..[contains(@outputclass, 'addTab')])">
				<xsl:comment>addTab outputclass detected parent</xsl:comment>
				<xsl:variable name="grandparentOutputclass" select="../../@outputclass"/>
				<xsl:variable name="valueToSplitWith" select="substring-after($grandparentOutputclass,'-')"/>
				<xsl:variable name="firstPart" select="substring-before(.,$valueToSplitWith)"/>
				<xsl:variable name="secondPart" select="substring-after(.,$valueToSplitWith)"/>
				<xsl:choose>
					<xsl:when test="contains(., '&#x2011;')">
						<xsl:for-each select="tokenize(., '&#x2011;')">
							<xsl:if test="position() ne 1">
							  <w:noBreakHyphen/>
							</xsl:if>
							<w:t>
							  <xsl:value-of select="."/>
							</w:t>
						 </xsl:for-each>
					</xsl:when>
					<xsl:when test="contains(.,$valueToSplitWith)">
						<w:t>
							<xsl:value-of select="concat($firstPart,$valueToSplitWith)"/>
						</w:t>
						<w:tab/>
						<w:t>
							<xsl:value-of select="$secondPart"/>
						</w:t>
					</xsl:when>
					<xsl:otherwise>
						<w:t>
							<xsl:value-of select="."/>
						</w:t>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- End of Tradeheader Update -->
			<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="contains(., '&#x2011;')">
						  <xsl:for-each select="tokenize(., '&#x2011;')">
							<xsl:if test="position() ne 1">
							  <w:noBreakHyphen/>
							</xsl:if>
							<w:t>
							  <xsl:value-of select="."/>
							</w:t>
						  </xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
						  <w:t>
							<xsl:value-of select="."/>
						  </w:t>
						</xsl:otherwise>
					  </xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!-- End of Tradeheader Update -->
		
		<!-- Tradeheader Update -->
		  <!-- Origin: validation 2021 -->
		  <!-- Output: add break page between topics -->
		  <!-- Date : 2021/05/24 -->
		<xsl:variable name="topicId" select="ancestor::*[contains(@class, ' topic/topic ')]/@id"/>
		<xsl:if test="following::*[1][contains(@class, ' topic/topic ')][parent::*[contains(@class, ' map/map ')]] and 
		not(ancestor::*[contains(@class, ' topic/topic ')][contains(@outputclass, 'noPageBreak')] or preceding::*[@id = $topicId][contains(@outputclass, 'noPageBreak')])
					and not(parent::*[contains(@class, ' hi-d/i ')]) and not(parent::*[contains(@class, ' topic/term ')]) and not(parent::*[contains(@class, ' hi-d/b ')])
					and not(parent::*[contains(@class, ' hi-d/u ')]) and not(parent::ph)">

			<w:br w:type="page"/>

		</xsl:if>
		<!-- End of Tradeheader Update -->
    </w:r>
  </xsl:template>
	<!-- End of Tradeheader Update -->

  <xsl:template match="*[contains(@class, ' topic/pre ')]//text()">
    <xsl:variable name="styles" as="element()*">
      <xsl:apply-templates select="ancestor::*" mode="inline-style"/>
    </xsl:variable>
    <xsl:for-each select="tokenize(., '\n')">
      <xsl:if test="position() ne 1">
        <w:r>
          <w:br/>
        </w:r>
      </xsl:if>
      <w:r>
        <xsl:if test="exists($styles)">
          <w:rPr>
            <xsl:copy-of select="$styles"/>
          </w:rPr>
        </xsl:if>
        <w:t>
          <xsl:value-of select="replace(., ' ', '&#xA0;')"/>
        </w:t>
      </w:r>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/lines ')]//text()">
    <xsl:variable name="styles" as="element()*">
      <xsl:apply-templates select="ancestor::*" mode="inline-style"/>
    </xsl:variable>
    <xsl:for-each select="tokenize(., '\n')">
      <xsl:if test="position() ne 1">
        <w:r>
          <w:br/>
        </w:r>
      </xsl:if>
      <w:r>
        <xsl:if test="exists($styles)">
          <w:rPr>
            <xsl:copy-of select="$styles"/>
          </w:rPr>
        </xsl:if>
        <w:t>
          <xsl:value-of select="."/>
        </w:t>
      </w:r>
    </xsl:for-each>
  </xsl:template>

	<!-- Tradeheader Update -->
	<!-- Origin: 2021 matrix fro -->
	<!-- Output: support the possibility to create footnotes without any text before the footnote tag -->
	<!-- Date : 2021/07/30 -->
  <xsl:template match="*[contains(@class, ' topic/fn ')]">
	<xsl:choose>
		<xsl:when test="not(ancestor::*[contains(@class, ' topic/p ')]) and not(ancestor::*[contains(@class, ' pr-d/codeblock ')])">
			<w:p>
				<w:r>
				  <w:rPr>
					<w:rStyle w:val="FootnoteReference"/>
				  </w:rPr>
				  <xsl:apply-templates select="." mode="x:get-footnote-reference"/>
				</w:r>
			</w:p>
		</xsl:when>
		<xsl:otherwise>
			<w:r>
			  <w:rPr>
				<w:rStyle w:val="FootnoteReference"/>
			  </w:rPr>
			  <xsl:apply-templates select="." mode="x:get-footnote-reference"/>
			</w:r>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fn ')]" mode="block-style">
    <w:pStyle w:val="FootnoteText"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/fn ')]" mode="x:get-footnote-reference">
    <w:bookmarkStart w:id="note_{x:generate-id(.)}" w:name="{x:bookmark-name($bookmark-prefix.note, .)}"/>
    <w:footnoteReference w:id="{@x:fn-number}"/>
    <w:bookmarkEnd w:id="note_{x:generate-id(.)}"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/draft-comment ')]">
    <xsl:choose>
      <xsl:when test="x:block-content(..)">
        <w:commentReference w:id="{@x:draft-comment-number}"/>
      </xsl:when>
      <xsl:otherwise>
        <w:r>
          <w:rPr>
            <w:rStyle w:val="CommentReference"/>
          </w:rPr>
          <w:commentReference w:id="{@x:draft-comment-number}"/>
        </w:r>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/draft-comment ')]" mode="block-style">
    <w:pStyle w:val="CommentText"/>
  </xsl:template> 
  
	<!-- Tradeheader Extension -->
    <!-- Origin: validation -->
    <!-- Output:  Add an XE or TC field for each XE or TC field found in the dita input file to later generate an index of terms. -->
	<!-- Date : 2021/07/01 -->
	<xsl:template match="//processing-instruction('field')">
		<xsl:if test="contains(., 'XE') or contains(., 'TC')">
			<w:r>
			  <w:fldChar w:fldCharType="begin"/>
			</w:r>
			<w:r>
				<w:instrText>
					<xsl:attribute name="xml:space">preserve</xsl:attribute>

          <xsl:choose>
            <xsl:when test="contains(., 'XE')">
              <xsl:value-of select="."/>
            </xsl:when>
            <!--Substitute the place holder "$TAB\$" for the  ooxml encoding of the Tabulador (Tab key). Ooxml uses Unicode Hex Character-->
            <xsl:otherwise>
              <xsl:value-of select="replace(., '\$TAB\$', '&#x9;')"/>
            </xsl:otherwise>
          </xsl:choose>

				</w:instrText>
			</w:r>
			<w:r>
				<w:fldChar w:fldCharType="separate"/>
			</w:r>
			<w:r>
			  <w:fldChar w:fldCharType="end"/>
			</w:r>
       </xsl:if> 
   </xsl:template>
	<!-- End of Tradeheader Extension -->
  
  <xsl:template match="processing-instruction('oxy_comment_start')">
    <xsl:if test="$debug">
      <xsl:variable name="attributes" as="element()">
        <res>
          <xsl:apply-templates select="." mode="x:parse-pi"/>
        </res>
      </xsl:variable>
      <w:commentRangeStart w:id="{$attributes/@draft-comment-number}"/>
      <xsl:choose>
        <xsl:when test="x:block-content(..)">
          <w:commentReference w:id="{$attributes/@draft-comment-number}"/>
        </xsl:when>
        <xsl:otherwise>
          <w:r>
            <w:rPr>
              <w:rStyle w:val="CommentReference"/>
            </w:rPr>
            <w:commentReference w:id="{$attributes/@draft-comment-number}"/>
          </w:r>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="processing-instruction('oxy_comment_end')">
    <xsl:if test="$debug">
      <xsl:variable name="start" select="preceding::processing-instruction('oxy_comment_start')[1]" as="processing-instruction()"/>
      <xsl:variable name="attributes" as="element()">
        <res>
          <xsl:apply-templates select="$start" mode="x:parse-pi"/>
        </res>
      </xsl:variable>
      <w:commentRangeEnd w:id="{$attributes/@draft-comment-number}"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/draft-comment ')] |
                       processing-instruction('oxy_comment_start')"
                mode="block-style">
    <w:pStyle w:val="CommentText"/>
  </xsl:template>

  <xsl:template match="*[contains(@class, ' topic/indexterm ')]"/>
  
  <xsl:template match="*[contains(@class,' topic/term ')]" name="topic.term">
    <xsl:param name="keys" select="@keyref" as="attribute()?"/>
    <xsl:param name="contents" as="node()*">
      <xsl:variable name="target" select="key('id', substring(@href, 2), $root)" as="element()*"/>
      <xsl:choose>
        <xsl:when test="not(normalize-space(.)) and $keys and $target/self::*[contains(@class,' topic/topic ')]">
          <xsl:apply-templates select="$target/*[contains(@class, ' topic/title ')]/node()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <!-- FIXME: create link because Word REF will pull link content from target -->
    <!--xsl:variable name="topicref" select="key('map-id', substring(@href, 2))"/>
    <xsl:choose>
      <xsl:when test="$keys and @href and not($topicref/ancestor-or-self::*[@linking][1]/@linking = ('none', 'sourceonly'))">
        <xsl:call-template name="topic.xref">
          <xsl:with-param name="contents" select="$contents"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise-->
        <xsl:copy-of select="$contents"/>
      <!--/xsl:otherwise>
    </xsl:choose-->
  </xsl:template>
  
  <xsl:template match="processing-instruction('br')">
    <w:r>
      <w:br/>
    </w:r>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/tm ')]" name="topic.tm">
    <xsl:apply-templates/>
    <w:r>
      <w:rPr>
        <xsl:apply-templates select="ancestor-or-self::*" mode="inline-style"/>
      </w:rPr>
      <w:t>
        <xsl:choose>
          <xsl:when test="@tmtype = 'tm'">&#x2122;</xsl:when>
          <xsl:when test="@tmtype = 'reg'">&#xAE;</xsl:when>
          <xsl:when test="@tmtype = 'service'">&#x2120;</xsl:when>
        </xsl:choose>
      </w:t>
    </w:r>
  </xsl:template>
  
</xsl:stylesheet>
