#import "../lib.typ": jurlstify, jurl, jurlstify-links

#set page(width: 10cm, height: auto, margin: 1cm)
#set par(justify: true, leading: 0.85em)
#set text(font: ("Times New Roman", "Songti SC"), size: 10.5pt, lang: "zh")

= jurlstify 示例

#let long = "https://example.com/very/long/path/to/some/resource?query=value&more=stuff#fragment"

== 1. 原生 `link` — 两端对齐会产生大块空白或溢出

观察下面这段文字的排版：这是一段用来制造两端对齐压力的铺垫文字 #link(long) 以及紧随其后的文字。

== 2. `jurl` — 在恰当位置换行

观察下面这段文字的排版：这是一段用来制造两端对齐压力的铺垫文字 #jurl(long) 以及紧随其后的文字。

== 3. `jurlstify` 纯字符串版本

#jurlstify(long)

== 4. 启用 hyphens 选项（连字符处可断）

#jurlstify("https://my-very-long-sub-domain.example-site.org/path", hyphens: true)

== 5. 全局 show rule：让所有 `link` 自动使用 jurlstify

#show: jurlstify-links.with()

文本中出现 #link("https://example.com/automatically/handled/here") 时会自动插入断点。

== 6. 等宽字体（url.sty 风格）

#jurlstify(long, font: ("DejaVu Sans Mono", "Menlo", "Consolas", "Courier New"))

== 7. 自定义颜色/字号

#jurlstify(long, size: 9pt, fill: blue)
