class RubyDesk::DeveloperSkill
  attr_reader :order, :description, :avg_category_score_recent, :avg_category_score, :label
  
  def initialize(params={})
    params.each do |k, v|
      self.instance_variable_set("@#{k}", v)
    end
  end
end