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
				<xsl:with-param name="attribute" select="'label'"/>
			</xsl:call-template>
			<xsl:text>:</xsl:text>
		</label>
	</xsl:template>
	<xsl:template name="hint">
		<div class="hint" tabindex="0">
			<p>
				<xsl:call-template name="documentation"/>
			</p>
		</div>
	</xsl:template>
	<xsl:template name="documentation">
		<xsl:param name="attribute"/>
		<xsl:value-of select="(xs:annotation/xs:documentation[@xml:lang=//xs:schema/@xml:lang]/@*[name() = $attribute]|xs:annotation/xs:documentation[@xml:lang=//xs:schema/@xml:lang])[last()]"/>
	</xsl:template>
	
</xsl:stylesheet>
