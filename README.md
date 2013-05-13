Foosgab
=======

A webapp to track foosball scores. Critical to maintaining team morale.

Requirements:
* Rails 4.0.0.rc1
* MongoDB
* Ruby (gemfile says 2.0.0 but it'll probably run on 1.9)

Setup: (not actually tested)
* brew install mongodb
* git clone github://github.com/paulfri/foosgab && cd foosgab
* bundle install
* bundle exec rake rails:update:bin (if necessary)
* rails s

Tests:
* brew install phantomjs (for feature specs)
* rake

Todo:
* admin confirmation for non-whitelisted users to get normal authorizations
* better stats (offense/defense breakdowns)
* basic caching

Pull requests welcome!