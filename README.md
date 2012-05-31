# Harvester

Parse complex HTML structures using powerful DSL.

## Synopsis

```
require 'pp'
require 'harvester'

article = <<-EOF
<html>
<head><title>Test article title</title></head>
<body>
  <h1>Test article header</h1>
  <article>
    <section>
      <h2>Header 1</h2>
      <p>Paragraph 1</p>
    </section>
    <section>
      <h2>Header 2</h2>
      <p>Paragraph 2</p>
    </section>
    <div id="author-block">
      <span class="name">John Doe</span>
      <a href="/authors/1">profile</a>
      <a href="http://twitter.com/johndoe">twitter</a>
    </div>
  </article>
</body>
EOF

harvester = Harvester.new do |h|
  h.element :title, :selectors => "title"
  h.element :header, :selectors => "h1"
  h.children :sections, :selectors => "article > section" do |s|
    s.element :header, :selectors => "h2"
    s.element :body, :selectors => "p"
  end
  h.child :author, :selectors => "div#author-block" do |a|
    a.element :name, :selectors => "span.name"
    a.link :profile, :selectors => "a", :link_regex => %r{^/authors/\d+$}
    a.link :twitter, :selectors => "a", :link_regex => %r{twitter.com}
  end
end


pp harvester.parse(article)
# {:title=>"Test article title",
#  :header=>"Test article header",
#  :sections=>
#   [{:header=>"Header 1", :body=>"Paragraph 1"},
#    {:header=>"Header 2", :body=>"Paragraph 2"}],
#  :author=>
#   {:name=>"John Doe",
#    :profile=>"/authors/1",
#    :twitter=>"http://twitter.com/johndoe"}}
```

See other examples in `examples` folder.

## Dependencies

* Ruby (currently 1.9)
* Nokogiri
* Addressable
* Chronic18n if you want to use date parsing
    * Use [my fork](https://github.com/markiz/chronic18n) if you desire to use russian locale for dates

## Feedback

Use github issues or contact me directly by mail (markizko+harvester@gmail.com)

## License

Harvester is released into public domain (http://unlicense.org/UNLICENSE)
