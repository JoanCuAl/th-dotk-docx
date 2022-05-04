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
  xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:x="com.elovirta.ooxml" version="2.0"
  exclude-result-prefixes="x xs">

	<xsl:import href="document.xsl"/>

	<!-- Tradeheader Update -->
	  <!-- Desc: Aknowledge docx.publication parameter in this scope. -->
	  <xsl:param name="docx.publication"/>
  
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

	<xsl:variable name="doc" select="document(concat($template.dir, 'word/numbering.xml'))" as="document-node()?"/>

	<xsl:template match="/">
		<w:numbering>
				<xsl:comment>docx config <xsl:value-of select="$docx.config"/></xsl:comment>
			<xsl:for-each select="//@x:list-number">
			
				<!-- Tradeheader Update -->
				<!-- Document : main book v4 -->
				<!-- Target: The actual depth of the list being defined. This way we can support different list styles inside other lists -->
				<!-- Date : 2021/12/20 -->
				<xsl:variable name="break" as="element()"
				  select="ancestor::*[contains(@class, ' topic/topic ') or contains(@class, ' topic/table ') or contains(@class, ' topic/simpletable ')][1]"/>
				<xsl:variable name="depth" as="xs:integer"
				  select="count(ancestor::*[contains(@class, ' topic/ul ') or contains(@class, ' topic/ol ')][. >> $break])"/>
				<!-- End of Tradeheader Update -->
			
				<xsl:comment>depth <xsl:value-of select="$depth"/></xsl:comment>
			
				<!-- Tradeheader Update -->
				<!-- Document : fx -->
				<!-- Target: Get the starting position of each level of the list. -->
				<!-- Date : 2021/12/14 -->
				<xsl:choose>
					<xsl:when test="contains(../@class, ' topic/ol')">
						<!-- Setup default values -->
						<xsl:variable name="startFrom1" select="1"/>
						<xsl:variable name="startFrom2" select="1"/>
						<xsl:variable name="startFrom3" select="1"/>
						<xsl:variable name="startFrom4" select="1"/>
						<xsl:variable name="startFrom5" select="1"/>
						<xsl:variable name="startFrom6" select="1"/>
						<xsl:variable name="startFrom7" select="1"/>
						<xsl:variable name="startFrom8" select="1"/>
						<xsl:variable name="startFrom9" select="1"/>
						
						<xsl:choose>
							<xsl:when test="contains(parent::*/@outputclass, 'startFrom_')">
							
								<xsl:variable name="startFrom" select="tokenize(substring-after(parent::*/@outputclass,'startFrom_'),' ')[1]"/>
								<xsl:variable name="pairsSequence" select="tokenize($startFrom,'\|')"/>
								
								<!-- Generate one variable for each level of the list -->
								<xsl:variable name="startFrom1">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'1_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom2">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'2_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom3">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'3_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom4">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'4_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom5">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'5_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom6">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'6_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom7">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'7_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom8">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'8_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								<xsl:variable name="startFrom9">
									<xsl:for-each select="$pairsSequence">
										<xsl:if test="contains(.,'9_')">
											<xsl:value-of select="tokenize(.,'_')[2]"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:variable>
								
								<xsl:call-template name="ol">
									<xsl:with-param name="number" select="."/>
									<xsl:with-param name="indent-start" select="xs:integer($indent-base)"/>
									<xsl:with-param name="indent-start-left" select="xs:integer($indent-baseBodyText1)"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="ol">
									<xsl:with-param name="number" select="."/>
									<xsl:with-param name="indent-start" select="xs:integer($indent-base)"/>
									<xsl:with-param name="indent-start-left" select="xs:integer($indent-baseBodyText1)"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="ul">
							<xsl:with-param name="number" select="."/>
							<xsl:with-param name="indent-start" select="xs:integer($indent-base)"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<!-- End of Tradeheader Update -->
				
			</xsl:for-each>
			<!-- original numberings -->
			<xsl:copy-of select="$doc/w:numbering/w:abstractNum"/>
			<!-- list numbering -->
			<xsl:for-each select="//@x:list-number">
				<w:num w:numId="{.}">
					<w:abstractNumId w:val="{.}"/>
				</w:num>
			</xsl:for-each>

			<!-- original numberings -->
			<xsl:copy-of select="$doc/w:numbering/w:num"/>
		</w:numbering>
	</xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Add different list identation logic depending on input outputclass -->
	<!-- Date : 2021/05/12 -->
	<xsl:template name="ol">
		<xsl:param name="number" as="xs:string"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="indent-start-left" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		
		<xsl:choose>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_(i)(A)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_i_parenthesis_a_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_i_parenthesis_a_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_ia(1)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_ia1_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_ia1_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_iaI1')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_iaI1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_iaI1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_ia1')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_ia1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_ia1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_i')]) or exists(ancestor-or-self::*[contains(@outputclass, 'listType_(i)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_i_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_i_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_A')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_A">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_A">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_(1)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_1_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_1_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_1')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_1">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_I')]) or exists(ancestor-or-self::*[contains(@outputclass, 'listType_(I)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_I">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_I">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_(a)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_a_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_a_parenthesis">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'listType_(A)')])">
				<xsl:choose>
					<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
						<xsl:apply-templates select="." mode="ol_listType_A">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start-left"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="ol_listType_A">
							<xsl:with-param name="number" select="$number"/>
							<xsl:with-param name="indent-start" select="$indent-start"/>
							<xsl:with-param name="depth" select="$depth"/>
							<xsl:with-param name="startFrom1" select="$startFrom1"/>
							<xsl:with-param name="startFrom2" select="$startFrom2"/>
							<xsl:with-param name="startFrom3" select="$startFrom3"/>
							<xsl:with-param name="startFrom4" select="$startFrom4"/>
							<xsl:with-param name="startFrom5" select="$startFrom5"/>
							<xsl:with-param name="startFrom6" select="$startFrom6"/>
							<xsl:with-param name="startFrom7" select="$startFrom7"/>
							<xsl:with-param name="startFrom8" select="$startFrom8"/>
							<xsl:with-param name="startFrom9" select="$startFrom9"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="contains($docx.publication, 'interestRates_2021Ird_mainBook')">
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol_2021MainBook">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol_2021MainBook">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$docx.publication = 'standard_fx_bechmarksSupp'">	
						<xsl:choose>	
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">	
								<xsl:apply-templates select="." mode="ol_standard_fx_bechmarksSupp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start-left"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:when>	
							<xsl:otherwise>	
								<xsl:apply-templates select="." mode="ol_standard_fx_bechmarksSupp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:otherwise>	
						</xsl:choose>	
					</xsl:when>	
					<xsl:when test="$docx.publication = 'standard_fx_1998FxDef'">	
						<xsl:choose>	
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">	
								<xsl:apply-templates select="." mode="ol_standard_fx_1998FxDef">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start-left"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:when>	
							<xsl:otherwise>	
								<xsl:apply-templates select="." mode="ol_standard_fx_1998FxDef">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:otherwise>	
						</xsl:choose>	
					</xsl:when>
					<xsl:when test="$docx.publication = 'standard_fx_vol_varr_corr_swap_supp'">	
						<xsl:choose>	
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">	
								<xsl:apply-templates select="." mode="ol_standard_vol_varr_corr_swap_supp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start-left"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:when>	
							<xsl:otherwise>	
								<xsl:apply-templates select="." mode="ol_standard_vol_varr_corr_swap_supp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:otherwise>	
						</xsl:choose>	
					</xsl:when>
					<xsl:when test="$docx.publication = 'standard_fx_non_deliv_x_ccy_supp'">	
						<xsl:choose>	
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">	
								<xsl:apply-templates select="." mode="ol_standard_fx_non_deliv_x_ccy_supp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start-left"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:when>	
							<xsl:otherwise>	
								<xsl:apply-templates select="." mode="ol_standard_fx_non_deliv_x_ccy_supp">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:otherwise>	
						</xsl:choose>	
					</xsl:when>
					<xsl:when test="$docx.publication = 'inflation_2008_v1'">	
						<xsl:choose>	
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">	
								<xsl:apply-templates select="." mode="ol_inflation_2008">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start-left"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:when>	
							<xsl:otherwise>	
								<xsl:apply-templates select="." mode="ol_inflation_2008">	
									<xsl:with-param name="number" select="$number"/>	
									<xsl:with-param name="indent-start" select="$indent-start"/>	
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>	
							</xsl:otherwise>	
						</xsl:choose>	
					</xsl:when>
					<xsl:when test="contains($docx.publication, 'fx_1998FxDef_AnnexA')">
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol_fx_annexa">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol_fx_annexa">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="contains($docx.publication, 'securities_2022-sft-defs')">
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol_securities_2022_sft_defs">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol_securities_2022_sft_defs">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="contains($docx.publication, 'securities_2022-sft-prov')">
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol_securities_2022_sft_prov">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol_securities_2022_sft_prov">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="contains($docx.publication, 'fx_barrierEventSupplement_v1')">
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol_fx_barrierEventSupplement_v1">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol_fx_barrierEventSupplement_v1">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="exists(ancestor-or-self::*[contains(@outputclass, 'left_indent')])">
								<xsl:apply-templates select="." mode="ol">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start-left"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates select="." mode="ol">
									<xsl:with-param name="number" select="$number"/>
									<xsl:with-param name="indent-start" select="$indent-start"/>
									<xsl:with-param name="depth" select="$depth"/>
									<xsl:with-param name="startFrom1" select="$startFrom1"/>
									<xsl:with-param name="startFrom2" select="$startFrom2"/>
									<xsl:with-param name="startFrom3" select="$startFrom3"/>
									<xsl:with-param name="startFrom4" select="$startFrom4"/>
									<xsl:with-param name="startFrom5" select="$startFrom5"/>
									<xsl:with-param name="startFrom6" select="$startFrom6"/>
									<xsl:with-param name="startFrom7" select="$startFrom7"/>
									<xsl:with-param name="startFrom8" select="$startFrom8"/>
									<xsl:with-param name="startFrom9" select="$startFrom9"/>
								</xsl:apply-templates>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- End of Tradeheader Update -->


	<xsl:template match="@* | node()" mode="ol">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="%1"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:b w:val="true"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="%4."/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base) - 141}" w:hanging="424"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->
	
	<xsl:template match="@* | node()" mode="ol_2021MainBook">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base) - 141}" w:hanging="424"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_standard_fx_bechmarksSupp">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_standard_fx_1998FxDef">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_standard_vol_varr_corr_swap_supp">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_standard_fx_non_deliv_x_ccy_supp">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_inflation_2008">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_fx_annexa">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base) - 141}" w:hanging="424"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_securities_2022_sft_defs">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base) - 141}" w:hanging="424"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_securities_2022_sft_prov">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base) - 141}" w:hanging="424"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	
	<xsl:template match="@* | node()" mode="ol_fx_barrierEventSupplement_v1">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		<!-- Ordered list -->
		<!-- Tradeheader Update -->
		<!-- Document : validation 2021 -->
		<!-- Target: Align docx documents numeration with the reference numeration -->
		<!-- Date : 2021/05/03 -->
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$docx.config/body/docx.listNum.indent-start + $depth * xs:integer($docx.config/body/docx.listNum.increment-base)}" w:hanging="{$docx.config/body/docx.listNum.hanging}"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$docx.config/body/docx.listNum.indent-start + $depth * xs:integer($docx.config/body/docx.listNum.increment-base)}" w:hanging="{$docx.config/body/docx.listNum.hanging}"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$docx.config/body/docx.listNum.indent-start + $depth * xs:integer($docx.config/body/docx.listNum.increment-base)}" w:hanging="{$docx.config/body/docx.listNum.hanging}"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="%4."/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$docx.config/body/docx.listNum.indent-start + $depth * xs:integer($docx.config/body/docx.listNum.increment-base)}" w:hanging="{$docx.config/body/docx.listNum.hanging}"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>

	<xsl:template match="@* | node()" mode="ol_listType_i_parenthesis_a_parenthesis">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>

	<xsl:template match="@* | node()" mode="ol_listType_ia1_parenthesis">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>
		
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : validation -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/03/12 -->
	<xsl:template match="@* | node()" mode="ol_listType_i_parenthesis">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="{$startFrom5}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%5)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="{$startFrom6}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%6)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="{$startFrom7}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%7)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="{$startFrom8}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%8)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="{$startFrom9}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%9)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->

	<!-- Tradeheader Update -->
	<!-- Document : validation -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/03/12 -->
	<xsl:template match="@* | node()" mode="ol_listType_A">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="upperLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->
	
	<xsl:template match="@* | node()" mode="ol_listType_a_parenthesis">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>

	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/05/03 -->
	<xsl:template match="@* | node()" mode="ol_listType_iaI1">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="{$startFrom4}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%4)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->

	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/05/03 -->
	<xsl:template match="@* | node()" mode="ol_listType_ia1">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="lowerRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="1">
				<w:start w:val="{$startFrom2}"/>
				<w:numFmt w:val="lowerLetter"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%2)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="{$startFrom3}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%3)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->

	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/05/03 -->
	<xsl:template match="@* | node()" mode="ol_listType_1_parenthesis">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->

	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/05/03 -->
	<xsl:template match="@* | node()" mode="ol_listType_1">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="decimal"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="%1."/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->
	
	<!-- Tradeheader Update -->
	<!-- Document : validation 2021 -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/05/18 -->
	<xsl:template match="@* | node()" mode="ol_listType_I">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:param name="depth"/>
		<xsl:param name="startFrom1"/>
		<xsl:param name="startFrom2"/>
		<xsl:param name="startFrom3"/>
		<xsl:param name="startFrom4"/>
		<xsl:param name="startFrom5"/>
		<xsl:param name="startFrom6"/>
		<xsl:param name="startFrom7"/>
		<xsl:param name="startFrom8"/>
		<xsl:param name="startFrom9"/>

		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="{$startFrom1}"/>
				<w:numFmt w:val="upperRoman"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="(%1)"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + $depth * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->

	<xsl:template name="ul">
		<xsl:param name="number" as="xs:string"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<xsl:apply-templates select="." mode="ul">
			<xsl:with-param name="number" select="$number"/>
			<xsl:with-param name="indent-start" select="$indent-start"/>
		</xsl:apply-templates>
	</xsl:template>


	<!-- Tradeheader Update -->
	<!-- Document : validation -->
	<!-- Target: Align docx documents numeration with the reference numeration -->
	<!-- Date : 2021/03/12 -->
	<xsl:template match="@* | node()" mode="ul">
		<xsl:param name="number"/>
		<xsl:param name="indent-start" as="xs:integer"/>
		<w:abstractNum w:abstractNumId="{$number}">
			<w:multiLevelType w:val="hybridMultilevel"/>
			<w:lvl w:ilvl="0">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 1 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="1" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="o"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 2 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New"
            w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="2" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 3 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="3" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 4 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="4" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="o"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 5 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New"
            w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="5" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 6 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="6" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 7 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Symbol" w:hAnsi="Symbol" w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="7" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val="o"/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 8 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Courier New" w:hAnsi="Courier New" w:cs="Courier New"
            w:hint="default"/>
				</w:rPr>
			</w:lvl>
			<w:lvl w:ilvl="8" w:tentative="1">
				<w:start w:val="1"/>
				<w:numFmt w:val="bullet"/>
				<xsl:apply-templates select="parent::*" mode="block-style"/>
				<w:lvlText w:val=""/>
				<w:lvlJc w:val="left"/>
				<w:pPr>
					<w:ind w:left="{$indent-start + 9 * xs:integer($increment-base)}" w:hanging="565"/>
				</w:pPr>
				<w:rPr>
					<w:rFonts w:ascii="Wingdings" w:hAnsi="Wingdings" w:hint="default"/>
				</w:rPr>
			</w:lvl>
		</w:abstractNum>
	</xsl:template>
	<!-- End of Tradeheader Update -->
</xsl:stylesheet>
