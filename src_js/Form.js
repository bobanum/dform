class Form {
	static addElement(e) {
		console.log(e.currentTarget.lastElementChild);
		var template = e.currentTarget.closest(".template");
		var clone = template.lastElementChild.cloneNode(true);
		var deleteBtn = clone.appendChild(template.querySelector(".delete").cloneNode(true));
		deleteBtn.addEventListener("click", e => {
			e.target.parentNode.remove();
		});
		template.parentNode.insertBefore(clone, template);
	}
}
export { Form as default, Form};