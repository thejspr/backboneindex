# BackboneIndex parser

This small script builds the json for BackboneIndex by parsing the markdown from
the official Backbone wiki. The Backbone wiki is accessed via a Git submodule.

### Setting up

In this directory run:

`git submodule add --force git://github.com/documentcloud/backbone.wiki.git backbone.wiki`

Install dependencies via `bundle install`.

### Running the tests

`ruby test/plugins_parser_test.rb`

Note: Tests can currently break when the Backbone wiki is updated.
