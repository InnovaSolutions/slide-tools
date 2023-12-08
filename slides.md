---
# uncomment to see plantuml diagrams
#marp: false

marp: true
theme: gaia
_class: lead
backgroundColor: #fff
backgroundImage: url('./assets/innova-title.png')
style: @import url('https://unpkg.com/tailwindcss@^2/dist/utilities.min.css');
---

<!-- color: black -->

# Slides from Markdown

### In multiple formats: pdf, html, pptx

<br>
<br>

##### Your Name<br>Your Title

</div>

---

<style>
footer, section::after {
  font-size: 14px;
}
</style>
<!-- backgroundImage: url('./assets/background.png') -->
<!-- color: black -->
<!-- footer: April 20, 2023 -->
<!-- paginate: true -->

## Slide 1

- Point 1
- Point 2
- etc

---

## Slide with PlantUML Diagram

```plantuml
file ".net" as dotnetin
file "Java Example\nCode" as javaref
file "Prompt" as prompt
file "Generated\nJava" as javaout
rectangle "GPT Engineer" as gpteng
rectangle "Azure Open\nAI GPT-4" as gpt4
dotnetin -down-> gpteng
javaref -down-> gpteng
prompt -down-> gpteng
gpteng -right-> gpt4
gpteng -down-> javaout
javaout -up-> gpteng
```
