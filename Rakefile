require 'sequel/rake'
require 'yaml'


Sequel::Rake.configure do
  set :connection, YAML.load(File.read('db/database.yml'))
  set :migrations, "#{__dir__}/db/migrations"
  set :namespace, "db"
end

namespace Sequel::Rake.get(:namespace) do
  task :seed do
    DB = connection
    require "#{__dir__}/db/seed"
  end
end




# task default: %w[spec]
#
# task :spec do
#   spec "spec.rb"
# end
#
# task :run do
#
# end

Sequel::Rake.load!
