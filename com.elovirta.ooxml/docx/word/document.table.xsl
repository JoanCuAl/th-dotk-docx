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

  <xsl:variable name="table-col-total" select="xs:integer($body-width)" as="xs:integer"/>
  <xsl:variable name="table.frame-default" select="'all'" as="xs:string"/>

  <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" name="table.title">
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
           <xsl:with-param name="id" select="'Table'"/>
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
        <xsl:number count="*[contains(@class, ' topic/table ')][*[contains(@class, ' topic/title ')]]" level="any"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$auto-number">
          <w:fldSimple w:instr=" SEQ Table \* ARABIC ">
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
  
  <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" mode="block-style">
    <w:pStyle w:val="Caption"/>
    <w:keepNext/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/table ')]" name="table">
    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
    

	<w:tbl>
      <xsl:apply-templates select="*[contains(@class, ' topic/tgroup ')]"/>
    </w:tbl>
	<!-- Tradeheader Update -->
	<!-- Document : Clause Library -->
	<!-- Date : 2021/07/26 -->
	<!-- Target: control table spacing before and after -->
	<xsl:if test="$docx.config/body/docx.tableSpacing.before != '0'">
		<w:pPr>
			<w:spacing w:before="{$docx.config/body/docx.tableSpacing.before}"/>
		</w:pPr>
	</xsl:if>
	<xsl:if test="$docx.config/body/docx.tableSpacing.after != '0'">
		<w:pPr>
			<w:spacing w:after="{$docx.config/body/docx.tableSpacing.after}"/>
		</w:pPr>
	</xsl:if>
	<!-- End of Tradeheader Update -->
    <!--<xsl:apply-templates select="."  mode="table-fn"/>-->
	
	<!-- Tradeheader Update -->
	<!-- Document : 2021 form of ammenmend -->
	<!-- Date : 2021/06/15 -->
	<!-- Target: control page orientation -->
	<xsl:if test="following::*[1][contains(@outputclass, 'pageBreak')]">
		<xsl:comment>following page break found</xsl:comment>
		<w:p>
			<w:r>
				<w:br w:type="page"/>
			</w:r>
		</w:p>
	</xsl:if>
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
	<xsl:apply-templates select="." mode="docOrientation"/>
  </xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : fx-matrix-poc -->
	<!-- Date : 2021/03/25 -->
	<!-- Target: table footnotes will be processed as regular footnotes. -->
	<!--<xsl:template match="*[contains(@class, ' topic/table ')]" mode="table-fn">
    <xsl:variable name="fn-style" as="element()*">
      <xsl:if test="(@expanse, $expanse.default)[1] = 'page' or (@pgwide, $pgwide.default)[1] = '1'">
        <w:ind w:left="0"/>
      </xsl:if>
    </xsl:variable>
    <xsl:for-each select="descendant::*[contains(@class, ' topic/fn ')]">
      <w:p>
        <w:pPr>
          <xsl:apply-templates select="." mode="block-style"/>
          <xsl:if test="position() eq last()">
            <w:spacing w:after="120"/>
          </xsl:if>
          <xsl:copy-of select="$fn-style"/>
        </w:pPr>
        <xsl:apply-templates select="."/>
        <w:r>
          <w:t xml:space="preserve"> </w:t>
        </w:r>
        <xsl:apply-templates/>
      </w:p>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/table ')]//*[contains(@class, ' topic/fn ')]"  mode="x:get-footnote-reference">
    <w:t>
      <xsl:variable name="fn" select="."/>
      <xsl:for-each select="ancestor::*[contains(@class, ' topic/table ')][1]/descendant::*[contains(@class, ' topic/fn ')]">
        <xsl:if test=". is $fn">
          <xsl:value-of select="position()"/>
        </xsl:if>
      </xsl:for-each>
    </w:t>
  </xsl:template>-->
<!-- End of Tradeheader Update -->

  <xsl:template match="*[contains(@class, ' topic/tgroup ')]" name="tgroup">
    <xsl:variable name="styles" as="node()*">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:variable>
    <xsl:if test="exists($styles)">
      <w:tblPr>
        <xsl:copy-of select="$styles"/>
		<!-- Tradeheader Update -->
		<!-- Document : 2021 Form of Amendment -->
		<!-- Date : 2021/06/16 -->
		<!-- Target: use white borders for borderless tables. -->
		<xsl:if test="ancestor::*[contains(@outputclass, 'borderless')]">
		 <w:tblBorders>
			<w:top w:color="FFFFFF" />
			<w:start w:color="FFFFFF" />
			<w:bottom w:color="FFFFFF" />
			<w:end w:color="FFFFFF" />
			<w:insideH w:color="FFFFFF" />
			<w:insideV color="FFFFFF" />
		</w:tblBorders>
		</xsl:if>
		<!-- End of Tradeheader Update -->
      </w:tblPr>
    </xsl:if>
    <w:tblGrid>
      <xsl:apply-templates select="*[contains(@class, ' topic/colspec ')]"/>
    </w:tblGrid>

	<xsl:apply-templates select="*[contains(@class, ' topic/thead ')]"/>
	<xsl:apply-templates select="*[contains(@class, ' topic/tbody ')]"/>
  </xsl:template>

  
  <xsl:template match="*[contains(@class, ' topic/thead ')]">
    <xsl:apply-templates select="*[contains(@class, ' topic/row ')]"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/tbody ')]">
    <xsl:apply-templates select="*[contains(@class, ' topic/row ')]"/>
  </xsl:template>
  
  <xsl:variable name="pgwide.default" select="'0'" as="xs:string"/>
  <xsl:variable name="expanse.default" select="'column'" as="xs:string"/>
  
  <xsl:template match="*[contains(@class, ' topic/tgroup ')]" mode="block-style">
    <w:tblStyle>
      <xsl:attribute name="w:val">
        <xsl:choose>
          <xsl:when test="(@frame, $table.frame-default)[1] = 'all'">TableGrid</xsl:when>
          <xsl:otherwise>TableNormal</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </w:tblStyle>
    <xsl:choose>
      <xsl:when test="(../@expanse, $expanse.default)[1] = 'page' or (../@pgwide, $pgwide.default)[1] = '1'">
        <w:tblW w:w="5000" w:type="pct"/>
        <w:tblInd w:w="0" w:type="dxa"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="depth" as="xs:integer">
          <xsl:apply-templates select="." mode="block-depth"/>
        </xsl:variable>
		<!-- Tradeheader Update -->
		<!-- Date : 2021/07/26 -->
		<!-- Origin: 2021 matrices fro -->
		<!-- Target: Set default table width and identation using external parameters -->
        <w:tblW w:w="{$docx.config/body/docx.tableWidth.value}" w:type="{$docx.config/body/docx.tableWidth.type}"/>
        <w:tblInd w:w="{$docx.config/body/docx.tableIdent.value}" w:type="{$docx.config/body/docx.tableIdent.type}"/>
		<!-- End of Tradeheader Update -->
      </xsl:otherwise>
    </xsl:choose>
    <w:tblLook w:val="04A0"
      w:firstRow="{if (exists(*[contains(@class, ' topic/thead ')])) then 1 else 0}"
      w:lastRow="0"
      w:firstColumn="{if (../@rowheader = 'firstcol') then 1 else 0}"
      w:lastColumn="0"
      w:noHBand="1"
      w:noVBand="1"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/colspec ')]">
    <w:gridCol w:w="2435"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/row ')]">
    <xsl:variable name="styles" as="node()*">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:variable>
    <w:tr>
      <xsl:if test="exists($styles)">
        <w:trPr>
          <xsl:copy-of select="$styles"/>
        </w:trPr>
      </xsl:if>
      <xsl:apply-templates select="*[contains(@class, ' topic/entry ')][1]"/>
    </w:tr>
  </xsl:template>
  
	<!-- Tradeheader Update -->
	<!-- Date : 2021/07/26 -->
	<!-- Origin: 2021 matrices fro -->
	<!-- Target: Set cantSplit on table tbody and thead depending on external variable -->
  <xsl:template match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' topic/row ')]" mode="block-style">
    <xsl:if test="$docx.config/body/docx.tableTbody.cantSplit = 'true'">
		<w:cantSplit/>
	</xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')]" mode="block-style">
    <w:tblHeader/>
    <!--w:jc w:val="center"/-->
    <xsl:if test="$docx.config/body/docx.tableThead.cantSplit = 'true'">
		<w:cantSplit/>
	</xsl:if>
  </xsl:template>
	<!-- End of Tradeheader Update -->
 
   <xsl:template match="*[contains(@class, ' topic/entry ')]">
    <xsl:param name="currentpos" select="1"/>
    <xsl:variable name="col-max-num" as="xs:integer"
                  select="xs:integer(../../../@cols)"/>
    <xsl:variable name="startpos" as="xs:integer">
      <xsl:call-template name="find-entry-start-position"/>
    </xsl:variable>
    <xsl:variable name="endpos" as="xs:integer">
      <xsl:call-template name="find-entry-end-position">
        <xsl:with-param name="startposition" select="$startpos"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$startpos gt $currentpos">
      <xsl:call-template name="emit-empty-cell">
        <xsl:with-param name="startpos" select="$startpos"/>
        <xsl:with-param name="currentpos" select="$currentpos"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:variable name="styles" as="node()*">
      <xsl:apply-templates select="." mode="block-style"/>
    </xsl:variable>
    <w:tc>
		
	
	
	<!-- Tradeheader Extension -->
	<!-- Date : 2021/07/26 -->
	<!-- Origin: 2021 fro matrix -->
	<!-- Target: Set background cell color depending on an outputclass  -->
	<xsl:if test="ancestor-or-self::*[contains(@outputclass, 'fill_')]">
		<xsl:for-each select="ancestor-or-self::*/@outputclass">
			<xsl:if test="contains(., 'fill_')">
				<xsl:variable name="hexaCode" select="substring(substring-after(.,'#'),1,6)"/>
				<w:tcPr>
				  <w:shd w:val="clear" w:color="auto" w:fill="{$hexaCode}"/>
				</w:tcPr>
			</xsl:if>
		</xsl:for-each>
	</xsl:if>
	<!-- End of Tradeheader Extension -->
	<xsl:comment>docx table thead vertical aligment <xsl:value-of select="$docx.tableTheadVerticalAligment"/></xsl:comment>
	<!-- Tradeheader Extension -->
	<!-- Date : 2021/07/26 -->
	<!-- Origin: 2021 fro matrix -->
	<!-- Target: Set table thead text vertical alignment depending on external variable  -->
	<xsl:if test="$docx.config/body/docx.tableTheadVerticalAligment and ancestor::*[contains(@class, ' topic/thead ')]">
		<xsl:choose>
			<xsl:when test="$docx.config/body/docx.tableTheadVerticalAligment = 'bottom'">
				<xsl:comment>inside text vertical bottom</xsl:comment>
				<w:tcPr>
					<w:vAlign w:val="bottom"/>
				</w:tcPr>
			</xsl:when>
			<xsl:when test="$docx.config/body/docx.tableTheadVerticalAligment = 'center'">
				<xsl:comment>inside text vertical center</xsl:comment>
				<w:tcPr>
					<w:vAlign w:val="center"/>
				</w:tcPr>
			</xsl:when>
			<xsl:when test="$docx.config/body/docx.tableTheadVerticalAligment = 'top'">
				<xsl:comment>inside text vertical top</xsl:comment>
				<w:tcPr>
					<w:vAlign w:val="top"/>
				</w:tcPr>
			</xsl:when>
		</xsl:choose>
	</xsl:if>
	<!-- End of Tradeheader Extension -->
	
	<!-- Tradeheader Update -->
	<!-- Date : 2020/05/06 -->
	<!-- Origin: validation 2021 -->
	<!-- Target: Set diferent column width depending on table outputclass. Add a logic that checks if empty cells have been added. 
		If docx.tableColWidth.source external variable is set to dita it reads the colwidth specified in the dita files to asign a colwidth -->
		<xsl:comment>cold width external <xsl:value-of select="$docx.config/body/docx.tableColWidth.source"/></xsl:comment>
	<xsl:choose>
		<xsl:when test="$startpos gt $currentpos">
			<xsl:variable name="position" select="count(preceding-sibling::*[contains(@class, ' topic/entry ')]) + 1 + xs:integer($startpos - $currentpos)"/>
			<xsl:choose>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_empty_2cols_evenly')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="450"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_empty_1col')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="250"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_short_1col_long')]">
						<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="1314"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
								  <xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="3686"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_short_2cols_evenly')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="1314"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '2cols_evenly')]">
					<w:tcPr>
						<xsl:if test="exists($styles)">
							<xsl:copy-of select="$styles"/>
						</xsl:if>
						<w:tcW w:type="pct" w:w="1314"/>
					</w:tcPr>
				</xsl:when>
				<xsl:when test="contains($docx.config/body/docx.tableColWidth.source, 'dita')">
					<xsl:variable name="entryPosition" select="count(preceding-sibling::*[contains(@class, ' topic/entry ')]) + 1"/>
					
					<xsl:variable name="entryColWidth" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[$entryPosition]/@colwidth"/>
					
					<xsl:variable name="entryColWidthWithoutPt" select="substring($entryColWidth, 1, string-length($entryColWidth) - 2)" />
					<xsl:comment>inside dita col width <xsl:value-of select="$entryColWidthWithoutPt"/></xsl:comment>
					<w:tcPr>
						<xsl:if test="exists($styles)">
							<xsl:copy-of select="$styles"/>
						</xsl:if>
						<w:tcW w:type="pct" w:w="{$entryColWidthWithoutPt}"/>
					</w:tcPr>
				</xsl:when>
				<xsl:otherwise>
						<xsl:if test="exists($styles)">
						<w:tcPr>
						  <xsl:copy-of select="$styles"/>
						</w:tcPr>
					  </xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:comment>inside otherwise</xsl:comment>
			<xsl:variable name="position" select="count(preceding-sibling::*[contains(@class, ' topic/entry ')]) + 1"/>
			<xsl:choose>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_empty_2cols_evenly')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="450"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_empty_1col')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="250"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_short_1col_long')]">
						<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="1314"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
								  <xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="3686"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '1col_short_2cols_evenly')]">
					<xsl:choose>
							<xsl:when test="$position = 1">
								<w:tcPr>
								<xsl:if test="exists($styles)">
								  <xsl:copy-of select="$styles"/>
								  </xsl:if>
								  <w:tcW w:type="pct" w:w="1314"/>
								</w:tcPr>
							</xsl:when>
							<xsl:otherwise>
								<w:tcPr>
									<xsl:if test="exists($styles)">
										<xsl:copy-of select="$styles"/>
									</xsl:if>
									<w:tcW w:type="pct" w:w="1800"/>
								</w:tcPr>
							</xsl:otherwise>
					  </xsl:choose>
				</xsl:when>
				<xsl:when test="ancestor::*[contains(@outputclass, '2cols_evenly')]">
					<w:tcPr>
						<xsl:if test="exists($styles)">
							<xsl:copy-of select="$styles"/>
						</xsl:if>
						<w:tcW w:type="pct" w:w="1314"/>
					</w:tcPr>
				</xsl:when>
				<xsl:when test="contains($docx.config/body/docx.tableColWidth.source, 'dita')">		
					<xsl:variable name="entryPosition" select="count(preceding-sibling::*[contains(@class, ' topic/entry ')]) + 1"/>
					
					<xsl:variable name="entryColWidth" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[$entryPosition]/@colwidth"/>
					
					<xsl:variable name="entryColWidthWithoutPt" select="substring($entryColWidth, 1, string-length($entryColWidth) - 2)" />

					<xsl:comment>inside dita col width <xsl:value-of select="$entryColWidthWithoutPt"/></xsl:comment>

					
					<w:tcPr>
						<xsl:if test="exists($styles)">
							<xsl:copy-of select="$styles"/>
						</xsl:if>
						<w:tcW w:type="pct" w:w="{$entryColWidthWithoutPt}"/>
					</w:tcPr>
				</xsl:when>
				<xsl:otherwise>
					<xsl:comment>inside otherwise 2</xsl:comment>
						<xsl:if test="exists($styles)">
						<w:tcPr>
						  <xsl:copy-of select="$styles"/>
						</w:tcPr>
					  </xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
	<!-- End of Tradeheader Update -->
	
	<xsl:if test="self::*[contains(@outputclass, 'invisible_cell')]">
		<xsl:comment>inside invisible cell <xsl:value-of select="@outputclass"/></xsl:comment>
		<w:tcPr>
			<w:tcBorders>
				<w:top w:val="nil"/>
				<w:left w:val="nil"/>
				<w:right w:val="nil"/>
				<w:bottom w:val="nil"/>
			</w:tcBorders>
			<w:shd w:val="clear" w:color="auto" w:fill="auto"/>
		</w:tcPr>
	</xsl:if>
      
      <xsl:apply-templates select="*"/>
      <xsl:if test="empty(*)">
        <w:p/>
      </xsl:if>
    </w:tc>
    <xsl:if test="following-sibling::*[contains(@class,' topic/entry ')]">
      <xsl:apply-templates select="following-sibling::*[contains(@class,' topic/entry ')][1]">
        <xsl:with-param name="currentpos" select="$endpos + 1"/>
      </xsl:apply-templates>
    </xsl:if>
    <xsl:if test="not(following-sibling::*[contains(@class,' topic/entry ')]) and not(($endpos + 1) gt $col-max-num)">
      <!-- if this is the last entry in current row and next position is not greater than the number of columns in a row-->
      <xsl:call-template name="emit-empty-cell">
        <xsl:with-param name="startpos" select="$col-max-num + 1"/>
        <!-- make sure the remaining columns will be generated -->
        <xsl:with-param name="currentpos" select="$endpos + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/entry ')]" mode="block-style">
    <xsl:variable name="rowspan" as="xs:integer"
                  select="if (@morerows) then xs:integer(@morerows) + 1 else 1"/>
    <xsl:variable name="colspan" as="xs:integer">
      <xsl:call-template name="find-colspan"/>
    </xsl:variable>
    <!--xsl:if test="$rowspan gt 1 and $colspan gt 1">
      <xsl:message terminate="no">FATAL: Table entry rowspan=<xsl:value-of select="$rowspan"/> and colspan=<xsl:value-of select="$colspan"/> not supported.</xsl:message>
      <xsl:comment>rowspan=<xsl:value-of select="$rowspan"/> colspan=<xsl:value-of select="$colspan"/> startpos=<xsl:value-of select="$startpos"/> endpos=<xsl:value-of select="$endpos"/></xsl:comment>
    </xsl:if-->
    <!--xsl:comment>currentpos=<xsl:value-of select="$currentpos"/></xsl:comment-->
    <!--w:tcW w:w="2434" w:type="dxa"/-->
    <!--xsl:comment>rowspan=<xsl:value-of select="$rowspan"/> colspan=<xsl:value-of select="$colspan"/> startpos=<xsl:value-of select="$startpos"/> endpos=<xsl:value-of select="$endpos"/></xsl:comment-->
    <xsl:if test="$colspan gt 1">
      <w:gridSpan w:val="{$colspan}"/>
    </xsl:if>
    <xsl:if test="$rowspan gt 1">
      <w:vMerge>
        <xsl:if test="@morerows">
          <xsl:attribute name="w:val">restart</xsl:attribute>
        </xsl:if>
      </w:vMerge>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="find-entry-start-position" as="xs:integer">
    <xsl:choose>
      <!-- if the column number is specified, use it -->
      <xsl:when test="@colnum">
        <xsl:sequence select="xs:integer(@colnum)"/>
      </xsl:when>
      <xsl:when test="not(../../../*[contains(@class,' topic/colspec ')])">
        <xsl:sequence select="count(preceding-sibling::*) + 1"/>
      </xsl:when>
      <!-- If there is a defined column name, check the colspans to determine position -->
      <xsl:when test="@colname">
        <!-- Tradeheader Update -->
		<!-- Origin: validation 2021-->
		<!-- Output:  Add a protection to parsing resulting in incorrect colname. -->
		<!-- Date : 2021/05/13 -->
        <xsl:variable name="oldStartPos" select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = current()/@colname]/preceding-sibling::*[contains(@class, ' topic/colspec ')])+1)"/>
		<xsl:variable name="precedingRowWithMoreRows" select="parent::*[contains(@class,' topic/row ')]/preceding-sibling::*/*[contains(@class,' topic/entry ')][@colname = current()/@colname][@morerows]"/>
		<xsl:variable name="precedingRows" select="count(parent::*[contains(@class,' topic/row ')]/preceding-sibling::*)"/>
		

		<xsl:choose>
			<xsl:when test="count($precedingRowWithMoreRows) = 1">
				<xsl:choose>
				  <xsl:when test="($precedingRows &lt; $precedingRowWithMoreRows/@morerows) or ($precedingRows = $precedingRowWithMoreRows/@morerows)">
				    <xsl:sequence select="xs:integer($oldStartPos + 1)"/>
				  </xsl:when>
				  <xsl:otherwise>
				    <xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = current()/@colname]/preceding-sibling::*[contains(@class, ' topic/colspec ')])+1)"/>
				  </xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = current()/@colname]/preceding-sibling::*[contains(@class, ' topic/colspec ')])+1)"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- End of Tradeheader Update -->
      </xsl:when>
      <!-- If the starting column is defined, check colspans to determine position -->
      <xsl:when test="@namest">
        <xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = current()/@namest]/preceding-sibling::*[contains(@class, ' topic/colspec ')])+1)"/>
      </xsl:when>
      <!-- Need a test for spanspec -->
      <xsl:when test="@spanname">
        <xsl:variable name="startspan" select="../../../*[contains(@class,' topic/spanspec ')][@spanname = current()/@spanname]/@namest"/>
        <xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = $startspan]/preceding-sibling::*[contains(@class, ' topic/colspec ')]) + 1)"/>
      </xsl:when>
      <!-- Otherwise, just use the count of cells in this row -->
      <xsl:otherwise>
        <xsl:sequence select="count(preceding-sibling::*) + 1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="find-entry-end-position" as="xs:integer">
    <xsl:param name="startposition" select="0" as="xs:integer"/>
    <xsl:choose>
      <xsl:when test="not(../../../*[contains(@class,' topic/colspec ')])">
        <xsl:sequence select="$startposition"/>
      </xsl:when>
      <xsl:when test="@nameend">
        <xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = current()/@nameend]/preceding-sibling::*[contains(@class, ' topic/colspec ')]) + 1)"/>
      </xsl:when>
      <xsl:when test="@spanname">
        <xsl:variable name="endspan" select="../../../*[contains(@class,' topic/spanspec ')][@spanname=current()/@spanname]/@nameend"/>
        <xsl:sequence select="xs:integer(count(../../../*[contains(@class,' topic/colspec ')][@colname = $endspan]/preceding-sibling::*[contains(@class, ' topic/colspec ')]) + 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="$startposition"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="emit-empty-cell">
    <xsl:param name="currentpos" select="1" as="xs:integer"/>
    <xsl:param name="startpos" select="1" as="xs:integer"/>
    <xsl:if test="$startpos gt $currentpos">
      <xsl:variable name="colspan" as="xs:integer?">
        <xsl:apply-templates select="../preceding-sibling::*[*[contains(@class,' topic/entry ')][@morerows][@colnum = $currentpos or @colname = concat('col',$currentpos) or @namest = concat('col',$currentpos)]][1]/*[contains(@class,' topic/entry ')][@morerows][@colnum = $currentpos or @colname = concat('col',$currentpos) or @namest = concat('col',$currentpos)]" mode="find-colspan"/>
      </xsl:variable>
      <w:tc>      
        <w:tcPr>
          <!--w:tcW w:w="2434" w:type="dxa"/-->
          <xsl:if test="exists($colspan) and $colspan gt 1">
            <w:gridSpan w:val="{$colspan}"/>  
          </xsl:if>          
          <w:vMerge/>
        </w:tcPr>
        <w:p>
          <w:pPr>
            <w:ind w:left="0"/>
          </w:pPr>
        </w:p>
      </w:tc>
      <xsl:if test="exists($colspan) and ($startpos gt ($currentpos + $colspan))">
        <xsl:call-template name="emit-empty-cell">
          <xsl:with-param name="startpos" select="$startpos"/>
          <xsl:with-param name="currentpos" select="$currentpos + $colspan"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="*[contains(@class,' topic/entry ')]" mode="find-colspan" as="xs:integer">
    <xsl:call-template name="find-colspan"/>
  </xsl:template>
  
  <xsl:template name="find-colspan" as="xs:integer">
    <xsl:variable name="startpos" as="xs:integer">
      <xsl:call-template name="find-entry-start-position"/>
    </xsl:variable>
    <xsl:variable name="endpos" as="xs:integer">
      <xsl:call-template name="find-entry-end-position">
        <xsl:with-param name="startposition" select="$startpos"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:sequence select="$endpos - $startpos + 1"/>
  </xsl:template>

  <!--xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')]/*[contains(@class, ' topic/entry ')]" mode="inline-style">
    <w:b w:val="true"/>
  </xsl:template-->
  
  <xsl:template match="*[contains(@class, ' topic/simpletable ')]" name="simpletable">
    <w:tbl>
      <xsl:variable name="styles" as="node()*">
        <xsl:apply-templates select="." mode="block-style"/>
      </xsl:variable>
      <xsl:if test="exists($styles)">
        <w:tblPr>
          <xsl:copy-of select="$styles"/>
        </w:tblPr>
      </xsl:if>
      <xsl:variable name="widths" as="xs:integer*">
        <xsl:choose>
          <xsl:when test="@relcolwidth">
            <xsl:variable name="cols" as="xs:decimal+"><!-- W content uses decimals instead of integers -->
              <xsl:for-each select="tokenize(translate(@relcolwidth, '*', ''), '\s')">
                <xsl:sequence select="xs:decimal(.)"/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="sum" select="sum($cols)" as="xs:decimal"/>
            <xsl:for-each select="$cols">
              <xsl:sequence select="xs:integer(round((. div $sum) * $table-col-total))"/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence select="()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <w:tblGrid>
        <xsl:for-each select="$widths">
          <w:gridCol w:w="{.}"/>
        </xsl:for-each>
      </w:tblGrid>
      <xsl:apply-templates select="*[contains(@class, ' topic/strow ')]">
        <xsl:with-param name="widths" select="$widths" as="xs:integer*"/>
      </xsl:apply-templates>
    </w:tbl>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/simpletable ')]" mode="block-style">
    <w:tblStyle>
      <xsl:attribute name="w:val">
        <xsl:choose>
          <xsl:when test="(@frame, $table.frame-default)[1] = 'all'">TableGrid</xsl:when>
          <xsl:otherwise>TableNormal</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </w:tblStyle>
    <w:tblW w:w="0" w:type="auto"/>
    
    <xsl:variable name="depth" as="xs:integer">
      <xsl:apply-templates select="." mode="block-depth"/>
    </xsl:variable>
    <w:tblInd w:w="{x:get-indent($depth)}" w:type="dxa"/>
    <w:tblLook w:val="04A0"
      w:firstRow="{if (exists(*[contains(@class, ' topic/sthead ')])) then 1 else 0}"
      w:lastRow="0"
      w:firstColumn="{if (@keycol = 1) then 1 else 0}"
      w:lastColumn="0"
      w:noHBand="1"
      w:noVBand="1"/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/strow ')]">
    <xsl:param name="widths" as="xs:integer*"/>
    <w:tr>
      <xsl:for-each select="*[contains(@class, ' topic/stentry ')]">
        <xsl:variable name="position" select="position()"/>
        <xsl:apply-templates select=".">
          <xsl:with-param name="width" select="$widths[position() = $position]"/>
        </xsl:apply-templates>  
      </xsl:for-each>
    </w:tr>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/stentry ')]">
    <xsl:param name="width" as="xs:integer?"/>
    <w:tc>
      <xsl:if test="exists($width)">
        <w:tcPr>
          <w:tcW w:w="{$width}" w:type="dxa"/>
        </w:tcPr>
      </xsl:if>
      <xsl:apply-templates select="*"/>
      <xsl:if test="empty(*)">
        <w:p/>
      </xsl:if>
    </w:tc>
  </xsl:template>

</xsl:stylesheet>
