<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml">

	<!-- FALLBACK -->
	<xsl:template match="xs:attribute" mode="input">
		<xsl:comment>
			<xsl:text>match="xs:attribute" mode="input"</xsl:text>
		</xsl:comment>
		<div class="error">
			<xsl:text>Attributes of type "</xsl:text>
			<code>
				<xsl:value-of select="@type" />
			</code>
			<xsl:text>" are not yet supported</xsl:text>
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute">
		<xsl:comment>
			<xsl:text>match="xs:attribute"</xsl:text>
		</xsl:comment>
		<div class="attribute {@name}">
			<xsl:call-template name="label" />
			<xsl:apply-templates select="." mode="input" />
			<xsl:call-template name="hint" />
		</div>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='string']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='string']]" mode="input">
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='string']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="text" name="{@name}" size="1" style="min-width:8ch">
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='integer']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='integer']]" mode="input">
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='integer']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='integer']]" mode="input" priority="1"</xsl:text>
		</xsl:comment>
		<input type="number" name="{@name}" size="1" style="min-width:7ch; max-width:12ch;">
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='decimal']" mode="input">
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='decimal']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="number" name="{@name}">
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='boolean']" mode="input">
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='boolean']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="checkbox" name="{@name}">
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[xs:simpleType]" mode="input" priority="-1">
		<xsl:comment>
			<xsl:text>match="xs:attribute[xs:simpleType]" mode="input"</xsl:text>
		</xsl:comment>
		<xsl:apply-templates select="xs:simpleType" />
	</xsl:template>
</xsl:stylesheet>