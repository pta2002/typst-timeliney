# Mantys (v0.0.3)

> **MAN**uals for **TY**p**S**t

Template for documenting [typst](https://github.com/typst/typst) packages and templates.

## Usage

Mantys supports **Typst 0.6.0** and newer.

Download the [latest version](https://github.com/jneug/typst-mantys/releases/tag/v0.0.3) and unpack it into the [system dependent local package repository](https://github.com/typst/packages#local-packages).

In your local repository type:
```shell
wget https://github.com/jneug/typst-mantys/archive/refs/tags/v0.0.3.tar.gz
mkdir mantys-0.0.3
tar -xzf v0.0.3.tar.gz -C mantys-0.0.3
```

Now import the package at the beginning of your manual document:
```js
#import "@local/mantys:0.0.3": *
```

To use **Mantys** as a local module for one project only, download the package and unpack into a folder inside your project (e.g. `/mantys`). Then import `mantys/mantys.typ`:

```js
#import "mantys/mantys.typ": *
```

### Other requirements

Mantys depends on some other packages. All but one are available from the Typst package repository and will get downloaded automatically.

- [jneug/typst-codelst](jneug/typst-codelst)
- [Pablo-Gonzalez-Calderon/showybox-package](Pablo-Gonzalez-Calderon/showybox-package)
- [jneug/typst-tools4typst](jneug/typst-tools4typst)

The only one currently waiting for approval is [jneug/typst-tools4typst](jneug/typst-tools4typst). Currently, the package ([v0.1.0](https://github.com/jneug/typst-tool4typst/releases/tag/v0.1.0)) needs to be downloaded and saved in the local repository. (See above for a description of the process.)

## Writing basics

A basic template for a manual could look like this:

```js
#import "@local/mantys:0.0.3": *

#show: mantys.with(
	name:		"your-package-name",
	title: 		[A title for the manual],
	subtitle: 	[A subtitle for the manual],
	info:		[A short descriptive text for the package.],
	authors:	"Your Name",
	url:		"https://github.com/repository/url",
	version:	"0.0.1",
	date:		"date-of-release",
	abstract: 	[
		A few paragraphs of text to describe the package.
	],

	example-imports: ("@local/your-package-name:0.0.1": "*")
)

// end of preamble

# About
#lorem(50)

# Usage
#lorem(50)

# Available commands
#lorem(50)

```

Use `#command(name, ..args)[description]` to describe commands and `#argument(name, ...)[description]` for arguments:

```js
#command("headline", arg[color], arg(size:1.8em), sarg[other-args], barg[body])[
	Renders a prominent headline using #doc("meta/heading").

	#argument("color", type:"color")[
    The color of the headline will be used as the background of a #doc("layout/block") element containing the headline.
  ]
  #argument("size", default:1.8em)[
    The text size for the headline.
  ]
  #argument("sarg", is-sink:true)[
    Other options will get passed directly to #doc("meta/heading").
  ]
  #argument("body", type:"content")[
    The text for the headline.
  ]

  The headline is shown as a prominent colored block to highlight important news articles in the newsletter:

  #example[```
  #headline(blue, size: 2em, level: 3)[
    #lorem(8)
  ]
  ```]
]
```

The result might look something like this:

![Example for a headline command with Mantys](assets/headline-example.png)

For a full reference of available commands read [the manual](manual.pdf).

## Changelog

### Version 0.0.3

- Added some dependencies:
	- [jneug/typst-tools4typst](jneug/typst-tools4typst) for some common utilities,
	- [jneug/typst-codelst](jneug/typst-codelst) for rendering examples and source code,
	- [Pablo-Gonzalez-Calderon/showybox-package](Pablo-Gonzalez-Calderon/showybox-package) for adding frames to different areas of a manual (like examples).
- Redesign of some elements:
	- Argument display in command descriptions,
	- Alert boxes.
- Added `#version(since:(), until:())` command to add version markers to commands.
- Fixes and code improvements.

### Version 0.0.2

- Some major updates to the core commands and styles.

### Version 0.0.1

- Initial release.
