<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml">

	<!-- FALLBACK -->
	<xsl:template match="xs:attribute">
		<xsl:comment>
			<xsl:text>match=xs:element[@type='xs:string']</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div class="error">
			<xsl:text>Attributes of type "</xsl:text>
			<code>
				<xsl:value-of select="@type"/>
			</code>
			<xsl:text>" are not yet supported</xsl:text>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:string']">
		<xsl:comment>
			<xsl:text>match=xs:element[@type='xs:string']</xsl:text>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label"/>
			<input type="text" name="{@name}" size="1" style="min-width:8ch">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:integer']">
		<xsl:comment>
			<xsl:text>match=xs:element[@type='xs:integer']</xsl:text>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label"/>
			<input type="number" name="{@name}" size="1" style="min-width:7ch; max-width:12ch;">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:decimal']">
		<xsl:comment>
			<xsl:text>match=xs:element[@type='xs:decimal']</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label"/>
			<input type="number" name="{@name}">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[@type='xs:boolean']">
		<xsl:comment>
			<xsl:text>match=xs:element[@type='xs:boolean']</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label"/>
			<input type="checkbox" name="{@name}">
				<xsl:apply-templates select="xs:restriction"/>
			</input>
			<xsl:call-template name="hint"/>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[xs:simpleType]">
		<xsl:comment>
			<xsl:text>match=xs:attribute[xs:simpleType]</xsl:text>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label"/>
			<xsl:apply-templates select="xs:simpleType"/>
			<xsl:call-template name="hint"/>
		</div>

	</xsl:template>
</xsl:stylesheet>
