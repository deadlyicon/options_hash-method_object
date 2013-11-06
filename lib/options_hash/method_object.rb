require 'options_hash'

class OptionsHash::MethodObject

  VERSION = '0.1.0'

  def self.inherited(subclass)
    subclass.send :extend,  ClassMethods
    subclass.send :include, InstanceMethods
    subclass
  end

  module ClassMethods
    def call options={}
      new(options).call
    end

    def to_proc
      method(:call).to_proc
    end

    def options
      @options ||= Class.new(superclass.respond_to?(:options) ?
        superclass.options : OptionsHash)
    end

    def required *keys, &block
      options.required *keys, &block
    end

    def optional *keys, &block
      options.optional *keys, &block
    end
  end

  module InstanceMethods
    def initialize options={}
      @options = self.class.options.parse(options)
    end
    attr_reader :options

    def method_missing method, *args, &block
      return options[method] if options.keys.include?(method)
      raise NoMethodError, "undefined method `#{method}'", caller(1)
    end

    def given? key
      options.given? key
    end
  end

end
