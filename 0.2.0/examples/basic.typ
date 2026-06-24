#import "../lib.typ": jurlstify, jurl, jurlstify-links

#set page(width: 9cm, height: auto, margin: 1cm)
#set par(justify: true, leading: 0.85em)
#set text(font: ("Times New Roman", "Songti SC"), size: 10.5pt, lang: "zh")

= jurlstify 0.2.0 示例 — `show-hyphen`

// 尾段是一长串字母，没有 / ? & . 等任何断点字符 —— 自然断点在此无能为力。
#let runny = "https://example.com/averylongpathsegmentwithnobreakshereforthedemo"

== 1. 长串无断点 —— 无处可断，溢出右边距

没有断点字符的长串只能整段留在一行：

#jurlstify(runny)

== 2. `every: 1` —— 默认 `show-hyphen: true`（断行处显示 “-”）

每 8 个字符给一个断点，实际换行的那一处显示为软连字符 “-”：

#jurlstify(runny, every: 1)

== 3. `every: 1, show-hyphen: false` —— 断行处不显示连字符

相同断点位置，但换行处什么都不显示，避免出现可能被误读成 URL 真实字符的 “-”：

#jurlstify(runny, every: 1, show-hyphen: false)

== 4. 段落内对比：`show-hyphen: true`

前导文字制造两端对齐压力 #jurl(runny, every: 1) 以及紧随其后的文字。

== 5. 段落内对比：`show-hyphen: false`

前导文字制造两端对齐压力 #jurl(runny, every: 1, show-hyphen: false) 以及紧随其后的文字。

== 6. 全局 show rule 透传 `show-hyphen`

#show: jurlstify-links.with(every: 1, show-hyphen: false)

文本中出现 #link("https://example.com/anotherlongunbrokensegmentwithoutbreaks") 时，自动按每 1 字符断点，且换行处不显示连字符。
