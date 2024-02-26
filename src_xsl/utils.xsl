<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml">
	<!--
     _  _   _   __  __ ___ ___    _____ ___ __  __ ___ _      _ _____ ___ ___ 
    | \| | /_\ |  \/  | __|   \  |_   _| __|  \/  | _ \ |    /_\_   _| __/ __|
    | .` |/ _ \| |\/| | _|| |) |   | | | _|| |\/| |  _/ |__ / _ \| | | _|\__ \
    |_|\_/_/ \_\_|  |_|___|___/    |_| |___|_|  |_|_| |____/_/ \_\_| |___|___/                                                                               
    -->
	<xsl:template name="label">
		<label for="{@name}">
			<xsl:call-template name="documentation">
				<xsl:with-param name="attribute" select="'label|hint'"/>
				<xsl:with-param name="default" select="@name"/>
			</xsl:call-template>
			<xsl:text>:</xsl:text>
		</label>
	</xsl:template>
	<xsl:template name="hint">
		<div class="hint" tabindex="0">
			<p>
				<xsl:call-template name="documentation">
					<xsl:with-param name="attribute" select="'hint'"/>
				</xsl:call-template>
			</p>
		</div>
	</xsl:template>
	<xsl:template name="documentation">
		<xsl:param name="attribute"/>
		<xsl:param name="default"/>
		<xsl:variable name="documentation" select="xs:annotation/xs:documentation[@xml:lang=//xs:schema/@xml:lang]"/>
		<xsl:variable name="value" select="$documentation/@*[contains(concat('|', $attribute, '|'), concat('|', name(), '|'))]"/>
		<xsl:choose>
			<xsl:when test="$value">
				<xsl:value-of select="$value"/>
			</xsl:when>
			<xsl:when test="$documentation">
				<xsl:value-of select="$documentation"/>
			</xsl:when>
			<xsl:when test="$default">
				<xsl:value-of select="$default"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minmax">
		<xsl:variable name="min" select="number(concat('0',@minOccurs))+not(@minOccurs)*1"/>
		<xsl:variable name="max">
			<xsl:choose>
				<xsl:when test="@maxOccurs='unbounded'">
					<xsl:value-of select="-1"/>
				</xsl:when>
				<xsl:when test="not(@maxOccurs)">
					<xsl:value-of select="($min>1)*$min + (1>=$min)*1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($min>@maxOccurs)*$min + (@maxOccurs>=$min)*@maxOccurs"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$min=1 and $max=1">
			<xsl:apply-templates select="current()"/>
		</xsl:if>
		<xsl:if test="not($min=1 and $max=1)">
			<div class="group" data-min="{$min}" data-max="{$max}">
				<xsl:if test="$min>0">
					<xsl:call-template name="loop">
						<xsl:with-param name="start" select="1"/>
						<xsl:with-param name="end" select="$min"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$max=-1 or ($min=0 and $max!=0) or $max>$min">
					<div class="template">
						<button class="add" type="button" onclick="Form.addElement.apply(this, arguments)">
							<xsl:value-of select="@name"/>
						</button>
						<button class="delete" type="button">delete</button>
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:if>
			</div>
		</xsl:if>

	</xsl:template>
	<xsl:template name="loop">
		<xsl:param name="start"/>
		<xsl:param name="end"/>
		<xsl:if test="$start &lt;= $end">
			<xsl:apply-templates select="current()"/>
			<xsl:call-template name="loop">
				<xsl:with-param name="start" select="$start + 1"/>
				<xsl:with-param name="end" select="$end"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>