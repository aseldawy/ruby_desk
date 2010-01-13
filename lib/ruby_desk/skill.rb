class RubyDesk::Skill
  attr_reader :skl_level_num, :skl_ref, :skl_name, :skl_last_used,
      :skl_recno, :skl_level, :skl_comment, :skl_year_exp
  
  def initialize(params={})
    params.each do |k, v|
      self.instance_variable_set("@#{k}", v)
    end
  end
end