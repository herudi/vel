module vel

import encoding.html

pub type Child = Elem | []Child | bool | int | string
pub type Value = bool | map[string]string | string

@[params]
pub struct Elem {
pub mut:
	tag   string
	attr  map[string]Value
	child []Child
}

@[params]
pub struct Html {
pub mut:
	head      []Child
	body      []Child
	footer    []Child
	html_attr map[string]Value
	body_attr map[string]Value
}

const unsafe_flag = '#__UNSAFE_VEL__#'
const void_tag = ['area', 'base', 'br', 'col', 'embed', 'hr', 'img', 'input', 'link', 'meta', 'param',
	'source', 'track', 'wbr']

fn escape_html(str string) string {
	if str.starts_with(vel.unsafe_flag) {
		return str.replace(vel.unsafe_flag, '')
	}
	return html.escape(str, html.EscapeConfig{})
}

fn to_attr(data map[string]Value) string {
	mut attr := ''
	for k, v in data {
		if v is string {
			attr += ' ${k.to_lower()}="${escape_html(v)}"'
		} else if v is map[string]string {
			attr += ' ${k.to_lower()}="${to_style(v)}"'
		} else if v is bool {
			if v == true {
				attr += ' ${k.to_lower()}'
			}
		}
	}
	return attr
}

fn to_style(obj map[string]string) string {
	mut out := ''
	for k, v in obj {
		out = out + k + ':' + v + ';'
	}
	return out
}

fn to_string(elem Child) string {
	if elem is bool {
		return ''
	}
	if elem is int {
		return elem.str()
	}
	if elem is string {
		return escape_html(elem)
	}
	if elem is []Child {
		return elem.map(to_string(it)).join('')
	}
	el := elem as Elem
	tag := el.tag
	attr := to_attr(el.attr)
	if tag in vel.void_tag {
		return '<${tag}${attr}>'
	}
	res := to_string(el.child)
	if tag == '' {
		return res
	}
	return '<${tag}${attr}>${res}</${tag}>'
}

pub fn (e Elem) to_string() string {
	return to_string(e)
}

pub fn (h Html) to_string() string {
	mut html_attr := h.html_attr.clone()
	if 'lang' !in html_attr {
		html_attr['lang'] = 'en'
	}
	return '<!DOCTYPE html>' + '<html${to_attr(html_attr)}>' + '<head><meta charset="utf-8">' +
		'<meta name="viewport" content="width=device-width, initial-scale=1.0">' +
		'${to_string(h.head)}</head>' +
		'<body${to_attr(h.body_attr)}>${to_string(h.body)}${to_string(h.footer)}</body>' + '</html>'
}

pub fn unsafe_html(str string) Child {
	return Child('${vel.unsafe_flag}${str}')
}
