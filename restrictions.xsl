<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="h">
	<xsl:template match="xs:restriction">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:pattern">
		<xsl:attribute name="pattern">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:minInclusive">
		<xsl:attribute name="min">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:maxInclusive">
		<xsl:attribute name="max">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:minExclusive">
		<!-- TODO: Manage floats -->
		<xsl:attribute name="min">
			<xsl:value-of select="@value + 1"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:maxExclusive">
		<!-- TODO: Manage floats -->
		<xsl:attribute name="max">
			<xsl:value-of select="@value - 1"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction[xs:enumeration]">
		<select>
			<xsl:apply-templates select="xs:enumeration"/>
		</select>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:enumeration">
		<option>
			<xsl:attribute name="value">
				<xsl:value-of select="@value"/>
			</xsl:attribute>
			<xsl:value-of select="(xs:annotation/xs:documentation[1]|@value)[last()]"/>
		</option>
	</xsl:template>

</xsl:stylesheet>
