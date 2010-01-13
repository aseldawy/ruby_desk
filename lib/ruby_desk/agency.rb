class RubyDesk::Agency
  attr_reader :ag_adj_score, :ag_logo, :ag_name, :ag_recent_hours, :ag_tot_feedback,
      :ag_recno, :ciphertext, :ag_adj_score_recent, :ag_total_hours

  def initialize(params={})
    params.each do |k, v|
      self.instance_variable_set("@#{k}", v)
    end
  end
end