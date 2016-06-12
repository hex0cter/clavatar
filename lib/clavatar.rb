require 'ostruct'

# Clavatar module
module Clavatar
  def self.cast(hash, klass, example)
    klass_name = "#{klass}Avatar"
    if Object.const_defined? klass_name
      klass = Object.const_get klass_name
    else
      klass = Object.const_set klass_name, Class.new(klass)
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

    instance =  klass.new args
    accessible_attr.each do |attr|
      instance.send("#{attr}=", hash[attr])
    end
    return instance
  end
end
