module vel

fn test_to_string() {
	elem := Elem{'div', {}, [
		Elem{'h1', {}, ['hello']},
	]}
	assert elem.to_string() == '<div><h1>hello</h1></div>'
}

fn test_unsafe_html() {
	elem := Elem{'div', {}, [unsafe_html('<h1>unsafe hello</h1>')]}
	assert elem.to_string() == '<div><h1>unsafe hello</h1></div>'
}

fn test_to_style() {
	str := to_style({
		'height': '20px'
	})
	assert str == 'height:20px;'
}

fn test_to_attr() {
	str := to_attr({
		'id':      'name'
		'name':    'name'
		'disable': true
		'gone':    false
	})
	assert str == ' id="name" name="name" disable'
}

fn test_html_to_string() {
	html := Html{
		head: [
			Elem{'title', {}, ['title']},
		]
		body: [
			Elem{'h1', {}, ['hello']},
		]
		html_attr: {}
		body_attr: {
			'id': 'my_body'
		}
	}
	assert html.to_string() == '<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>title</title></head><body id="my_body"><h1>hello</h1></body></html>'
}
