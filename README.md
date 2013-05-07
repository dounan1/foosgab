Foosgab
=======

A webapp to track foosball scores. Critical to maintaining team morale.

Requirements:
* Rails 4.0.0-beta1
* MongoDB
* Ruby (gemfile says 2.0.0 but it'll probably run on 1.9)

Setup: (not actually tested)
* brew install mongodb
* git clone github://github.com/paulfri/foosgab && cd foosgab
* bundle install
* bundle exec rake rails:update:bin (if necessary)
* rails s

Tests:
* brew install phantomjs
* rake

Todo:
* basic authentication
* basic caching for stats
* interesting features!

Pull requests welcome!