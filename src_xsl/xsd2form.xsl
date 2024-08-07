<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:df="https://bobanum.github.io/dform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:import href="src_xsl/utils.xsl" />
	<xsl:import href="src_xsl/attributes.xsl" />
	<xsl:import href="src_xsl/elements.xsl" />
	<xsl:import href="src_xsl/restrictions.xsl" />
	<xsl:import href="src_xsl/complexType.xsl" />
	<xsl:import href="src_xsl/outline.xsl" />
	<xsl:output method="html" indent="yes" />
	<xsl:variable name="lang" select="'fr'" />
	<xsl:template match="xs:schema">
		<xsl:comment>
			<xsl:text>match="xs:schema" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:call-template name="templates" />
		<form onsubmit="return Form.submit.apply(this, arguments)" action="" method="post" class="xsd2form">
			<button class="submit">Submit</button>
			<xsl:apply-templates select="xs:element">
				<xsl:with-param name="xpath" select="@name" />
			</xsl:apply-templates>
			<xsl:call-template name="outline" />
			<button class="submit">Submit</button>
		</form>
	</xsl:template>
	<xsl:template name="templates">
		<xsl:comment>
			<xsl:text>name="templates"</xsl:text>
		</xsl:comment>
		<div id="templates">
			<xsl:for-each select="//node()[not((not(@minOccurs) or @minOccurs='1') and (not(@maxOccurs) or @maxOccurs&lt;='1'))]">
				<div id="{generate-id(.)}">
					<xsl:apply-templates select="." />
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template match="xs:simpleContent">
		<xsl:comment>
			<xsl:text>match="xs:simpleContent" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="xs:extension[@base='xs:string']">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:extension[@base='xs:string']" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<fieldset>
			<div class="fieldset">
				<xsl:call-template name="label">
					<xsl:with-param name="xpath" select="$xpath" />
					<xsl:with-param name="ref" select=".." />
				 </xsl:call-template>
				 <input type="text" placeholder="{@name}">
					<xsl:call-template name="name-id">
						<xsl:with-param name="xpath" select="$xpath" />
					</xsl:call-template>
					<!-- <xsl:apply-templates select="xs:restriction" /> -->
				</input>
			</div>
		</fieldset>
	</xsl:template>
	<xsl:template match="xs:element[(not(@minOccurs) or @minOccurs=1) and (not(@maxOccurs) or @maxOccurs=1)]" mode="minmax">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="*[(not(@minOccurs) or @minOccurs=1) and (not(@maxOccurs) or @maxOccurs=1)]" mode="minmax" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates select=".">
			<xsl:with-param name="xpath" select="concat($xpath, '/', @name)" />
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xs:sequence|xs:choice|xs:all|xs:group">
		<xsl:param name="xpath" />
		<xsl:comment>
			<xsl:text>match="xs:sequence|xs:choice|xs:all|xs:group" - </xsl:text>
			<xsl:value-of select="name()"/>
		</xsl:comment>
		<xsl:apply-templates mode="minmax">
			<xsl:with-param name="xpath" select="$xpath" />
		</xsl:apply-templates>
	</xsl:template>
</xsl:stylesheet>