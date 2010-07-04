class RubyDesk::OdeskEntity
  @@complex_attributes = {}
  
  class << self
    # Defines a new attribute or multiple attributes to this class.
    # Allowed options:
    #   * class: The class used to initialize this attribute
    #   * sub_element: Indicates this is an array. Name of the key used to initialize this attribute.
    #
    # Here are some examples of how to use this method
    # class Project
    #   # Defines a new attribute called 'name'.
    #   # This is generally used for defining simple attributes such as String or integer
    #   attribute :name
    #
    #   # Defines two attributes called 'description' and 'priority'.
    #   attributes :description, :priority
    #   # The same effect can be accomplished by calling
    #   attribute :description
    #   attribute :priority
    #
    #   # Defines an attribute called 'manager' of class User
    #   # This class is used to initialize this attribute as we will see later
    #   attribute :manager, :class=>User
    #
    #   # Defines an attribute called 'tasks' which is an array of type Task
    #   attribute :tasks, :class=>Task, :sub_element=>"tasks"
    # end
    #
    # Initialization
    # ==============
    # The above class Project can be initialized like this
    # # An instance of class Project all attributes set to nil
    # Project.new
    #
    # # Initialize simple attributes with the given values
    # Project.new :name=>"GitHub project", :description=>"Sample project on git hub"
    #
    # # Initialize complex attribute
    # # This will initialize manager with: User.new(:name=>"Ahmed", :birthday=>Date.parse("3/3/1983"))
    # Project.new :manager=>{:name=>"Ahmed", :birthday=>Date.parse("3/3/1983")}
    #
    # # Initializes 'tasks' attribute with [Task.new(:name=>"task1", Task.new(:name=>"task2", :priority=>3}]
    # Project.new :tasks=>[{:name=>"task1"}, {:name=>"task2", :priority=>3}]
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


  # Creates a new object of this class
  # Initial values of attributes is passed as a paramter
  #   * params: A hash used to initialize this object.
  #     The key is the name of the attribute to initialize.
  #     The value is used as the initial value for this attribute.
  #     If the attribute is defined a class in creation,
  #     the value is used as an initialization parameter with this class.
  #     If the attribute is marked as "sub_element" in creation,
  #     the value is assumed to be an array.
  #     Each entry in the array is used as an initialization parameter to create a new element.
  #     If the value is not an array, it is used to create an array of single element.
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
          # This attribute is a single complex attribute
          self.instance_variable_set("@#{k}", attribute_options[:class].new(v))
        end
      else
        self.instance_variable_set("@#{k}", v)
      end
    end
  end
end