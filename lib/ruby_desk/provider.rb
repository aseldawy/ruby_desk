class RubyDesk::Provider
  class << self
    def all_categories
      text = <<-CATEGORIES
            Web Development
              * Web Design
              * Web Programming
              * Ecommerce
              * UI Design
              * Website QA
              * Website Project Management
              * Other - Web Development
          Software Development
              * Desktop Applications
              * Game Development
              * Scripts & Utilities
              * Software Plug-ins
              * Mobile Apps
              * Application Interface Design
              * Software Project Management
              * Software QA
              * VOIP
              * Other - Software Development
          Networking & Information Systems
              * Network Administration
              * DBA - Database Administration
              * Server Administration
              * ERP / CRM Implementation
              * Other - Networking & Information Systems
          Writing & Translation
              * Technical Writing
              * Website Content
              * Blog & Article Writing
              * Copywriting
              * Translation
              * Creative Writing
              * Other - Writing & Translation
          Administrative Support
              * Data Entry
              * Personal Assistant
              * Web Research
              * Email Response Handling
              * Transcription
              * Other - Administrative Support
          Design & Multimedia
              * Graphic Design
              * Logo Design
              * Illustration
              * Print Design
              * 3D Modeling & CAD
              * Audio Production
              * Video Production
              * Voice Talent
              * Animation
              * Presentations
              * Engineering & Technical Design
              * Other - Design & Multimedia
          Customer Service
              * Customer Service & Support
              * Technical support
              * Phone Support
              * Order Processing
              * Other - Customer Service
          Sales & Marketing
              * Advertising
              * Email Marketing
              * SEO - Search Engine Optimization
              * SEM - Search Engine Marketing
              * SMM - Social Media Marketing
              * PR - Public Relations
              * Telemarketing & Telesales
              * Business Plans & Marketing Strategy
              * Market Research & Surveys
              * Sales & Lead Generation
              * Other - Sales & Marketing
          Business Services
              * Accounting
              * Bookkeeping
              * HR / Payroll
              * Financial Services & Planning
              * Payment Processing
              * Legal
              * Project Management
              * Business Consulting
              * Recruiting
              * Statistical Analysis
              * Other - Business Services
            CATEGORIES
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
    
    # Implements search with the given criteria
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
      response = connector.prepare_and_invoke_api_call 'team/v1/teamrooms', {:api_token=>@api_token, :api_key=>@api_key}, :method=>:get, :format=>'json'
      # parses a JSON result returned from oDesk and extracts an array of TeamRooms out of it
      json = JSON.parse(response)
      providers = []
      [json['providers']['provider']].flatten.each do |provider|
        providers << self.new(provider)
      end
    end
  end
  # Save categories in a constant
  AllCategories = all_categories

  attr_reader :dev_recno, :affiliated, :ui_profile_title, :ag_adj_score,
      :dev_short_name, :dev_profile_title, :dev_tot_hours, :dev_agency_ref,
      :dev_tot_feedback, :adj_score, :ag_logo, :dev_ac_agencies, :dev_ic,
      :profile_access, :dev_recent_rank_percentile, :dev_scores, :ag_recent_hours,
      :dev_tot_feedback_recent, :dev_adj_score, :dev_portrait, :dev_country,
      :company_logo, :group_recno, :ciphertext, :dev_tot_tests, :skills,
      :dev_rank_percentile, :dev_last_activity, :dev_country_tz,
      :ag_adj_score_recent, :tot_portfolio_items, :dev_test_passed_count,
      :dev_num_assignments_feedback_for_prov, :dev_bill_rate, :agency_ciphertext,
      :avg_category_score, :charge_rate_hourly, :dev_member_since, :record_id,
      :ag_total_hours, :dev_full_name, :dev_blurb, :dev_recent_hours,
      :dev_adj_score_recent, :dev_total_hours, :availability_vs_total, :contact_name
  def initialize(params={})
    params.each do |k, v|
      case k.to_s
      when 'skills' then
        if v['skill']
          @skills = []
          [v['skill']].flatten.each do |skill|
            @skills << RubyDesk::Skill.new(skill)
          end
        end
      when 'dev_scores' then
        if v['dev_score']
          @dev_scores = []
          [v['dev_score']].flatten.each do |dev_score|
            @dev_scores << RubyDesk::DeveloperSkill.new(dev_score)
          end
        end
      when 'dev_ac_agencies' then
        if v['dev_ac_agency']
          @dev_ac_agencies = []
          [v['dev_ac_agency']].flatten.each do |dev_ac_agency|
            @dev_ac_agencies << RubyDesk::Agency.new(dev_ac_agency)
          end
        end
      else
        self.instance_variable_set("@#{k}", v)
      end
    end
  end
end