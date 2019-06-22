source 'https://rubygems.org'

gem 'daemons'

group :develop do
  gem 'sequel-rake'
end

group :db do
  gem 'sequel'
  gem 'sqlite3'
end

group :monitor do
  gem "rpio-sysfs", path: "../rpio-sysfs"
  # gem "rpio-bcm2835", path: "../rpio-bcm2835"
  gem "rpio", path: "../rpio"
end

group :serve do
  gem 'roda'
end

group :report do
  # excel, csv, dumb db
end
