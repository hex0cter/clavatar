require 'ostruct'

# Clavatar module
module Clavatar
  def self.cast(hash, klass, example)
    name_space = klass.respond_to?(:parent) ? klass.parent : Object
    klass_name = "#{klass.name.split('::').last}Avatar"
    if name_space.const_defined? klass_name
      klass = name_space.const_get klass_name
    else
      klass = name_space.const_set klass_name, Class.new(klass)
    end

    args = {}
    accessible_attr = []
    example.instance_variables.each do |attr|
      attr = attr.to_s.sub('@', '').to_sym
      if example.respond_to? ("#{attr}=")
        accessible_attr << attr
      else
        args[attr] = hash[attr]
      end
    end

    instance =  klass.new args.merge(hash)
    accessible_attr.each do |attr|
      instance.send("#{attr}=", hash[attr])
    end
    return instance
  end
end
