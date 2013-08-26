require 'minitest/autorun'
require_relative '../lib/plugins_parser'

class PluginsParserTest < Minitest::Test
  def setup
    file = File.open(File.join(Dir.pwd, 'backbone.wiki/Extensions,-Plugins,-Resources.md'))
    @parser = PluginsParser.new(file.read)
    @results = @parser.parse
  end

  def test_amount_of_extensions
    assert_equal 152, @results.size
  end

  def test_first_extension
    extension = {
      title: 'Underscore.js',
      category: 'Dependencies',
      description: "Backbone's only hard dependency. [[http://underscorejs.org]]" }

    assert_equal extension, @results.first
  end

  def test_first_extension_in_the_model_category
    assert_equal 'Backbone.DocumentModel', @results[7][:title]
    assert_equal 'Model', @results[7][:category]
  end

  def test_categories_count
    assert_equal 14, @parser.categories.count
  end
end
