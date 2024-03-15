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
		<xsl:comment>
			<xsl:text>match="xs:restriction[xs:enumeration]"</xsl:text>
		</xsl:comment>
		<select name="{(ancestor::*/@name)[last()]}" id="{(ancestor::*/@name)[last()]}">
			<xsl:apply-templates select="xs:enumeration"/>
		</select>
	</xsl:template>
	<xsl:template match="xs:simpleType[xs:annotation/xs:appinfo[@appearance='radio']]/xs:restriction[xs:enumeration]">
		<xsl:comment>
			<xsl:text>match="*[xs:annotation/xs:appinfo[@appearance='radio']]/xs:restriction[xs:enumeration]"</xsl:text>
		</xsl:comment>
		<xsl:apply-templates select="." mode="buttons"/>
	</xsl:template>
	<xsl:template match="xs:enumeration">
		<xsl:comment>
			<xsl:text>match="xs:enumeration"</xsl:text>
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
		</option>
	</xsl:template>
	<xsl:template match="xs:restriction[xs:enumeration]" mode="buttons">
		<xsl:comment>
			<xsl:text>match="xs:restriction[xs:enumeration]" mode="buttons"</xsl:text>
		</xsl:comment>
		<fieldset class="buttons">
			<xsl:apply-templates select="xs:enumeration" mode="buttons"/>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:enumeration" mode="buttons">
		<xsl:comment>
			<xsl:text>match="xs:restriction/xs:enumeration" mode="buttons</xsl:text>
		</xsl:comment>
		<xsl:variable name="value">
			<xsl:call-template name="documentation">
				<xsl:with-param name="attribute" select="'value'"/>
				<xsl:with-param name="default" select="'@value'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="id">
			<xsl:value-of select="generate-id()"/>
		</xsl:variable>
		<span>
			<input type="radio" id="{$id}" value="{$value}" name="{(ancestor::*/@name)[last()]}">
			</input>
			<label for="{$id}">
				<xsl:call-template name="documentation">
					<xsl:with-param name="attribute" select="'label'"/>
					<xsl:with-param name="default" select="''"/>
				</xsl:call-template>
			</label>
		</span>
	</xsl:template>
</xsl:stylesheet>
