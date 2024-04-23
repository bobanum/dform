class Form {
	
	static addInstance(templateId, target) {
		var template = document.getElementById(templateId);
		var clone = template.firstElementChild.cloneNode(true);
		clone.appendChild(Form.dom_deleteBtn());
		var n = target.querySelectorAll(".element").length + 1;
		var xpath = target.dataset.xpath + "["+n+"]";
		clone.querySelectorAll("[id]").forEach(el => {
			el.id = xpath;
			el.name = xpath;
		});
		target.querySelector('div').appendChild(clone);
	}
	static addElement(e) {
		var template = document.getElementById(e.currentTarget.dataset.template);
		var clone = template.firstElementChild.cloneNode(true);
		clone.appendChild(Form.dom_deleteBtn());
		var n = e.currentTarget.parentNode.querySelectorAll(".element").length + 1;
		var xpath = e.currentTarget.closest("[data-xpath]").dataset.xpath.replace(/\[#\]/g, "["+n+"]");
		clone.querySelectorAll("[id]").forEach(el => {
			el.id = xpath;
			el.name = xpath;
		});
		e.currentTarget.parentNode.insertBefore(clone, e.currentTarget);
	}
	static dom_deleteBtn() {
		var result = document.createElement("button");
		result.classList.add("delete");
		result.addEventListener("click", e => {
			result.parentNode.remove();
		});
		return result;
	}
	static submit(e) {
		e.preventDefault();
		var data = new FormData(e.currentTarget);
		console.log(data);
		var obj = {};
		for (var pair of data.entries()) {
			obj[pair[0]] = pair[1];
		}
		console.log(obj);
		return false;
	}
	static hide(e) {
		const fieldset = e.currentTarget.closest("fieldset");
		fieldset.disabled = true;
		document.querySelector("#outline button[data-xpath='"+fieldset.dataset.xpath+"']").disabled = false;
	}
	static show(e) {
		// debugger;
		const subject = document.querySelector("fieldset[data-xpath='"+e.currentTarget.dataset.xpath+"']");
		subject.disabled = false;
		if (subject.classList.contains("group")) {
			// subject.querySelector("input, textarea, select").focus();
			Form.addInstance(subject.dataset.template, subject);
			if (subject.dataset.max > 0 && subject.children.length >= subject.dataset.max) {
				e.currentTarget.disabled = true;
			}
		} else {
			e.currentTarget.disabled = true;
		}

	}
}
export { Form as default, Form};