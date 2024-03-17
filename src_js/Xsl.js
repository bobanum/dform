class Xsl {
	constructor(xslFile) {
		this.xslFile = xslFile;
		this.serializer = new XMLSerializer();
	}

	async transform(xml) {
		const [xmlDoc, xslDoc] = await Promise.all([this.loadDoc(xml), this.loadDoc(this.xslFile)]);
		const processor = new XSLTProcessor();
		processor.importStylesheet(xslDoc);
		xmlDoc.documentElement.setAttribute('xml:lang', 'en');
		xmlDoc.documentElement.removeAttribute('xml:lang');
		const result = processor.transformToFragment(xmlDoc, document);
		return result;
	}
	async loadDoc(url) {
		const response = await fetch(url);
		const xml = await response.text();
		var parser = new DOMParser();
		var result = parser.parseFromString(xml, "text/xml");
		// console.log(result);
		// var here = new URL(import.meta.url).origin;
		// result.baseURI = here;
		return result;
	}
}

export { Xsl as default, Xsl };