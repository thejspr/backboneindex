require './lib/parser'
require 'json'

class App
  def self.build_json(filename = 'Extensions,-Plugins,-Resources.md')
    result = Parser.parse("backbone.wiki/#{filename}")
    File.open("data/#{filename}.json", 'w') { |f| f.write(result.to_json) }
  end
end
