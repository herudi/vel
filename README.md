# Vel

Declarative html-element in V.

> Vel just a tiny program about (~100 lines of code).

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

## Using Html Markup
```v
import herudi.vel { Elem, Html }

html := Html{
  head: [
    Elem{'title', {}, ['home page title']},
  ]
  body: [
    Elem{'h1', {}, ['Home Page']},
  ]
}
println(html.to_string())
```

## Custom Component
```v
import herudi.vel { Elem, Html }

// this is layout
fn my_layout(elem Elem) Elem {
	return Elem{'div', {}, [
		Elem{'h1', {}, ['This is layout']},
		elem.child,
	]}
}

elem := Elem{
  child: [
    my_layout(
      child: [
        Elem{'p', {}, ['This is content']},
      ]
    ),
  ]
}
println(elem.to_string())
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

## Handle Array
```v
import herudi.vel { Child, Elem }

struct Person {
	name string
	age  int
}

persons := [Person{'john', 20}, Person{'yanto', 50}]

elem := Elem{
  child: [
    persons.map(fn (person Person) Child {
      return Elem{'div', {}, [
        Elem{'h1', {}, ['Name : ${person.name}']},
        Elem{'h1', {}, ['Age  : ${person.age}']},
      ]}
    }),
  ]
}
println(elem.to_string())
```
## License

[MIT](LICENSE)
