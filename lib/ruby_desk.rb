require 'rubygems'
require 'json'
require 'logger'

# The top level module that holds all constants and classes related to Ruby Desk
module RubyDesk
  # General error with calls fo RubyDesk.
  # Use this to rescue from all errors related to RubyDesk
  class Error < RuntimeError; end;
  
  # Indicates an error with authorization such as wrong username/password combination
  class UnauthorizedError < Error; end;
  
  # Indicates that a page requested from oDesk is not found (404 result returned).
  # The reason depends on the request, for example it might be a spelling mistake in team room name 
  class PageNotFound < Error; end;
  
  # Internal server error.
  class ServerError < Error; end;
  
  # Bad request error (400). Caused by using an expired token.
  class BadRequest < Error; end;

  class << self
    # Used to log all debug and error messages of RubyDesk
    attr_accessor :logger
  end

  self.logger = Logger.new(STDERR)
  self.logger.sev_threshold = Logger::FATAL
end

# This first file is required by other files
require File.join(File.dirname(__FILE__), 'ruby_desk', 'odesk_entity')

module RubyDesk
  # Defines a simple class with some attributes for simplicity and to decrease number of files
  # Class is defined as a subclass of RubyDesk::OdeskEntity with the attributed in arguments.
  def self.define_simple_class(*attribute_names)
    Class.new RubyDesk::OdeskEntity do
      attributes *attribute_names
    end
  end

  Competency = define_simple_class(:cmp_url, :cmp_when, :cmp_provider, :cmp_ref,
    :cmp_percentile, :cmp_name, :cmp_recno, :cmp_score, :cmp_id)
  Skill = define_simple_class(:skl_level_num, :skl_ref, :skl_name,
    :skl_last_used, :skl_recno, :skl_level, :skl_comment, :skl_year_exp)
  Agency = define_simple_class(:ag_adj_score, :ag_logo, :ag_name,
    :ag_recent_hours, :ag_tot_feedback, :ag_recno, :ciphertext,
    :ag_adj_score_recent, :ag_total_hours)
  Exam = define_simple_class(:ts_name, :ts_rank, :ts_duration, :ts_when,
    :ts_provider, :ts_score, :ts_percentile, :ts_curl_name, :ts_ref,
    :ts_is_certification, :ts_id, :ts_pass, :ts_seo_link)
  JobCategory = define_simple_class(:seo_link, :second_level, :first_level)
  Experience = define_simple_class(:exp_comment, :exp_from, :exp_recno,
    :exp_title, :exp_company, :exp_to)
  Candidacy = define_simple_class(:permalink, :dev_recno, :opening_ciphertext,
    :rel_requested_assignment, :created_type, :developer_ciphertext,
    :ciphertext, :create_date, :profile_seo_link, :Agencyref,
    :agency_ciphertext, :op_title, :record_id, :job_profile_access)
  Assignment = define_simple_class(:as_type, :as_blended_cost_rate,
    :as_total_hours, :as_to, :as_from, :as_client, :as_opening_access,
    :as_agency_name, :as_rate, :as_blended_charge_rate, :as_amount,
    :as_total_charge, :as_opening_recno, :as_description, :as_opening_title,
    :as_status, :as_job_type, :as_ciphertext_opening_recno, :as_total_cost)
  Certificate = define_simple_class(:cmp_url, :cmp_when, :cmp_provider,
    :cmp_ref, :cmp_percentile, :cmp_name, :cmp_recno, :cmp_score, :cmp_id)
  Institution = define_simple_class(:ed_area, :ed_school, :ed_degree, :ed_to,
    :ed_recno, :ed_comment, :ed_from)
  OtherExperience = define_simple_class(:exp_recno, :exp_description,
    :exp_subject)
  Trend = define_simple_class(:trend_word, :trend_url, :trend_recno,
    :trend_skill)
  PortfolioItem = define_simple_class(:pi_recno, :pi_description,
    :pi_attachment, :pi_completed, :pi_thumbnail, :pi_title, :pi_category,
    :pi_url, :pi_image)
  User = define_simple_class(:messenger_id, :timezone, :uid, :timezone_offset,
    :last_name, :mail, :creation_time, :first_name)
  DeveloperSkill = define_simple_class(:order, :description,
    :avg_category_score_recent, :avg_category_score, :label)
end

Dir.glob(File.join(File.dirname(__FILE__), 'ruby_desk', '*.rb')).each do |file|
  require file
end

