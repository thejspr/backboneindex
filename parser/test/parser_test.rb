require 'minitest/autorun'
require_relative '../lib/parser'

class ParserTest < Minitest::Test
  def setup
    @results = Parser.parse('./parser/backbone.wiki/Extensions,-Plugins,-Resources.md')
  end

  def test_amount_of_extensions
    assert_equal 136, @results.size
  end

  def test_first_extension
    extension = {
      title: 'Underscore.js',
      category: 'Dependencies',
      description: "Backbone's only hard dependency. [[http://underscorejs.org]]" }

    assert_equal extension, @results.first
  end

  def test_first_extension_in_the_model_category
    assert_equal 'Backbone.ModelAttrs', @results[6][:title]
    assert_equal 'Model', @results[6][:category]
  end
end