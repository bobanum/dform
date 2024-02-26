class Xsl {
	constructor(xslFile) {
		this.xslFile = xslFile;
		this.serializer = new XMLSerializer();
	}

	async transform(xml) {
		const docs = await Promise.all([this.loadDoc(xml), this.loadDoc(this.xslFile)]);
		const processor = new XSLTProcessor();
		console.log(docs);
		processor.importStylesheet(docs[1]);
		console.log(processor);
		docs[0].documentElement.setAttribute('xml:lang', 'it');
		console.log(docs[0].documentElement);
		const result = processor.transformToFragment(docs[0], docs[1]);
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