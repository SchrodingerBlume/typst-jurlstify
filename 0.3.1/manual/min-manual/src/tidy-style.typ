// min-manual-flavoured tidy style.
//
// Added by the jurlstify project (not part of upstream min-manual, which is
// MIT-licensed — see ../LICENSE).
//
// Why: min-manual's own doc-comment DSL writes parameters as `name <- type`,
// which collides with Typst's label syntax `<...>`. Tinymist parses `///`
// doc-comments as Typst markup, so that syntax makes every hover report
// "failed to parse docs: unclosed label". Tidy's format (`- name (type): desc`)
// is what tinymist understands, giving clean hovers *and* resolved parameter
// types.
//
// So: let tidy parse the doc-comments, and render them here with min-manual's
// `#arg` blocks, keeping the manual's look unchanged.

#import "@preview/tidy:0.4.2"
#import "lib.typ": arg

#let base = tidy.styles.default

// Render one parameter as a min-manual `#arg` block.
#let show-parameter-block(
  function-name: none, name, types, content, style-args,
  show-default: false,
  default: none,
) = {
  let title = name
  if types != none and types.len() > 0 {
    title += " <- " + types.join(" | ")
  }
  // Tidy marks a parameter required when it carries no default value.
  if not show-default { title += " <required>" }
  arg(title)[#content]
}

// Render one function: a raw-styled heading, the description, then its
// parameters as `#arg` blocks.
#let show-function(fn, style-args) = {
  // Emit the same cross-reference label tidy's outline links to.
  [
    #heading(level: style-args.first-heading-level + 1, raw(fn.name))
    #if style-args.at("enable-cross-references", default: false) {
      label(style-args.at("label-prefix", default: "") + fn.name + "()")
    }
  ]

  eval(fn.description, mode: "markup", scope: style-args.at("scope", default: (:)))

  for (name, info) in fn.args {
    if name.starts-with("_") { continue }
    let types = info.at("types", default: ())
    let description = info.at("description", default: "")
    if description.trim() == "" { continue }
    show-parameter-block(
      name,
      types,
      eval(description, mode: "markup", scope: style-args.at("scope", default: (:))),
      style-args,
      show-default: "default" in info,
      default: info.at("default", default: none),
      function-name: fn.name,
    )
  }
  v(1.2em, weak: true)
}

// Everything else falls back to tidy's default style.
#let style = (
  show-outline: base.show-outline,
  show-type: base.show-type,
  show-parameter-list: base.show-parameter-list,
  show-parameter-block: show-parameter-block,
  show-function: show-function,
  show-variable: base.show-variable,
  show-reference: base.show-reference,
  show-example: base.show-example,
)
