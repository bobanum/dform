class Xsl {
	constructor(xslFile) {
		this.xslFile = xslFile;
		this.serializer = new XMLSerializer();
	}

	async transform(xml) {
		const docs = await Promise.all([this.loadDoc(xml), this.loadDoc(this.xslFile)]);
		const processor = new XSLTProcessor();
		processor.importStylesheet(docs[1]);
		docs[0].activeElement.setAttribute('xml:lang', 'de');
		console.log(docs[0].activeElement);
		const result = processor.transformToFragment(docs[0], document);
		return result;
		// return this.serializer.serializeToString(result);
	}
	async loadDoc(url) {
		const response = await fetch(url);
		const xml = await response.text();
		var parser = new DOMParser();
		var result = parser.parseFromString(xml, "text/xml");
		return result;
	}
}

export { Xsl as default, Xsl };