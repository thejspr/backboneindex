class Parser

  def self.parse(filename)
    new(File.read(filename)).parse
  end

  def initialize(content)
    @content = content
  end

  def parse
    categories.map do |category|
      { title: category, rows: rows(category) }
    end
  end

  private

  def rows(category)
    category_rows(category).map do |section|
      lines = section.split("\n\n").map(&:strip)
      next if lines.empty?
      { title: lines.first, description: lines[1..-1].join(' ') }
    end.compact
  end

  def category_rows(category)
    sections.fetch(categories.index(category)).split('### ')
  end

  def categories
    @categories ||= @content.scan(/(\w+)\n-{4,}/).flatten
  end

  def sections
    @sections ||= @content.split(/\w+\n-{4,}/)[1..-1]
  end
end
