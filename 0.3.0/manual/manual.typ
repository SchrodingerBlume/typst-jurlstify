#import "@preview/min-manual:0.3.0": *
#import "@preview/metalogo:1.2.0": TeX, LaTeX
#import "../lib.typ": jurlstify, jurl, jurlstify-links
#set text(font: "New Computer Modern")

#show: manual.with(
  title: [jurlstify],
  description: [URL typesetting with line-break opportunities\ — the url package port for Typst.],
  authors: "SchrodingerBlume <@SchrodingerBlume>",
  package: "jurlstify:0.3.0",
  license: [MIT],
)

// Shrink monospace: min-manual sets raw to the body size (13pt), which looks
// oversized next to a serif body.
#show raw: set text(size: 0.85em)

// Render plain-text "LaTeX"/"TeX" as the metalogo logos everywhere — including
// the from-comments Reference, whose eval scope can't import metalogo itself.
// So write plain "LaTeX"/"TeX" (not #LaTeX) in ../lib.typ doc-comments.
#show "LaTeX": LaTeX
#show regex("\bTeX\b"): TeX

// Bordered preview box, so a rendered demo reads like a small page.
#let preview(width: 100%, body) = block(
  width: width,
  stroke: 0.5pt + luma(200),
  radius: 3pt,
  inset: 8pt,
  body,
)

// Smaller bold caption above a preview box.
#let caption(it) = text(size: 0.85em, weight: "bold", it)

#v(1fr)
#outline()
#v(1.2fr)
#pagebreak()


= Overview

This package ports the line-breaking logic of #LaTeX's\u{0020}#url("https://ctan.org/pkg/url")[`url` package]to Typst. Typst breaks bare URLs only at a fixed, non-configurable set of characters. A URL that contains none of them overflows the margin, and the available break points can produce uneven word spacing in justified paragraphs. This package inserts break opportunities at a configurable set of characters, and can add further breaks at a fixed interval inside long runs.

The options fall into two groups:

/ Where a line may break: `break-chars`, `big-break-chars`, `no-break-chars`, `break-at-literal-hyphens`, `extra-break-every`.
/ Whether to show a visible hyphen at a break: `show-hyphens-after-delimiters` (for delimiter breaks) and `show-hyphens-at-extra-breaks` (for extra breaks).

#callout[
  By default, the package breaks only at delimiter characters and shows no hyphen, matching the `url` package. The hyphen is omitted because it could be mistaken for part of the URL itself.
]


= Quick Start

```typ
#import "@preview/jurlstify:0.3.0": jurlstify, jurl, jurlstify-links

// Render a URL string with break opportunities
#jurlstify("https://example.com/very/long/path?query=value&more=stuff")

// Clickable link — same breaking, wrapped in link()
#jurl("https://example.com/very/long/path?query=value")

// Apply automatically to every link() in the document
#show: jurlstify-links.with()
#link("https://example.com/automatically/handled")
```

#pagebreak()


= Reference

The three default character sets are exported as `break-chars-default`,
`big-break-chars-default`, and `no-break-chars-default`, so you can extend them
— e.g. `break-chars: break-chars-default + ("~",)`.

// Auto-generated from the doc-comments in ../lib.typ (single source of truth).
#from-comments(read("../lib.typ"), ("///", "/**", "**/"))

#pagebreak()


= Examples

Break at delimiters only (default) versus showing a hyphen at each delimiter
break — shown in a narrow column so the wrapping is visible:

```typ
#jurlstify("https://example.com/very/long/path/to/resource")
#jurlstify("https://example.com/very/long/path/to/resource",
  show-hyphens-after-delimiters: true)
```

#grid(
  columns: (0cm, 6cm, 6cm, 0cm),
  gutter: 1fr,
  [],
  [
    #caption[default] \
    #preview[
      #jurlstify("https://example.com/very/long/path/to/resource")
    ]
  ],
  [
    #caption[show-hyphens-after-delimiters] \
    #preview[
      #jurlstify("https://example.com/very/long/path/to/resource",
        show-hyphens-after-delimiters: true)
    ]
  ],
  [],
)

A long run with no delimiter, broken every 1 chars with a hyphen shown:

```typ
#jurlstify("https://example.com/averylongpathsegmentwithnobreaks",
  extra-break-every: 1)
#jurlstify("https://example.com/averylongpathsegmentwithnobreaks",
  extra-break-every: 1, show-hyphens-at-extra-breaks: true)
```

#grid(
  columns: (0cm, 6cm, 6cm, 0cm),
  gutter: 1fr,
  [],
  [
    #caption[default] \
    #preview[
      #jurlstify("https://example.com/averylongpathsegmentwithnobreaks", extra-break-every: 1)
    ]
  ],
  [
    #caption[show-hyphens-at-extra-breaks] \
    #preview[
      #jurlstify("https://example.com/averylongpathsegmentwithnobreaks", extra-break-every: 1, show-hyphens-at-extra-breaks: true)
    ]
  ],
  [],
)

Applying the show rule to a whole document:

```typ
#show: jurlstify-links.with(show-hyphens-after-delimiters: true)

The homepage is #link("https://example.com/very/long/path").
// auto-formatted

See #link("https://example.com", "the docs").
// untouched
```

#grid(columns: (1fr, 8cm, 1fr), [], preview[
  #show: jurlstify-links.with(show-hyphens-after-delimiters: true)
  The homepage is #link("https://example.com/very/long/path/to/resource"). 

  See #link("https://example.com", "the docs").
], [])

#pagebreak()


= Migration (0.2.x #sym.arrow 0.3.0)

#table(
  columns: (auto, auto),
  align: left,
  table.header([*0.2.x*], [*0.3.0*]),
  [`hyphens`], [`break-at-literal-hyphens`],
  [`every`], [`extra-break-every`],
  [`breaks`], [`break-chars`],
  [`big-breaks`], [`big-break-chars`],
  [`no-breaks`], [`no-break-chars`],
  [`show-hyphen`], [`show-hyphens-after-delimiters` +\ `show-hyphens-at-extra-breaks`],
  [`spaces: "nobreak"`], [`show-spaces-as: "nbsp"`],
  [`spaces: "break"`], [`show-spaces-as: "normal"`],
  [`spaces: "strip"`], [`show-spaces-as: none`],
)

#callout(title: "Compatibility")[
  0.3.0 is a clean rename with no old-name aliases. Code written for older
  versions keeps working by pinning `@preview/jurlstify:0.2.x`.
]
