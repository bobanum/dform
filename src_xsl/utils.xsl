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
		<xsl:param name="xpath" />
		<xsl:param name="attribute" select="'label'" />
		<xsl:param name="ref" select="current()" />
		<xsl:comment>
			<xsl:text>name="label"</xsl:text>
			<xsl:value-of select="concat(' - {',name($ref),'}')"/>
		</xsl:comment>
		<label>
			<xsl:attribute name="for">
				<xsl:value-of select="$xpath" />
			</xsl:attribute>
			<xsl:call-template name="documentation">
				<xsl:with-param name="attribute" select="$attribute" />
				<xsl:with-param name="default" select="@name" />
				<xsl:with-param name="ref" select="$ref" />
			</xsl:call-template>
		</label>
	</xsl:template>
	<xsl:template name="name-id">
		<xsl:param name="xpath" />
		<xsl:attribute name="name">
			<xsl:value-of select="$xpath" />
		</xsl:attribute>
		<xsl:attribute name="id">
			<xsl:value-of select="$xpath" />
		</xsl:attribute>
	</xsl:template>
	<xsl:template name="hint">
		<xsl:comment>
			<xsl:text>name="hint"</xsl:text>
			<xsl:value-of select="concat(' - {',name(),'}')"/>
		</xsl:comment>
		<div class="hint" tabindex="0">
			<p>
				<xsl:call-template name="documentation">
					<xsl:with-param name="attribute" select="'hint'" />
				</xsl:call-template>
			</p>
		</div>
	</xsl:template>
	<xsl:template name="documentation">
		<xsl:param name="ref" select="current()" />
		<xsl:param name="attribute" select="'label|hint'" />
		<xsl:param name="default" select="$ref/@name" />
		<xsl:comment>
			<xsl:text>name="documentation"</xsl:text>
			<xsl:value-of select="concat(' - {',name(),'/',name($ref),'}')"/>
		</xsl:comment>
		<xsl:choose>
			<xsl:when test="not($ref/xs:annotation/xs:documentation) and //xs:complexType[@name=$ref/@type]">
				<xsl:call-template name="documentation">
					<xsl:with-param name="ref" select="//xs:complexType[@name=$ref/@type]" />
					<xsl:with-param name="attribute" select="$attribute" />
					<xsl:with-param name="default" select="$default" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="/xs:schema/@xml:lang and $ref/xs:annotation/xs:documentation[@xml:lang=//xs:schema/@xml:lang]">
				<!-- Language found. Take the good one -->
				<xsl:call-template name="documentation-value">
					<xsl:with-param name="attribute" select="$attribute" />
					<xsl:with-param name="default" select="$default" />
					<xsl:with-param name="documentation" select="$ref/xs:annotation/xs:documentation[@xml:lang=/xs:schema/@xml:lang]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$ref/xs:annotation/xs:documentation[not(@xml:lang)]">
				<!-- Take no lang if exists -->
				<xsl:call-template name="documentation-value">
					<xsl:with-param name="attribute" select="$attribute" />
					<xsl:with-param name="default" select="$default" />
					<xsl:with-param name="documentation" select="$ref/xs:annotation/xs:documentation[not(@xml:lang)]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$ref/xs:annotation/xs:documentation[@xml:lang='en']">
				<!-- Language undefined. Take 'en' if exists.  -->
				<xsl:call-template name="documentation-value">
					<xsl:with-param name="attribute" select="$attribute" />
					<xsl:with-param name="default" select="$default" />
					<xsl:with-param name="documentation" select="$ref/xs:annotation/xs:documentation[@xml:lang='en']" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$ref/xs:annotation/xs:documentation">
				<!-- Take the first one if exists -->
				<xsl:call-template name="documentation-value">
					<xsl:with-param name="attribute" select="$attribute" />
					<xsl:with-param name="default" select="$default" />
					<xsl:with-param name="documentation" select="$ref/xs:annotation/xs:documentation" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="documentation-value">
		<xsl:param name="attribute" />
		<xsl:param name="default" select="@name" />
		<xsl:param name="documentation" select="/*[false()]" />
		<xsl:comment>
			<xsl:text>name="documentation-value"</xsl:text>
		</xsl:comment>
		<xsl:variable name="value" select="$documentation/@*[contains(concat('|', $attribute, '|'), concat('|', local-name(), '|'))]" />
		<xsl:choose>
			<xsl:when test="$value">
				<xsl:value-of select="$value" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$default" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minmax">
		<xsl:param name="xpath" />
		<xsl:param name="ref" select="current()" />
		<xsl:comment>
			<xsl:text>name="minmax"</xsl:text>
			<xsl:value-of select="concat(' - {',name(),'}{',$xpath,'}')"/>
		</xsl:comment>
		<xsl:variable name="min" select="number(concat('0',@minOccurs))+not(@minOccurs)*1" />
		<xsl:variable name="max">
			<xsl:choose>
				<xsl:when test="@maxOccurs='unbounded'">
					<xsl:value-of select="-1" />
				</xsl:when>
				<xsl:when test="not(@maxOccurs)">
					<xsl:value-of select="($min>1)*$min + (1>=$min)*1" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($min>@maxOccurs)*$min + (@maxOccurs>=$min)*@maxOccurs" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$min=1 and $max=1">
			<xsl:apply-templates select="$ref">
				<xsl:with-param name="name" select="@name" />
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:apply-templates>
		</xsl:if>
		<xsl:if test="not($min=1 and $max=1)">
			<fieldset class="group {local-name()}" data-template="{generate-id(.)}" data-xpath="{$xpath}/{@name}" data-min="{$min}" data-max="{$max}">
				<xsl:if test="$min=0">
					<xsl:attribute name="disabled" />
				</xsl:if>
				<legend>
					<xsl:call-template name="label" />
				</legend>
				<div class="fieldset">
					<xsl:if test="$min>0">
						<xsl:call-template name="loop">
							<xsl:with-param name="xpath" select="concat($xpath,'/',$ref/@name)" />
							<xsl:with-param name="end" select="$min" />
						</xsl:call-template>
					</xsl:if>
					<!-- <xsl:if test="$max=-1 or ($min=0 and $max!=0) or $max>$min">
						<div class="template">
							<button class="delete" type="button">❌︎</button>
							<xsl:apply-templates select="current()"/>
						</div>
					</xsl:if> -->
					<!-- <button class="add" type="button" data-template="{generate-id(.)}" onclick="Form.addElement.apply(this, arguments)">
						<xsl:value-of select="@name" />
					</button> -->
				</div>
			</fieldset>
		</xsl:if>
	</xsl:template>
	<xsl:template match="*" mode="minmax">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="*" mode="minmax"</xsl:text>
			<xsl:value-of select="concat('{',name(),'}{',$xpath,'}')"/>
		</xsl:comment>
		<xsl:call-template name="minmax">
			<xsl:with-param name="xpath" select="$xpath" />
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="loop">
		<xsl:param name="xpath" />
		<xsl:param name="start" select="1" />
		<xsl:param name="end" />
		<xsl:param name="step" select="1" />
		<xsl:param name="ref" select="current()" />
		<xsl:comment>
			<xsl:text>name="loop"</xsl:text>
			<xsl:value-of select="concat(' - {',name($ref),'}{',$xpath,'}')"/>
		</xsl:comment>
		<xsl:if test="$start &lt;= $end">
			<xsl:apply-templates select="$ref">
				<xsl:with-param name="name" select="$ref/@name" />
				<xsl:with-param name="xpath" select="concat($xpath, '[', $start, ']')" />
			</xsl:apply-templates>
			<xsl:call-template name="loop">
				<xsl:with-param name="xpath" select="$xpath" />
				<xsl:with-param name="start" select="$start + $step" />
				<xsl:with-param name="end" select="$end" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="prefix">
		<xsl:param name="prefix" select="''" />
		<xsl:param name="separator" select="'.'" />
		<xsl:comment>
			<xsl:text>name="prefix"</xsl:text>
			<xsl:value-of select="concat(' - {',name(),'}')"/>
		</xsl:comment>

		<xsl:for-each select="(ancestor::xs:element[@name]|ancestor::xs:complexType[@name])[1]">
			<xsl:call-template name="prefix">
				<xsl:with-param name="separator" select="$separator" />
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="self::xs:complexType">
					<xsl:variable name="type" select="@name" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@name" />
				</xsl:otherwise>
			</xsl:choose>
			<xsl:variable name="type" select="ancestor::xs:complexType[@name][1]/@name" />
			<xsl:value-of select="//xs:element[@type=$type]/@name" />
			<xsl:value-of select="$separator" />
		</xsl:for-each>
		<!-- <xsl:if test="//xs:element[@type=ancestor::xs:complexType/@name]">
			<xsl:value-of select="count(ancestor::*[@name])" />
			<xsl:value-of select="ancestor::*[@name]/@name" />
		</xsl:if> -->
		<!-- <xsl:value-of select="@name" /> -->
	</xsl:template>
	<!-- Levels of visibility for "basic", "advanced", "expert" modes. may be implemented fully (much) later -->
	<!-- <xsl:template name="level">
		<xsl:apply-templates select="xs:annotation/xs:appinfo/@df:level"/>
		<xsl:comment>
			<xsl:text>name="level"</xsl:text>
			<xsl:value-of select="concat('{',name(),'}')"/>
		</xsl:comment>
	</xsl:template>
	<xsl:template match="@df:level">
		<xsl:attribute name="data-level">
			<xsl:value-of select="."/>
		</xsl:attribute>
		<xsl:comment>
			<xsl:text>match="@df:level"</xsl:text>
			<xsl:value-of select="concat('{',name(),'}')"/>
		</xsl:comment>
	</xsl:template> -->

</xsl:stylesheet>