class Meter < Sequel::Model
  one_to_many :indices
  plugin :serialization, :json, :buffer

  def push value
    value = multiplier * value
    add_index(value: totalizer ? index.value + value : value)
  end

  def index
    indices_dataset.order(:created_at).last
  end
end

class Index < Sequel::Model
  many_to_one :meter
end

class Devices < Sequel::Model
  plugin :serialization, :json, :create_options

  def underlying_object
    @underlying_object ||= class_name.split('::').inject(Object) {|o,c| o.const_get c}.new(create_options)
  end

# TODO:code creation part.
  def underlying_object= object
    class_name= object.class.name
    create_options= {}
  end

  def method_missing(m, *args, &block)
    underlying_object.send m, *args, &block
  end
end

require 'buffer'
