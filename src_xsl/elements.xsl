<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:h="http://www.w3.org/1999/xhtml">
	<!-- FALLBACK -->
	<xsl:template match="xs:element[@type]">
		<div class="error">
			<xsl:text>Elements of type "</xsl:text>
			<code>
				<xsl:value-of select="@type"/>
			</code>
			<xsl:text>" are not yet supported</xsl:text>
		</div>
	</xsl:template>

	<xsl:template match="xs:element[@type][//xs:complexType[@name = current()/@type]]">
		<xsl:value-of select="@type"/>
		<xsl:apply-templates select="//xs:complexType[@name = current()/@type]"/>
	</xsl:template>
	<xsl:template match="xs:element[@type='xs:string']">
		<div>
			<xsl:call-template name="label"/>
			<input type="text" name="{@name}" placeholder="{@name}">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:element[@type='df:html']">
		<div>
			<xsl:call-template name="label"/>
			<textarea rows="5" cols="30"></textarea>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<!-- <xsl:template match="xs:element[@minOccurs]">
		<div class="template">
			<xsl:apply-templates select="."/>
		</div>
		<div>Ajouter</div>
	</xsl:template> -->
</xsl:stylesheet>
