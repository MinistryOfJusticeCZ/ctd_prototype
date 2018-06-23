module DocumentGenerator
  class Variable

    attr_accessor :name, :type, :options

    def initialize(name, type, **options)
      @name, @type, @options = name, type, options
    end

  end


  class VariablesCoder < ActiveRecord::Coders::JSON
    class << self
      def load(json_string)
        json = super
        json.collect{|v| Variable.new(v)} if json.is_a?(Array)
      end

      def dump(obj)
        unless obj.is_a?(Array)
          raise ::ActiveRecord::SerializationTypeMismatch,
            "Attribute was supposed to be a Array, but was a #{obj.class}. -- #{obj.inspect}"
        end
        json = obj.collect do |variable|
          unless variable.is_a?(Variable)
            raise ::ActiveRecord::SerializationTypeMismatch,
              "Attribute was supposed to be a #{Variable}, but was a #{obj.class}. -- #{obj.inspect}"
          end
          {'name' => variable.name, 'type' => variable.type, 'options' => variable.options}
        end
        super(json)
      end
    end
  end
end
