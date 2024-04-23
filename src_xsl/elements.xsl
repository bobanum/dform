<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0">
	<!-- FALLBACK -->
	<xsl:template match="xs:element[@type]">
		<xsl:comment>
			<xsl:text>match=xs:element[@type]</xsl:text>
		</xsl:comment>

		<div class="error">
			<xsl:text>Elements of type "</xsl:text>
			<code>
				<xsl:value-of select="@type" />
			</code>
			<xsl:text>" are not yet supported</xsl:text>
		</div>
	</xsl:template>
	<xsl:template match="xs:element[xs:complexType]">
		<xsl:comment>
			<xsl:text>match="xs:element[xs:complexType]"</xsl:text>
		</xsl:comment>
		<fieldset class="element">
			<div class="fieldset">
				<xsl:call-template name="label" />
				<!-- <xsl:value-of select="@name"/> -->
				<xsl:apply-templates />
			</div>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:element[@type][//xs:complexType[@name = current()/@type]]">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:element[@type][//xs:complexType[@name = current()/@type]]" - </xsl:text>
			<xsl:value-of select="concat('{',name(),'}{',$xpath,'}')"/>
		</xsl:comment>
		<xsl:apply-templates select="//xs:complexType[@name = current()/@type]">
			<xsl:with-param name="xpath" select="$xpath" />
			<xsl:with-param name="instance" select="." />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:element[substring-after(@type, ':')='string']">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:element[substring-after(@type, ':')='string']"</xsl:text>
		</xsl:comment>
		<fieldset class="element {@name}" data-xpath="{$xpath}">
			<div class="fieldset">
				<xsl:call-template name="label" />
				<input type="text" placeholder="{@name}">
					<xsl:call-template name="name-id">
						<xsl:with-param name="xpath" select="$xpath" />
					</xsl:call-template>
					<xsl:apply-templates select="xs:restriction" />
				</input>
				<xsl:call-template name="hint" />
			</div>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:element[substring-after(@type, ':')='html']">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:element[substring-after(@type, ':')='html']"</xsl:text>
		</xsl:comment>
		<fieldset class="element {@name}">
			<div class="fieldset">
				<xsl:call-template name="label"/>
				<textarea rows="5" cols="30">
					<xsl:call-template name="name-id">
						<xsl:with-param name="xpath" select="$xpath" />
					</xsl:call-template>
				</textarea>
				<xsl:call-template name="hint" />
			</div>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:element" mode="templatezzz">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:element mode=template"</xsl:text>
		</xsl:comment>
		<h1>
			<xsl:value-of select="$xpath" />
		</h1>
		<div class="template">
			<xsl:apply-templates select="current()">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:apply-templates>
		</div>
	</xsl:template>
</xsl:stylesheet>