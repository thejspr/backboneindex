require './lib/parser'
require 'minitest/autorun'

class ParserTest < Minitest::Test
  def setup
    @result = Parser.parse('backbone.wiki/Extensions,-Plugins,-Resources.md')
  end

  def test_amount_of_categories
    assert_equal @result.size, 13
  end

  def test_amount_of_rows_in_dependencies
    assert_equal @result.first.fetch(:rows).size, 6
  end

  def test_amount_of_rows_in_last_category
    assert_equal @result.last.fetch(:rows).size, 23
  end

  def test_entry_in_first_category
    assert_equal @result.first.fetch(:rows).first, {
      title: 'Underscore.js',
      description: "Backbone's only hard dependency. [[http://underscorejs.org]]"
    }
  end
end
