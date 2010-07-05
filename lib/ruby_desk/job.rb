# A job opening with the following attributes
# * adj_score
# * amount
# * ciphertext
# * country
# * create_date
# * engagement_weeks
# * hours_per_week
# * job_category_level_one
# * job_category_level_two
# * job_type
# * op_adjusted_score
# * op_amount
# * op_buyer_ace
# * op_city
# * op_company_name
# * op_contract_date
# * op_country
# * op_date_created
# * op_description
# * op_eng_duration
# * op_hrs_per_week
# * op_job
# * op_job_category_
# * op_job_type
# * op_num_of_pending_invites
# * op_pref_english_skill
# * op_pref_fb_score
# * op_pref_hourly_rate
# * op_pref_odesk_hours
# * op_pref_test
# * op_pref_test_name
# * op_recno
# * op_required_skills
# * op_status_for_search
# * op_title
# * op_tot_asgs
# * op_tot_cand
# * op_tot_cand_client
# * op_tot_cand_prof
# * op_tot_feedback
# * op_tot_fp_asgs
# * op_tot_fp_charge
# * op_tot_hours
# * op_tot_hr_asgs
# * op_tot_hr_charge
# * op_tot_intv
# * op_tot_jobs_filled
# * op_tot_jobs_posted
# * record_id
# * search_status
# * timezone
# * total_billed_assignments
# * total_charge
# * total_hours
class RubyDesk::Job < RubyDesk::OdeskEntity
  attributes :op_tot_hours, :job_category_level_two, :op_company_name,
      :op_tot_cand_client, :record_id, :op_amount, :total_hours,
      :op_date_created, :op_city, :country, :op_tot_intv, :op_tot_feedback,
      :search_status, :op_job, :op_hrs_per_week, :op_job_category_, :op_country,
      :amount, :op_tot_cand_prof, :op_tot_asgs, :total_charge,
      :op_status_for_search, :op_tot_cand, :op_buyer_ace,
      :job_category_level_one, :timezone, :op_pref_test, :adj_score,
      :op_num_of_pending_invites, :op_tot_fp_asgs, :op_required_skills,
      :ciphertext, :op_title, :op_pref_fb_score, :op_tot_hr_asgs, :create_date,
      :op_tot_jobs_filled, :op_pref_hourly_rate, :op_tot_jobs_posted,
      :job_type, :hours_per_week, :op_job_type, :op_pref_test_name,
      :op_pref_english_skill, :op_pref_odesk_hours, :op_tot_fp_charge,
      :op_contract_date, :op_tot_hr_charge, :engagement_weeks,
      :op_adjusted_score, :op_recno, :total_billed_assignments,
      :op_description, :op_eng_duration
   
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