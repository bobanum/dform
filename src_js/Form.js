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
}
export { Form as default, Form};