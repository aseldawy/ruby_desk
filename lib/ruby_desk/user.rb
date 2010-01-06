module RubyDesk
  class User
    
    attr_accessor :messenger_id, :timezone, :uid, :timezone_offset, :last_name,
        :mail, :creation_time, :first_name
    def initialize(params)
      params.each do |k, v|
        self.instance_variable_set("@#{k}", v)
      end
    end
  end
end