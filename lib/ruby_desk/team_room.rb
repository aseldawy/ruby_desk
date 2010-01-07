module RubyDesk
  class TeamRoom
    class << self
      def get_teamrooms(connector)
        response = connector.prepare_and_invoke_api_call 'team/v1/teamrooms', {:api_token=>@api_token, :api_key=>@api_key}, :method=>:get, :format=>'json'
        # parses a JSON result returned from oDesk and extracts an array of TeamRooms out of it
        json = JSON.parse(response)
        team_rooms = []
        [json['teamrooms']['teamroom']].flatten.each do |teamroom|
          # Append this TeamRoom to array
          team_rooms << self.new(teamroom)
        end
        # return the resulting array
        team_rooms
      end
      
    end
    
    # Attribute readers for all attributes
    attr_reader :company_recno, :company_name, :name, :id, :recno, :teamroom_api
    
    # Create a new TeamRoom from a hash similar to the one in ActiveRecord::Base.
    # The given hash maps each attribute name to its value
    def initialize(params={})
      params.each do |k, v|
        self.instance_variable_set("@#{k}", v)
      end
    end
    
    def snapshot(connector, online='now')
      response = connector.prepare_and_invoke_api_call "team/v1/teamrooms/#{self.id}", {:api_token=>@api_token, :api_key=>@api_key, :online=>online}, :method=>:get, :format=>'json'
      json = JSON.parse(response)
      RubyDesk::Snapshot.new(json['teamroom']['snapshot'])
    end
    
  end
end