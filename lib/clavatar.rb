require 'ostruct'

# Clavatar module
module Clavatar
  def self.cast(hash, klass, example)
    accessible_attr = []
    example.instance_variables.each do |attr|
      attr = attr.to_s.sub('@', '').to_sym
      if example.respond_to? ("#{attr}=")
        accessible_attr << attr
      end
    end

    args = {}
    construct_params = example.method(:initialize).parameters
    construct_params.each do |param|
      arg_required = param.first
      arg_name = param.last

      if arg_required == :keyreq
        raise "parameter #{arg_name} is mandatory but missing in #{hash}" unless hash.key? arg_name
      elsif arg_required == :keyrest
        args.merge! hash
        break
      end

      args[arg_name] = hash[arg_name]
    end

    instance = klass.new args
    accessible_attr.each do |attr|
      instance.send("#{attr}=", hash[attr])
    end
    return instance
  end
end
