# A provider in oDesk.
# <p>There is a TON&nbsp;of info returned here and the best way to see what this actually means is to try pulling data from a few providers and match up the fields, most of the response fields are human readable. Here is some aditional info that should help decipher this response:</p>
# 
# <p>&nbsp;</p>
# <ul>
# <li>&lt;dev_userid&gt;scoopwilson&lt;/dev_userid&gt; The odesk users id of the provider</li>
# <li>&lt;dev_rank_percentile&gt;82&lt;/dev_rank_percentile&gt; The providers rank overall on oDesk</li>
# <li>&lt;dev_usr_score&gt;4.9681818181818&lt;/dev_usr_score&gt; The providers feedback score</li>
# 
# <li>&lt;dev_profile_access&gt;public&lt;/dev_profile_access&gt; The status of the providers profile (public or private)</li>
# <li>&lt;skill&gt; The Skill tag describes a skill that the provider has listed in their profile</li>
# <li>&lt;tsexam&gt; tsexam describes a test that the provider has taken and made public.</li>
# <li>&lt;dev_score&gt; dev_score describes feedback that the provider has received after a job has been completed (or just closed)</li>
# 
# <li>&lt;dev_recent_rank_percentile&gt;80&lt;/dev_recent_rank_percentile&gt; The providers rank on oDesk using data from the last 90 days.</li>
# <li>&lt;dev_active_interviews&gt;0&lt;/dev_active_interviews&gt; How many active interviews the provider is engaged in now.</li>
# <li>&lt;dev_total_hours&gt;2526.1666666667&lt;/dev_total_hours&gt; The providers total hours worked on oDesk.</li>
# 
# <li>&lt;experience&gt; Describes the providers experience as listed in their profile under the Experience section</li>
# <li>&lt;assignment&gt; Describes past assignements that are publicly viewable.</li>
#
# Here's a full list of all attributes available:
# * affiliated
# * ag_active_assignments
# * ag_adj_score
# * ag_adj_score_recent
# * ag_billed_assignments
# * ag_city
# * ag_cny_recno
# * ag_country
# * ag_country_tz
# * ag_description
# * ag_hours_lastdays
# * ag_last_date_worked
# * ag_logo
# * ag_manager_blurb
# * ag_manager_name
# * ag_member_since
# * ag_name
# * ag_portrait
# * ag_rank_percentile
# * ag_recent_hours
# * ag_summary
# * ag_teamid
# * ag_teamid_rollup
# * ag_tot_feedback
# * ag_total_developers
# * ag_total_hours
# * agency_ciphertext
# * assignments
# * assignments_count
# * candidacies
# * certification
# * ciphertext
# * competencies
# * dev_ac_agencies
# * dev_active_interviews
# * dev_adj_score
# * dev_adj_score_recent
# * dev_agency_ciphertext
# * dev_agency_ref
# * dev_availability
# * dev_bill_rate
# * dev_billed_assignments
# * dev_billed_assignments_recent
# * dev_blurb
# * dev_blurb_short
# * dev_category
# * dev_city
# * dev_country
# * dev_cur_assignments
# * dev_eng_skill
# * dev_est_availability
# * dev_expose_full_name
# * dev_full_name
# * dev_groups
# * dev_ic
# * dev_is_affiliated
# * dev_is_ready
# * dev_last_activity
# * dev_last_worked
# * dev_location
# * dev_member_since
# * dev_pay_agency_rate
# * dev_pay_rate
# * dev_portfolio_items_count
# * dev_portrait
# * dev_profile_title
# * dev_rank_percentile
# * dev_recent_hours
# * dev_recent_rank_percentile
# * dev_recno
# * dev_region
# * dev_scores
# * dev_short_name
# * dev_test_passed_count
# * dev_timezone
# * dev_tot_feedback
# * dev_tot_feedback_recent
# * dev_total_assignments
# * dev_total_hours
# * dev_total_hours_rounded
# * dev_ui_profile_access
# * dev_usr_score
# * dev_year_exp
# * education
# * experiences
# * favorited
# * iinitialize
# * is_odesk_ready
# * job_categories
# * oth_experiences
# * permalink
# * portfolio_items
# * profile_title_full
# * provider_profile_api
# * response_time
# * search_affiliate_providers_url
# * skills
# * trends
# * tsexams
# * tsexams_count
# * version
class RubyDesk::Provider < RubyDesk::OdeskEntity

  attributes :affiliated, :ag_name, :ag_description, :dev_adj_score_recent,
    :dev_is_affiliated, :profile_title_full, :dev_total_hours_rounded,
    :favorited, :ag_member_since, :ag_tot_feedback, :ag_recent_hours,
    :dev_last_worked, :ciphertext, :dev_pay_rate, :dev_agency_ref,
    :competencies, :dev_usr_score, :dev_eng_skill, :dev_ic, :dev_bill_rate,
    :dev_tot_feedback_recent, :ag_rank_percentile,
    :dev_agency_ciphertext, :ag_total_developers, :ag_hours_lastdays,
    :dev_blurb, :agency_ciphertext, :dev_total_assignments, :tsexams,
    :dev_short_name, :dev_active_interviews, :dev_full_name, :dev_country,
    :dev_expose_full_name, :dev_city, :provider_profile_api, :ag_manager_blurb,
    :job_categories, :dev_year_exp, :dev_billed_assignments, :dev_portrait,
    :experiences, :ag_total_hours, :candidacies, :dev_last_activity,
    :dev_billed_assignments_recent, :dev_rank_percentile, :assignments, :dev_region,
    :search_affiliate_providers_url, :ag_billed_assignments, :ag_teamid_rollup,
    :dev_member_since, :dev_availability, :dev_profile_title, :dev_category,
    :assignments_count, :dev_total_hours, :dev_portfolio_items_count,
    :dev_recno, :certification, :ag_teamid, :education, :dev_cur_assignments,
    :version, :oth_experiences, :dev_recent_rank_percentile, :is_odesk_ready,
    :response_time, :ag_cny_recno, :ag_country, :ag_portrait, :dev_is_ready,
    :dev_adj_score, :dev_groups, :dev_blurb_short, :ag_last_date_worked,
    :ag_adj_score_recent, :dev_ui_profile_access, :dev_pay_agency_rate, :trends,
    :dev_location, :dev_est_availability, :tsexams_count, :permalink, :ag_logo,
    :ag_adj_score, :dev_recent_hours, :dev_timezone, :ag_country_tz, :ag_city,
    :dev_test_passed_count, :dev_tot_feedback, :ag_summary, :ag_manager_name,
    :ag_active_assignments, :portfolio_items

  attribute :skills, :class=>RubyDesk::Skill, :sub_element=>'skill'
  attribute :dev_scores, :class=>RubyDesk::DeveloperSkill, :sub_element=>'dev_score'
  attribute :dev_ac_agencies, :class=>RubyDesk::Agency, :sub_element=>'dev_ac_agency'
  attribute :competencies, :class=>RubyDesk::Competency, :sub_element=>'competency'
  attribute :tsexams, :class=>RubyDesk::Exam, :sub_element=>'tsexam'
  attribute :job_categories, :class=>RubyDesk::JobCategory, :sub_element=>'job_category'
  attribute :experiences, :class=>RubyDesk::Experience, :sub_element=>'experience'
  attribute :candidacies, :class=>RubyDesk::Candidacy, :sub_element=>'candidacy'
  attribute :assignments, :class=>RubyDesk::Assignment, :sub_element=>'assignments'
  attribute :certification, :class=>RubyDesk::Certificate, :sub_element=>'certificate'
  attribute :education, :class=>RubyDesk::Institution, :sub_element=>'institution'
  attribute :oth_experiences, :class=>RubyDesk::OtherExperience, :sub_element=>'oth_experience'
  attribute :trends, :class=>RubyDesk::Trend, :sub_element=>'trend'
  attribute :portfolio_items, :class=>RubyDesk::PortfolioItem, :sub_element=>'portfolio_item'

  class << self
    # Returns all categories defined in oDesk.
    # These categories are retrieved from a static text file and not updated from the web.
    # Return value is a hash.
    # Each key is a name of a root category.
    # Value is an array of subcategories.
    def all_categories
      text = File.read(File.join(File.dirname(__FILE__), "..", "categories"))
      lines = text.split(/[\r\n]+/).map{|line| line.strip}
      categories = {}
      subcategories = nil
      lines.each do |line|
        if line[0] == ?*
          subcategories << line[2..-1]
        else
          categories[line] = (subcategories = [])
        end
      end
      return categories
    end

    # Implements search with the given criteria.
    # For basic search, pass a string as the second parameter
    # For advanced search, pass a string according to the following parameters
    #* q - ProfileData (ProfileData)
    #      * Profile data is any text that appears in a provider's profile. For example if q = 'odesk' the search would return any user's with the word odesk in their profile.
    #* c1 - JobCategory (First Level Job Category)
    #      * This is the first level of job categories, there are a static number of catergories to select from and only one can be submitted at a time.
    #* c2 - second_category (Second Category)
    #      * Each level one category has a list of subcategories, again only on can be listed at a time and for a full list of what these are see our complete list of categories.
    #* fb - adjusted_score (the providers adjusted score) This searches for providers who have an adjusted feedback score equal or greater (up to 5) than the number passed in this parameter (decimals are ok).
    #      * For example fb=4.5 will return providers who have a combined feedback score of 4.5 or greater.
    #* hrs - ui_total_hours (Total hours) This searches for providers who have a total number of hours equal or greater to the number passed in this parameter.
    #      * ir(has worked within the last 6 months) This boolean parameter is used in combination with the total hours worked parameter, and searches providers who have worked within the last six months.
    #            + Yes or No are the only valid searches. Omiting this will default to 'No' = not searching recent workers.
    #* min - hourly_charge_rate_min (The provider's minimum rate they have charged in the past)
    #      * Exludes providers with a public rate less than this amount.
    #* max - hourly_charge_rate_max (The provider's maximum rate they have charged in the past)
    #          o Exludes provides with a public rate greater than this amount.
    #    * loc - country_region (Country Region)
    #          o Limit your searches to a specific country region:
    #                + Australasia
    #                + East Asia
    #                + Eastern Europe
    #                + Misc
    #                + North America
    #                + South Asia
    #                + Western Europe
    #    * pt - provider_type (Provider type, indipendent or affiliate)
    #          o Limit your search to indipendent or affiliate providers.
    #    * last - last_provider_activity (Date last active)
    #          o Limit your search to providers who were active after the date passed in this parameter. Dates should be formated like: 07-13-2009
    #    * test - cmp_ref (specify a test taken)
    #          o Limit your search to providers who have passed a specific test (based on the test id), one test can be passed at a time. See the complete list of tests here.
    #    * port - total_portfolio_items (the number of portfolio items)
    #          o Limit your search to providers who have at least this many portfolio items.
    #    * rdy - is_ready (are they odesk ready)
    #          o Only return oDesk ready providers.
    #    * eng - ui_english (English skill rating)
    #          o Limit your results to providers who have at least the rating passed in the parameter.
    #                + Only the following english levels are available (no decimals): [1,2,3,4,5]
    #    * ag - Agency Ref (Agency name)
    #          o Limit your search to a specific agency.
    #    * to - titles_only (Titles Search)
    #          o Search the provider profile title text only.
    #    * g - group (group members)
    #          o Limit your search to a specific group. See our list of available groups here.
    #    * Page(offset;count)
    #    * sort($field_name1;$field_name2;..$field_nameN;AD...A)
    #
    #Notes on Pagination
    #    * If $page is ommited, 0;SEARCH_PROVIDER_DEFAULT_PAGE_SIZE is assumed
    #    * $count < SEARCH_PROVIDER_MAX_PAGE_SIZE
    #
    #Notes on Sorting
    #    * Listing all fields on which to sort separated by a semi-colon with last value in the list a "direction vector" (A(Ascending) or D(Descending)).
    #* If the number of fields is bigger/smaller than number of chars in the "directions vector" then the application will return a "400 Bad request" error.
    #* sort using the field_names
    def search(connector, options={})
      if options.respond_to? :to_str
        return search(connector, :q=>options.to_str)
      end
      json = connector.prepare_and_invoke_api_call(
        'profiles/v1/search/providers', :method=>:get,
        :auth=>false, :sign=>false, :params=>options)

      providers = []
      if json['providers']['provider']
        [json['providers']['provider']].flatten.each do |provider|
          providers << self.new(provider)
        end
      end
      return providers
    end

    # Retrieves the profile with the given user
    # * connector: The RubyDesk::Connector that is connected to oDesk
    # * id: The id of the user to retrieve his profile
    # * options: A hash of options
    #   * brief: set this to true to retrieve only a brief profile of the given user
    def get_profile(connector, id, options={})
      brief = options.delete :brief || false
      json = connector.prepare_and_invoke_api_call(
        "profiles/v1/providers/#{id}" + (brief ? "/brief" : ""), :method=>:get)
      return self.new(json['profile'])
    end
  end
  # Save categories in a constant
  AllCategories = all_categories

  def iinitialize(params={})
    params.each do |k, v|
      case k.to_s
      when "portfolio_items" then
      else
        self.instance_variable_set("@#{k}", v)
      end
    end
  end
end

