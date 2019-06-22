require 'yaml'
require 'json'
require 'sequel/plugins/serialization'

DB = Sequel.connect YAML.load(File.read(File.join(ROOT_PATH, 'db/database.yml')))
