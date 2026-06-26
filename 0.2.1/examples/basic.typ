#import "../lib.typ": jurlstify, jurl, jurlstify-links

#set page(width: 8cm, height: auto, margin: 1cm)
#set par(justify: true, leading: 0.85em)
#set text(font: ("Times New Roman", "Songti SC"), size: 10.5pt, lang: "zh")

= jurlstify 0.2.1 示例 — 全局 `show-hyphen`

// 0.2.1 起,show-hyphen 是【全局】开关:它决定【所有】断点(自然断点 + every)
// 换行时是否显示连字符,默认 false(与 url.sty 一致,裸断不显示)。
#let long = "https://example.com/very/long/path/to/some/resource?query=value&more=stuff"

== 1. 默认 `show-hyphen: false` —— 断点裸断,不显示连字符

与 url.sty 一致:在 `/ ? & :` 等处换行,行尾【没有】连字符:

#jurlstify(long)

== 2. `show-hyphen: true` —— 每个断点换行处都显示 “-”

注意:连自然断点(如 `/` 后)换行时也会出现连字符(行尾形如 `…resource/-`):

#jurlstify(long, show-hyphen: true)

== 3. 段落内对比

默认(无连字符):前导文字制造两端对齐压力 #jurl(long) 以及随后文字。

开启(处处连字符):前导文字制造两端对齐压力 #jurl(long, show-hyphen: true) 以及随后文字。

== 4. 与 `every` 组合 —— 长串无自然断点也能逐段断

// 尾段是一长串字母,没有任何自然断点字符。
#let runny = "https://example.com/averylongpathsegmentwithnobreakshere"

`every: 6, show-hyphen: true`(换行显示连字符):

#jurlstify(runny, every: 6, show-hyphen: true)

`every: 6, show-hyphen: false`(换行不显示连字符):

#jurlstify(runny, every: 6, show-hyphen: false)

== 5. 全局 show rule 透传 `show-hyphen`

#show: jurlstify-links.with(show-hyphen: true)

文本中出现 #link("https://example.com/auto/handled/here/with/hyphens") 时,所有断点换行处都显示连字符。
