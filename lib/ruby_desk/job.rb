# A job opening with the following attributes
# * amount
# * buyer
# * candidates_total
# * candidates_total_active
# * company_ref
# * date_posted
# * engagement_related
# * engagement_weeks
# * hours_per_week
# * interviewees_total_active
# * job_category_level_one
# * job_category_level_two
# * job_type
# * odr_meta
# * offers_total
# * offers_total_open
# * op_active
# * op_attached_doc
# * op_avg_bid_active
# * op_avg_bid_active_interviewees
# * op_avg_bid_all
# * op_avg_bid_interviewees
# * op_avg_hourly_rate_active
# * op_avg_hourly_rate_active_interviewees
# * op_avg_hourly_rate_all
# * op_avg_hourly_rate_interviewees
# * op_buyer_ace
# * op_cancel_ts
# * op_comm_status
# * op_country
# * op_ctime
# * op_date_created
# * op_desc_digest
# * op_description
# * op_end_date
# * op_eng_type
# * op_engagement
# * op_est_duration
# * op_high_bid_active
# * op_high_bid_active_interviewees
# * op_high_bid_all
# * op_high_bid_interviewees
# * op_high_hourly_rate_active
# * op_high_hourly_rate_active_interviewees
# * op_high_hourly_rate_all
# * op_high_hourly_rate_interviewees
# * op_is_validnonprivate
# * op_is_viewable
# * op_job_category_seo
# * op_job_expiration
# * op_last_buyer_activity
# * op_low_bid_active
# * op_low_bid_active_interviewees
# * op_low_bid_all
# * op_low_hourly_rate_active
# * op_low_hourly_rate_active_interviewees
# * op_low_hourly_rate_all
# * op_low_hourly_rate_interviewees
# * op_lowhigh_bid_interviewees
# * op_num_of_pending_invites
# * op_pref_english_skill
# * op_pref_fb_score
# * op_pref_group_recno
# * op_pref_has_portfolio
# * op_pref_hourly_rate_max
# * op_pref_hourly_rate_min
# * op_pref_hours_per_week
# * op_pref_location
# * op_pref_odesk_hours
# * op_pref_test
# * op_pref_test_name
# * op_private_rating_active
# * op_reason
# * op_recno
# * op_required_skills
# * op_skill
# * op_start_date
# * op_status_for_search
# * op_time_created
# * op_time_posted
# * op_title
# * op_tot_cand_client
# * op_tot_cand_prof
# * op_tot_new_cond
# * op_tot_rej
# * op_ui_profile_access
# * profile_key
# * search_status
# * timezone
# * ui_job_profile_access
# * version
class RubyDesk::Job < RubyDesk::OdeskEntity
  attributes :amount, :buyer, :candidates_total, :candidates_total_active,
      :company_ref, :date_posted, :engagement_related, :engagement_weeks,
      :hours_per_week, :interviewees_total_active, :job_category_level_one,
      :job_category_level_two, :job_type, :odr_meta, :offers_total,
      :offers_total_open, :op_active, :op_attached_doc, :op_avg_bid_active,
      :op_avg_bid_active_interviewees, :op_avg_bid_all,
      :op_avg_bid_interviewees, :op_avg_hourly_rate_active,
      :op_avg_hourly_rate_active_interviewees, :op_avg_hourly_rate_all,
      :op_avg_hourly_rate_interviewees, :op_buyer_ace, :op_cancel_ts,
      :op_comm_status, :op_country, :op_ctime, :op_date_created,
      :op_desc_digest, :op_description, :op_end_date, :op_eng_type,
      :op_engagement, :op_est_duration, :op_high_bid_active,
      :op_high_bid_active_interviewees, :op_high_bid_all,
      :op_high_bid_interviewees, :op_high_hourly_rate_active,
      :op_high_hourly_rate_active_interviewees, :op_high_hourly_rate_all,
      :op_high_hourly_rate_interviewees, :op_is_validnonprivate,
      :op_is_viewable, :op_job_category_seo, :op_job_expiration,
      :op_last_buyer_activity, :op_low_bid_active,
      :op_low_bid_active_interviewees, :op_low_bid_all,
      :op_low_hourly_rate_active, :op_low_hourly_rate_active_interviewees,
      :op_low_hourly_rate_all, :op_low_hourly_rate_interviewees,
      :op_lowhigh_bid_interviewees, :op_num_of_pending_invites,
      :op_pref_english_skill, :op_pref_fb_score, :op_pref_group_recno,
      :op_pref_has_portfolio, :op_pref_hourly_rate_max,
      :op_pref_hourly_rate_min, :op_pref_hours_per_week, :op_pref_location,
      :op_pref_odesk_hours, :op_pref_test, :op_pref_test_name,
      :op_private_rating_active, :op_reason, :op_recno, :op_required_skills,
      :op_skill, :op_start_date, :op_status_for_search, :op_time_created,
      :op_time_posted, :op_title, :op_tot_cand_client, :op_tot_cand_prof,
      :op_tot_new_cond, :op_tot_rej, :op_ui_profile_access, :profile_key,
      :search_status, :timezone, :ui_job_profile_access, :version
 
  # <h2>Details on Search Parameters</h2>
  # <p>&nbsp;</p>
  # <ul>
  # <li><b>q -</b> OpeningData<b>&nbsp;</b>(Opening Data)
  # 
  # <ul>
  # <li>Search the text of the job description</li>
  # </ul>
  # </li>
  # <li><b>c1 -</b> JobCategory<b>&nbsp;(</b>Level One Job Category)
  # <ul>
  # <li>Limit your search to a specific <a href="/all-categories">category</a></li>
  # </ul>
  # </li>
  # <li><b>c2 -</b> second_category<b>&nbsp;</b>(Second Level Job Category)
  # 
  # <ul>
  # <li>Limit your search to a specific <a href="/all-categories">sub-category</a>
  # <ul>
  # <li>You must use a level one category in order to use a second level category.</li>
  # </ul>
  # </li>
  # </ul>
  # </li>
  # <li><b>fb -</b> adjusted_score<b>&nbsp;</b>(Adjusted Score)
  # <ul>
  # <li>Limit your search to buyers with at least a score of the number passed in this parameter.
  # 
  # <ul>
  # <li>This number must be <strong>5</strong> or less</li>
  # </ul>
  # </li>
  # </ul>
  # </li>
  # <li><b>min -</b> min_budget<b>&nbsp;</b>(Min Budget)
  # <ul>
  # <li>Limit your search to jobs with a budget greater than this number.</li>
  # 
  # </ul>
  # </li>
  # <li><b>max -</b> max_budget<b>&nbsp;</b>(Max Budget)
  # <ul>
  # <li>Limit your search to jobs with a budget less than this number.</li>
  # </ul>
  # </li>
  # <li><b>t -</b> JobType<b>&nbsp;</b>(Job Type)
  # <ul>
  # <li>oDesk has both hourly jobs and fixed prices jobs. This parameter allows you to limit your search to one or the other.
  # 
  # <ul>
  # <li>Hourly Jobs = '<strong>Hourly</strong>'</li>
  # <li>Fixed Priced Jobs = '<strong>Fixed</strong>'</li>
  # </ul>
  # </li>
  # <li><strong>wl -</strong> hours_per_week(Hours per Week)
  # <ul>
  # <li>This parameter can only be used when searching Hourly jobs. These numbers are a little arbitrary, so follow the following parameters in order to successfully use this parameter:
  # <ul>
  # 
  # <li>
  # <p>As Needed &lt; 10 Hours/Week = '<strong>0</strong>'</p>
  # </li>
  # <li>
  # <p>Part Time: 10-30 hrs/week = '<strong>20</strong>'</p>
  # </li>
  # <li>Full Time: 30+ hrs/week = '<strong>40</strong>'</li>
  # 
  # </ul>
  # </li>
  # </ul>
  # </li>
  # <li><b>dur -</b> engagement_duration<b>&nbsp;</b>(Engagement Duration)
  # <ul>
  # <li>This parameter can only be used when searching Hourly jobs. These numbers are a little arbitrary, so follow the following parameters in order to successfully use this parameter:
  # <ul>
  # <li>Ongoing / More than 6 months = '<strong>1</strong>'</li>
  # <li>3 to 6 months = '<strong>2</strong>'</li>
  # 
  # <li>1 to 3 months = '<strong>3</strong>'</li>
  # <li>Less than 1 month = '<strong>4</strong>'</li>
  # <li>Less than 1 week = '<strong>5</strong>'</li>
  # </ul>
  # </li>
  # </ul>
  # </li>
  # </ul>
  # 
  # </li>
  # <li><b>dp -</b> Date_Posted<b>&nbsp;</b><strong>(</strong>Date Posted)
  # <ul>
  # <li>Search jobs posted after this date.
  # <ul>
  # <li>Format for date: <em>07-22-2009</em></li>
  # </ul>
  # </li>
  # </ul>
  # </li>
  # <li><b>st -</b> status_for_search<b>&nbsp;</b>(Status for Search)
  # 
  # <ul>
  # <li>Search Canceled jobs, In Progress Jobs and Completed Jobs: By default this default to Open Jobs
  # <ul>
  # <li>Open Jobs = '<strong>Open</strong>'</li>
  # <li>Jobs in Progress = '<strong>In Progress</strong>'</li>
  # <li>Completed Jobs = '<strong>Completed</strong>'</li>
  # <li>Canceled Jobs = '<strong>Cancelled</strong>'</li>
  # 
  # </ul>
  # </li>
  # </ul>
  # </li>
  # <li><strong>tba</strong> - total_billed_assignments<b>&nbsp;</b>(Total Billed Assignments)
  # <ul>
  # <li>Limit your search to buyers who completed at least this number of paid assignments
  # <ul>
  # <li>For example tb=5 searches buyers who have at least 5 billed assignments</li>
  # </ul>
  # </li>
  # </ul>
  # </li>
  # 
  # <li><strong>gr</strong> -&nbsp;PrefGroup(Preferred Group)providers
  # <ul>
  # <li>Limits your search to buyers in a particular group</li>
  # </ul>
  # </li>
  # <li><strong>to</strong> - titles_only<b>&nbsp;</b>(titles only)
  # <ul>
  # <li>Limits your search to job titles only. (you should be able to combine this search)</li>
  def self.search(connector, query_options={})
    if query_options.respond_to? :to_str
      return search(connector, :q=>query_options.to_str)
    end
    json = connector.prepare_and_invoke_api_call(
        'profiles/v1/search/jobs', :method=>:get,
        :auth=>false, :sign=>false, :params=>query_options)
    jobs = []
    [json['jobs']['job']].flatten.each do |job|
      jobs << self.new(job)
    end
    return jobs
  end
end