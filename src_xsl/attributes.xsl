<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml">

	<!-- FALLBACK -->
	<xsl:template match="xs:attribute">
		<div class="error">
			<xsl:text>Attributes of type "</xsl:text>
			<code>
				<xsl:value-of select="@type"/>
			</code>
			<xsl:text>" are not yet supported</xsl:text>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:string']">
		<div>
			<xsl:call-template name="label"/>
			<input type="text" name="{@name}">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:integer']">
		<div>
			<xsl:call-template name="label"/>
			<input type="number" name="{@name}">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[xs:simpleType]">
		<div>
			<xsl:call-template name="label"/>
			<xsl:apply-templates select="xs:simpleType"/>
			<xsl:call-template name="hint"/>
		</div>

	</xsl:template>

</xsl:stylesheet>
