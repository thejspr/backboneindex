class PluginsParser
  def self.parse(filename)
    new(File.read(filename)).parse
  end

  def initialize(content)
    @content = content
  end

  def parse
    categories.map do |category|
      rows(category)
    end.flatten
  end

  def categories
    @categories ||= @content.scan(/(\w+)\n-{4,}/).flatten
  end

  private

  def rows(category)
    category_rows(category).map do |section|
      lines = section.split("\n").map(&:strip)
      next if lines.empty?
      { title: lines.first,
        category: category,
        description: lines[1..-1].join("\n\n").strip }
    end.compact
  end

  def category_rows(category)
    sections.fetch(categories.index(category)).split('### ')
  end

  def sections
    @sections ||= @content.split(/\w+\n-{4,}/)[1..-1]
  end
end
