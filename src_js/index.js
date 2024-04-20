import Xsl from './Xsl.js';
import Form from './Form.js';

export function debug(domain) {
	let bulle = document.body.appendChild(document.createElement('div'));
	bulle.classList.add('bulle');
	domain.addEventListener('mouseover', e => {
		e.preventDefault();
		if (e.shiftKey) {
			bulle.textContent = e.target.cloneNode().outerHTML;
			bulle.style.top = `calc(1em + ${e.clientY}px)`;
			bulle.style.right = 0 + 'px';
			e.target.style.outline = '1px solid red';
		}
	});
	domain.addEventListener('mouseout', e => {
		e.preventDefault();
		if (e.shiftKey) {
			bulle.textContent = '';
		}
		e.target.style.removeProperty('outline');
		if (e.target.getAttribute('style') === '') {
			e.target.removeAttribute('style');
		}
	});
}

export default { 
	Xsl,
	Form,
};
export { 
	Xsl,
	Form,
};