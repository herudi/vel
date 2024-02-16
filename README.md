# Vel

Declarative html-element in V.

> Vel just a tiny program about (~80 lines of code).

## Install
```bash
v install herudi.vel
```

## Basic 
```v
module main

import herudi.vel { Elem }

fn main() {
  ast := Elem{'div', {}, [
    Elem{'span', {}, ['hello vel']},
    Elem{'input', {'id': 'name'}, []},
  ]}

  // print just ast
  println(ast)

  // convert ast to string
  println(ast.to_string())

  // <div><span>hello vel</span><input id="name"></div>
}
```
**Elem**, just a struct for simple declarative html elements. `Elem{tag, attr, child}`.

```v
// Elem sources in vel.

type Child = []Child | string | int | bool | Elem
type Value = string | bool | map[string]string

@[params]
struct Elem {
	tag   string
  attr  map[string]Value
  child []Child
}
```

## Custom Element 
```v
struct Html {
	head []Child
	body []Child
}

// render to html markup
fn to_html(h Html) string {
  return '<!DOCTYPE html>' + (
		Elem{'html', { 'lang': 'en' }, [
			Elem{'head', {}, [
				Elem{'meta', { 'charset': 'utf-8' }, []},
				Elem{'meta', { 'name': 'viewport', 'content': 'width=device-width, initial-scale=1.0' }, []},
				h.head,
			]},
			Elem{'body', {}, h.body},
		]}
	).to_string()
}

// custum layout element/component
fn my_layout(elem Elem) Elem {
	return (
		Elem{'div', {'id': 'my_layout'}, [
			Elem{'h1', {}, ['Title From Layout']},
			elem.child,
		]}
	)
}

fn main() {
	html := to_html(
		head: [
			Elem{'title', {}, ['hello vel title']},
		]
		body: [
			my_layout(
				child: [
					Elem{'p', {}, ['this is content']},
				]
			),
		]
	)
	println(html)
}
```

## Fragment
```v
elem := Elem{
  child: [
    Elem{'h1', {}, ['foo']},
    Elem{'h2', {}, ['bar']},
  ]
}

println(elem.to_string())

// <h1>foo</h1><h2>bar</h2>
```
## License

[MIT](LICENSE)
