require './lib/parser'
require 'json'

class App
  def self.parse(filename = 'Extensions,-Plugins,-Resources.md')
    result = Parser.parse("backbone.wiki/#{filename}")
    File.open("data/#{filename}.json", 'w') { |f| f.write(result.to_json) }
  end
end

App.parse
