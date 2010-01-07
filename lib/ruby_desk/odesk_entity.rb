class RubyDesk::OdeskEntity
  @@complex_attributes = {}
  
  class << self
    def attribute(*att_names)
      options = nil
      if att_names.last.is_a?Hash
        options = att_names.delete_at -1
      end
      att_names.each do |att_name|
        attr_reader att_name
        @@complex_attributes[att_name.to_s] = options if options
      end
    end
    
    alias attributes attribute
  end

  
  def initialize(params={})
    params.each do |k, v|
      attribute_options = @@complex_attributes[k.to_s] || {}
      if attribute_options[:class]
        if attribute_options[:sub_element]
          # This attribute has many elements each of the given class
          if v[attribute_options[:sub_element]]
            # There is values for it
            # Initialize the value to an empty array
            values = []
            self.instance_variable_set("@#{k}", values)
            [v[attribute_options[:sub_element]]].flatten.each do |element|
              # Create an element of the correct class
              values << attribute_options[:class].new(element)
            end
          end
        else
          # This attribute is a single comple attribute
          self.instance_variable_set("@#{k}", attribute_options[:class].new(v))
        end
      else
        self.instance_variable_set("@#{k}", v)
      end
    end
  end
end