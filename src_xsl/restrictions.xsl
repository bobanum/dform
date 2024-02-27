<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="h">
	<xsl:template match="xs:restriction">
		<xsl:comment>
			<xsl:text>match=xs:restriction</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates select="*"/>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:pattern">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:pattern</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>		
		<xsl:attribute name="pattern">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:minInclusive">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:minInclusive</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:attribute name="min">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:maxInclusive">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:maxInclusive</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>	
		<xsl:attribute name="max">
			<xsl:value-of select="@value"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:minExclusive">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:minExclusive</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<!-- TODO: Manage floats -->
		<xsl:attribute name="min">
			<xsl:value-of select="@value + 1"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:maxExclusive">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:maxExclusive</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<!-- TODO: Manage floats -->
		<xsl:attribute name="max">
			<xsl:value-of select="@value - 1"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="xs:restriction[xs:enumeration]">
		<xsl:comment>
			<xsl:text>match=xs:restriction[xs:enumeration]</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<select>
			<xsl:apply-templates select="xs:enumeration"/>
		</select>
	</xsl:template>
	<xsl:template match="xs:restriction/xs:enumeration">
		<xsl:comment>
			<xsl:text>match=xs:restriction/xs:enumeration</xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:variable name="value">
			<xsl:call-template name="documentation">
				<xsl:with-param name="attribute" select="'value'"/>
				<xsl:with-param name="default" select="'@value'"/>
			</xsl:call-template>
		</xsl:variable>
		<option>
			<xsl:attribute name="value">
				<xsl:value-of select="$value"/>
			</xsl:attribute>
			<xsl:call-template name="documentation">
				<xsl:with-param name="attribute" select="'label'"/>
				<xsl:with-param name="default" select="''"/>
			</xsl:call-template>
			<!-- <xsl:value-of select="(xs:annotation/xs:documentation[1]|@value)[last()]"/> -->
		</option>
	</xsl:template>
</xsl:stylesheet>
