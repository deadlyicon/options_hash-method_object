require 'options_hash'

class OptionsHash::MethodObject

  VERSION = '0.0.1'

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

    def options_reader *keys
      keys.each do |key|
        options.option?(key) or raise KeyError, "#{key} is not an option", caller(2)
        define_method(key){ self.options[key] }
      end
    end

    def option_readers!
      options_reader *options.keys
    end
  end

  module InstanceMethods
    def initialize options={}
      @options = self.class.options.parse(options)
    end
    attr_reader :options
  end

end
