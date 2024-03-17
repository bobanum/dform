class Form {
	static addElement(e) {
		var template = document.getElementById(e.currentTarget.dataset.template);
		var clone = template.firstElementChild.cloneNode(true);
		clone.appendChild(Form.dom_deleteBtn());
		e.currentTarget.parentNode.insertBefore(clone, e.currentTarget);
	}
	static dom_deleteBtn() {
		var result = document.createElement("button");
		result.textContent = "❌︎";
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
}
export { Form as default, Form};