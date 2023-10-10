#import "mantys.typ": *

// Some fancy logos
// credits go to discord user @adriandelgado
#let TeX = style(styles => {
  set text(font: "New Computer Modern")
  let e = measure("E", styles)
  let T = "T"
  let E = text(1em, baseline: e.height * 0.31, "E")
  let X = "X"
  box(T + h(-0.15em) + E + h(-0.125em) + X)
})

#let LaTeX = style(styles => {
  set text(font: "New Computer Modern")
  let a-size = 0.66em
  let l = measure("L", styles)
  let a = measure(text(a-size, "A"), styles)
  let L = "L"
  let A = box(scale(x: 110%, text(a-size, baseline: a.height - l.height, "A")))
  box(L + h(-a.width * 0.67) + A + h(-a.width * 0.25) + TeX)
})

#let cnltx = package("CNLTX")

#let shell( title:"shell", sourcecode ) = {
	mty.frame(
		stroke-color: black,
		bg-color: luma(42),
		radius: 0pt,
		{
			set text(fill:rgb(0,255,36))
			sourcecode
		}
	)
}

#show: mantys.with(
	name:		"Mantys",
	title: 		"The Mantys Package",
	subtitle: 	[#strong[MAN]uals for #strong[TY]p#strong[S]t],
	info:		[A Typst template to create consistens and readable manuals for packages and templates.],
	authors:	((name: "Jonas Neugebauer", email:"github@neugebauer.cc"),),
	url:		"https://github.com/jneug/typst-mantys",
	version:	"0.0.3",
	date:		datetime.today(),
	abstract: 	[
		#package[Mantys] is a Typst template to help package and template authors to write manuals. It provides functionality for consistent formatting of commands, variables, options and source code examples. The template automatically creates a table of contents and a commanc index for easy reference and navigation.

    The main idea and design was inspired by the #LaTeX package #cnltx by #mty.name[Clemens Niederberger].
	],

	example-imports: ("@local/mantys:0.0.3": "*"),
)

= About

Mantys is a Typst package to help package and template authors to write consistently formatted manuals. The idea is that, as many Typst users are switching over from #TeX, they are used to the way packages provide a PDF manual for reference. Though in a modern ecosystem there are other ways to write documentation (like #mty.footlink("https://rust-lang.github.io/mdBook/")[mdBook] or #mty.footlink("https://asciidoc.org")[AsciiDoc]), having a manual in PDF format might still be beneficial, since many users of Typst will generate PDFs as their main output.

The design and functionality of Mantys was inspired by the fantastic #LaTeX package #mty.footlink("https://ctan.org/pkg/cnltx")[#cnltx] by #mty.name[Clemens Niederberger]#footnote[#link("mailto:clemens@cnltx.de", "clemens@cnltx.de")].

#ebox[
  Note that this manual is currently out of date with the newest version of Mantys and will be updated soon.
]

This manual is supposed to be a complete reference of Mantys, but might be out of date for the most recent additions and changes. On the other hand, the source file of this document is a great example of the things Mantys can do. Other than that, refer to the README file in the GitHub repository and the source code for Mantys.

#wbox[
	Mantys is in active development and its functionality is subject to change. Until version #mty.ver(0,1,0) is reached, the command signatures and manual layout may change and break previous versions. Keep that in mind while using Mantys.

  Contributions to the package are very welcome!
]

= Usage

== Using Mantys

=== Loading as a package

Currently the package needs to be installed into the local package repository.

Either download the current release from GitHub#footnote[#link("https://github.com/jneug/typst-typopts/releases/latest")] and unpack the archive into your system dependent local repository folder#footnote(link("https://github.com/typst/packages#local-packages")) or clone it directly:

#codesnippet[```shell-unix-generic
git clone https://github.com/jneug/typst-mantys.git mantys-0.0.3
```]

After installing the package just import it inside your `typ` file:

#codesnippet[```typ
#import "@local/mantys:0.0.3": *
```]

=== Loading as a module

To load Mantys into a single project as a module download the necessary files and place them inside the project directory. The required files are `mantys.typ` and `mty.typ`.

Import the module into your manual file:

#codesnippet[```typ
#import "mantys.typ": *
```]

=== Initialising the template

After importing Mantys the template is initialized by applying a show rule with the #cmd[mantys] command passing the necessary options using `with`:
#codesnippet[```typ
#show: mantys.with(
	...
)
```]

#command("mantys", ..args(
	name:	   none,
	title:     none,
	subtitle:  none,
	info:      none,
	authors:   (),
	url:       none,
	version:   none,
	date:      none,
	abstract:  [],
	titlepage: titlepage,
	example-imports: (:),
	[body]), sarg[args])[
		#argument("titlepage", default:titlepage)[
			A function of nine arguments to render a titlepage for the manual. Refer to #refcmd("titlepage") for details.
		]
		#argument("example-imports", default:(:))[
			Default imports for code examples. Each entry should have the full package identifier as a key and the imports as a value. If the package should be imported es a whole, the value should be #value("").

			```typc
			example-imports: (
			  "@local/mantys:0.0.3": "*",
			  "@preview/tablex:0.0.1": "",
			  "@preview/cetz:0.0.1": "canvas"
			)
			```

			For further details refer to #refcmd("example").
		]

		All other arguments will be passed to #cmd-[titlepage].

		All uppercase occurences of #arg[name] will be highlighted as a packagename. For example MAN\u{2060}TYS will appear as Mantys.
]

== Available commands

=== Describing arguments and values

#command("meta", arg[name], ret:"content")[
	Used to highlight argument names.
	#quickex(`#meta[variable]`)
]
#command("value", arg[variable], ret:"content")[
	Used to display the value of a variable. The command will highlight the value depending on the type.

	- #quickex(`#value[name]`)
	- #quickex(`#value("name")`)
	- #quickex(`#value((name: "value"))`)
	- #quickex(`#value(range(4))`)
]
#command("arg", arg[name], ret:"content")[
	Renders an argument, either positional or named. The argument name is highlighted with #cmd-[meta] and the value with #cmd-[value].

	- #quickex(`#arg[name]`)
	- #quickex(`#arg("name")`)
	- #quickex(`#arg(name: "value")`)
]
#command("sarg", arg[name], ret:"array")[
	Renders an argument sink.
	#quickex(`#sarg[args]`)
]
#command("barg", arg[name], ret:"content")[
	Renders a body argument.
	#quickex(`#barg[body]`)

	#ibox(width:100%)[Body arguments are positional arguments that can be given as a separat content block at the end of a command.]
]
#command("args", sarg[args], ret:"content")[
	Creates an array of all its arguments rendered either by #cmd-[arg] or #cmd-[barg]. All values of type #dtype("content") will be passed to #cmd-[barg] and everything else to #cmd-[arg].

	This command is intendend to be unpacked as the arguments to one of #cmd-[cmd] or #cmd-[command].

	#example[```
	#cmd("my-command", ..args("arg1", arg2: false, [body]))
	```]
]
#command("dtype", arg[t], arg(fnote: false), arg(parse-type: false), ret:"string")[
	Shows the (data-)type of #arg[t] and a link to the Typst documentation of that type.

	#arg(fnote: true) will show the reference link in a footnote (useful for print versions of the manual).

	The type is determined by passing #arg[t] to #doc("foundations/type").
	If #arg[t] is a string however, it is assumed to already be a type name. For example #value("fraction") will give the type #dtype("fraction"). Setting #arg(parse-type: true) will prevent this and always call `type` on #arg[t].

	- #quickex(`#dtype(false)`)
	- #quickex(`#dtype(1%)`)
	- #quickex(`#dtype(left)`)
	- #quickex(`#dtype([some content], fnote:true)`)
	- #quickex(`#dtype("dictionary")`)
	- #quickex(`#dtype("dictionary", parse-type:true)`)
]
#command("dtypes", sarg[types], arg(sep:box(inset:(left:1pt,right:1pt), sym.bar.v)), ret:"content")[
	Will produce a list of types from the provided arguments. Each value is passed to #cmd-[dtype] and the results joined by #arg[sep].

	- #quickex(`#dtypes(false, 1cm, "array", [world])`)
	- #quickex(`#dtypes(false, 1cm, "array", [world], sep: " or ")`)
]
#command("choices", arg(default:"__none__"), sarg[values])[
	Creates a list of possible values for an argument.

	If #arg[default] is set to something else than #value("__none__"), the value is highlighted as the default choice. If #arg[default] is already given in #arg[values], the value is highlighted at its current position. Otherwise #arg[default] is added as the first choice in the list.

	- #quickex(`#choices(..range(5))`)
	- #quickex(`#choices(..range(5), default:3)`)
	- #quickex(`#choices(..range(5), default:5)`)
]
#command("opt", arg[name], sarg[args], barg[body])[
	Renders the option #arg[name] and adds an entry to the index.

	- #quickex(`#opt[example-imports]`)
]
#command("opt-", arg[name], sarg[args], barg[body])[
	Same as #cmd[opt] but does not create an index entry.
]

=== Describing commands
#command("cmd", arg[name], sarg[args], barg[body])[
	Renders the command #arg[name] with arguments and creates an entry in the command index.

	#arg[args] is a collection of positional arguments created with #cmd[arg], #cmd[barg] and #cmd[sarg].

	All positional arguments will be rendered first, then named arguemnts and all body arguments will be added after the closing paranthesis.

	- #quickex(`#cmd("cmd", arg[name], sarg[args], barg[body])`)
	- #quickex(`#cmd("cmd", ..args("name", [body]), sarg[args])`)
]
#command("cmd-", arg[name], sarg[args], barg[body])[
	Same as #cmd[cmd] but does not create an index entry.
]
#command("var", arg[name], arg(default:none))[

]
#command("var-", arg[name], arg(default:none))[

]


#command("command", arg[name], sarg[args], barg[body])[
	Shows
]
#command("argument", "name", "type", default:"__none__")[

]
#command("variable", arg[name], sarg[args], barg[body])[

]

=== Source code and examples

Mantys provides several commands to handle source code snippets and show examples of functionality. The usual #doc("text/raw") command still works, but theses commands allow you to highlight code in different ways or add line numbers.

Typst code examples can be set with the #cmd[example] command. Simply give it a fenced code block with the example code and Mantys will render the code as highlighted Typst code and show the result underneath.

#example(raw("#example[
```
This will render as *content*.

Use any #emph[Typst] code here.
```
]"))

The result will be generated using #doc("foundations/eval") and thus is subject to its limitations. Each `eval` call is run in a local scope and does not have access to previously imported commands. To use your packages commands, you have to import it as a package:

#example(raw("#example[```
#import \"@local/mantys:0.0.3\": dtype

#dtype(false)
```]"))

#wbox[
	You can only import packages and not local files.
]

To automatically add imports to every example code, you can set the option #opt[example-imports] at the initial call to #cmd[mantys]. For example this manual was compiled with #arg(example-imports: ("@local/mantys:0.0.3": "*")). This imports the Mantys commands into all example code, without explicitly importing it in the code.

#example(raw("#example[```
#mty.value(false)
```]"))

See #refrel(<cmd-example>) for how to use the #cmd-[example] command.

#ibox[
	To use fenced code blocks in your example, add an extra backtick to the example code:

	#example(imports:("@local/mantys:0.0.3": "example"), raw("#example[````
```rust
fn main() {
  println!(\"Hello World!\");
}
```
````]"))
]

#command("example", ..args(side-by-side: false, imports:(:), [example-code], [result]))[
	#argument("example-code", type:"content")[
		A block of #doc("text/raw") code representing the example Typst code.
	]
	#argument("side-by-side", type:"boolean", default:false)[
		Usually, the #arg[example-code] is set above the #arg[result] separated by a line. Setting this to #value(true) will set the code on the left side and the result on the right.
	]
	#argument("imports", type:"dictionary", default:(:))[
		A dictionary of package imports that should be added to the evaluated code.
	]
	#argument("result", type:"content")[
		The result of the example code. Usually the same code as #arg[example-code] but without the `raw` markup.

		#wbox(width:100%)[#arg[result] is optional and will be omitted in most cases!]
	]

	Sets #barg[example-code] as a #doc("text/raw") block with #arg(lang: "typ") and the result of the code beneath. #barg[example-code] need to be `raw` code itself.

	#example[
#raw("#example[```
*Some lorem ipsum:*\
#lorem(40)
```]")
	]

	Setting #arg(side-by-side: true) will set the example on the left side and the result on the right and is useful for short code examples. The command #cmd-[side-by-side] exists as a shortcut.

	#example[
#raw("#example(side-by-side: true)[```
*Some lorem ipsum:*\
#lorem(20)
```]")
	]

	#barg[example-code] is passed to #cmd-[mty.sourcecode] for processing.

	If the example-code needs to be different than the code generating the result, #cmd-[example] accepts an optional second positional argument #barg[result]. If provided, #barg[example-code] is not evaluated and #barg[result] ist used instead.

	#example[
#raw("#example[```
#value(range(4))
```][
The value is: #mty.value(range(4))
]")
	]
]

#command("side-by-side", barg[example-code], barg[result])[
	Shortcut for #cmd("example", arg(side-by-side: true)).
]

#command("sourcecode", title:none, file:none, [code])[
	If provided, the #arg("title") and #arg("file") argument are set as a titlebar above the content.

	#argument("code", type:dtype("content"))[
		A #cmd[raw] block, that will be set inside a bordered block. The `raw` content is not modified and keeps its #arg("lang") attribute, if set.
	]
	#argument("title", type:dtype("string"), default:none)[
		A title to show above the code in a titlebar.
	]
	#argument("file", type:dtype("string"), default:none)[
		A filename to show above the code in a titlebar.
	]

	#cmd-[sourcecode] will render a #doc("text/raw") block with linenumbers and proper tab indentions using #package[codelst] and put it inside a #cmd-[mty.frame].

	If provided, the #arg("title") and #arg("file") argument are set as a titlebar above the content.

	#example(raw("#sourcecode(title:\"Some Rust code\", file:\"world.r\")[```rust
	fn main() {
		println!(\"Hello World!\");
	}
```]"))
]

=== Other commands

#command("package")[
	Shows a package name:

	#side-by-side()[
	```
	#package[tablex]

	#mty.package[tablex]
	```
	]
]

// #let pkg = mty.package
// #let module = mty.module
// #let idx = mty.idx
// #let make-index = mty.make-index

// #let doc( target, name:none, fnote:false ) = {

=== Templating

#command("titlepage", ..args("name", "title", "subtitle", "info", "authors", "url", "version", "date", "abstract"))[

]

=== Utilities

Most of MANTYS functionality is located in a module named #module[mty]. Only the main commands are exposed at a top level to keep the namespace polution as minimal as possible to prevent name collisons with commands belonging to the package / module to be documented.

The commands provide some helpful low-level functionality, that might be useful in some cases.
#variable("colors", types:("dictionary",))[
	#lorem(30)
]

#module-commands("mty")[
#command("type", arg[variable], ret:"string")[
	Alias for the buildin #doc("foundations/type") command.
]

#command("kv", ..args("key", "value"), ret:"dictionary")[
	#argument("key")[
		#lorem(10)
	]
	Creates a #dtype("dictionary") containing the given #arg[key]/#arg[value]-pair. Useful for using `map` on the pairs of a dictionary:
	```typc
	#let dict = (a: 1, b: 2, c: 3)
	dict.pairs().map(p => kv(..p)).map( ... )
	```
]
#command("txt", arg[variable], ret:"string")[
	Extracts the text content of #arg[variable] as a #dtype("string"). The command attempts to extract as much text as possible by looking at possible children of a content element.


]
#command("rawi", barg[code], arg(lang:none), ret:"content")[
	Inline #doc("text/raw") content with an optional language fpr highlighting.
]
#command("rawc", arg[color], barg[code], ret:"content")[
	Colored inline #doc("text/raw") content. This supports no language argument, since #arg[code] will have a uniform #arg[color].
]

#command("primary")[]
#command("secondary")[]

#command("cblock", arg(width:90%), barg[body], sarg[block-args], ret: "content")[
	Sets #arg[body] inside a centered #doc("layout/block") with the given #arg[width]. Any further arguments will be passed to the `block` command.
]
#command("box", barg[body], ..args(header:none, footer:none, invert-headers:true, stroke-color:colors.primary, bg-color:white, width:100%, padding: 8pt, radius:4pt), ret: "content")[
	#lorem(100)
]
#command("alert", barg[body], ..args(color:blue, icon:none, title:none, width:90%, size:.9em), ret: "content")[
	#lorem(50)
]
#command("marginnote", ..args(pos: left, margin: .5em, dy: 0pt), barg[body], ret: "content")[
	#lorem(30)
]
#command("sourcecode", ..args(fill: white, border: none, tab-indent: 4, gobble: auto, linenos: true, gutter: 10pt,), barg[body], ret: "content")[
	#lorem(30)
]


#command("ver", ..args("major", "minor", "patch"), ret: "content")[
	#side-by-side[
		```
		#mty.ver(0, 0, 1)
		```
	][
		#mty.ver(0, 0, 1)
	]
]
#command("name", arg[name], arg(last:none), ret: "content")[

	```example
	- #mty.name("Jonas Neugebauer")
	- #mty.name("Jonas van Neugebauer")
	- #mty.name("Jonas van", last:"Neugebauer")
	- #mty.name("Jonas", last:"van Neugebauer")
	```
]
#command("author", arg[info], ret: "content")[
	```example
	- #mty.author("Jonas Neugebauer")
	- #mty.author(
		(name: "Jonas van Neugebauer")
	)
	- #mty.author((
		name: "Jonas van Neugebauer",
		email: "jonas@neugebauer.cc"
	))
	```
]
#command("date", arg[d], ret: "content")[
	#side-by-side(imports:("@local/mantys:0.0.3":"mty"))[
		```
		- #mty.date("2023-07-15")
		- #mty.date(datetime(year:2023, month:7, day:15))
		- #mty.date(datetime.today())
		- #mty.date(datetime.today(), format:"[day].[month].[year]")
		```
	]
]
#command("package", arg[name], ret:"content")[
	```side-by-side
	- #mty.package("Mantys")
	- #mty.package("typopts")
	```
]
#command("module", arg[name], ret:"content")[
	#side-by-side[
		```
		- #mty.module("mty")
		- #mty.module("emoji")
		```
	][
		- #mty.module("mty")
		- #mty.module("emoji")
	]
]


#command("value", arg[variable], ret:"content")[
	Returns the value of #arg[variable] as content.

	#side-by-side[
		```
		- #mty.value("string")
		- #mty.value([string])
		- #mty.value(true)
		- #mty.value(1.0)
		- #mty.value(3em)
		- #mty.value(50%)
		- #mty.value(left)
		- #mty.value((a: 1, b: 2))
		```
	][
		- #mty.value("string")
		- #mty.value([string])
		- #mty.value(true)
		- #mty.value(1.0)
		- #mty.value(3em)
		- #mty.value(50%)
		- #mty.value(left)
		- #mty.value((a: 1, b: 2))
	]
]
#command("default", arg[value], ret:"content")[
	Highlights the default value of a set of #cmd[choices]. By default the value is underlined.

	#side-by-side[
		```
		- #mty.default("default-value")
		- #mty.default(true)
		- #choices(1, 2, 3, 4, default: 3)
		```
	][
		- #mty.default("default-value")
		- #mty.default(true)
		- #choices(1, 2, 3, 4, default: 3)
	]
]

==== Argument filters

#command("is-string", arg[value])[
	Checks if #arg[value] is a #dtype("string").
]
#command("is-content", arg[value])[
	Checks if #arg[value] is #dtype("content").
]
#command("is-choices", arg[value])[
	Checks if #arg[value] is a choices value created with #cmd[choices].
]
#command("is-body", arg[value])[
	Checks if #arg[value] is a body argument created with #cmd[barg].]
#command("not-is-body", arg[value])[
	Negation of #cmd[is-body].
]
#command("not-is-choices", arg[value])[
	Negation of #cmd[is-choices].
]
]
