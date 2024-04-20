<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml">

	<!-- FALLBACK -->
	<xsl:template match="*" mode="attributes" priority="-1">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="*" mode="attributes"</xsl:text>
			<xsl:value-of select="concat('{',name(),'}')"/>
		</xsl:comment>
		<div class="attributes">
			<xsl:value-of select="count(xs:attributes)" />
			<xsl:apply-templates select="xs:attribute">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:apply-templates>
		</div>
	</xsl:template>
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
		<xsl:param name="xpath" />
		<xsl:variable name="current-xpath" select="concat($xpath, '/@', @name)" />
		<xsl:comment>
			<xsl:text>match="xs:attribute"</xsl:text>
		</xsl:comment>
		<fieldset class="attribute {@name}" data-xpath="{$current-xpath}">
			<xsl:if test="not(@use or @use='optional')">
				<xsl:attribute name="disabled"></xsl:attribute>
			</xsl:if>
			<xsl:call-template name="label">
				<xsl:with-param name="xpath" select="$current-xpath" />
			</xsl:call-template>
			<xsl:apply-templates select="." mode="input">
				<xsl:with-param name="xpath" select="$current-xpath" />
			</xsl:apply-templates>
			<xsl:choose>
				<xsl:when test="not(@use or @use='optional')">
					<button type="button" class="icon" onclick="Form.hide.apply(this, arguments)">delete</button>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="hint" />
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='string']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='string']]" mode="input">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='string']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="text" size="1" style="min-width:8ch">
			<xsl:call-template name="name-id">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:call-template>
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='integer']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='integer']]" mode="input">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='integer']|xs:attribute[xs:simpleType/xs:restriction[substring-after(@base, ':')='integer']]" mode="input" priority="1"</xsl:text>
		</xsl:comment>
		<input type="number" size="1" style="min-width:7ch; max-width:12ch;">
			<xsl:call-template name="name-id">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:call-template>
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='decimal']" mode="input">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='decimal']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="number">
			<xsl:call-template name="name-id">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:call-template>
			<xsl:apply-templates select="xs:restriction" />
		</input>
	</xsl:template>
	<xsl:template match="xs:attribute[substring-after(@type, ':')='boolean']" mode="input">
		<xsl:param name="xpath" />	
		<xsl:comment>
			<xsl:text>match="xs:attribute[substring-after(@type, ':')='boolean']" mode="input"</xsl:text>
		</xsl:comment>
		<input type="checkbox" name="{@name}">
			<xsl:call-template name="name-id">
				<xsl:with-param name="xpath" select="$xpath" />
			</xsl:call-template>
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