require 'parslet'

class WikiParser < Parslet::Parser

  root :categories

  rule(:categories) { category.repeat.as(:categories) }

  rule(:category) { title.as(:title) >> newline >> seperator >> entries }

  rule(:newline) { match['\\n'] }

  rule(:line) { match['^\\n'].repeat }

  rule(:title) { str('Dependencies') || str('') }

  rule(:seperator) { str('-').repeat(4) >> newline.repeat }

  rule(:entries) { entry.repeat.as(:entries) }

  rule(:entry) { str('### ') >> entry_title >> newline >> entry_desc }

  rule(:entry_title) { line.as(:name) }

  rule(:entry_desc) { match['[^#]'].repeat.as(:desc) }
end
