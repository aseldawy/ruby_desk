# <h2>Response Details</h2>
# <ul>
# <li>&lt;snapshot&gt;
# <ul>
# <li>Snapshot detail container</li>
# </ul>
# </li>
# <li>&lt;status&gt;PRIVATE&lt;/status&gt;
# 
# <ul>
# <li>Status of the snapshot
# <ul>
# <li>LOGIN</li>
# <li>NORMAL</li>
# <li>PRIVATE</li>
# <li>EXIT</li>
# </ul>
# </li>
# </ul>
# </li>
# <li>&lt;time&gt;1229521500&lt;/time&gt;
# 
# <ul>
# <li>The GMT&nbsp;that the snapshot was taken</li>
# </ul>
# </li>
# <li>&lt;billing_status&gt;non-billed.disconnected&lt;/billing_status&gt;
# <ul>
# <li>A snapshot's billing status
# <ul>
# <li>non-billed.disconnected</li>
# <li>billed.disconnected</li>
# 
# <li>billed.connected</li>
# </ul>
# </li>
# </ul>
# </li>
# <li>&lt;activity&gt;0&lt;/activity&gt;</li>
# <li>&lt;online_presence&gt;&lt;/online_presence&gt;</li>
# <li>&lt;user&gt;
# <ul>
# <li>The general user details associated with the current use</li>
# 
# </ul>
# </li>
# <li>&lt;mouse_events_count/&gt;
# <ul>
# <li>The number of mouse events associated with this snapshot</li>
# </ul>
# </li>
# <li>&lt;company_id&gt;agencyone&lt;/company_id&gt;
# <ul>
# <li>Company ID&nbsp;associated with this snapshot</li>
# 
# </ul>
# </li>
# <li>&lt;timezone&gt;America/Los_Angeles&lt;/timezone&gt;
# <ul>
# <li>User's time zone</li>
# </ul>
# </li>
# <li>&lt;uid/&gt;
# <ul>
# <li>The user id</li>
# </ul>
# 
# </li>
# <li>&lt;keyboard_events_count/&gt;
# <ul>
# <li>Number of keyboard events counted for this snapshot</li>
# </ul>
# </li>
# <li>&lt;last_worked&gt;
# <ul>
# <li>The timestamp last worked
# <ul>
# <li>Format:&nbsp;[<em>1240637782</em>]</li>
# 
# </ul>
# </li>
# </ul>
# </li>
# <li>&lt;memo/&gt;
# <ul>
# <li>Memo associated with the current time stamp</li>
# </ul>
# </li>
# <li>&lt;active_window_title/&gt;
# <ul>
# <li>The title of the active window when the snapshot was taken</li>
# </ul>
# 
# </li>
# <li>&lt;report24_img&gt;
# <ul>
# <li>URL to a graph that describes a users activitly over a 24hr period</li>
# </ul>
# </li>
# <li>&lt;computer_name/&gt;
# <ul>
# <li>The name of the computer where the snapshot was taken</li>
# </ul>
# </li>
# <li>&lt;online_presence_img&gt;
# 
# <ul>
# <li>URL&nbsp;for the default online user activity</li>
# </ul>
# </li>
# <li>&lt;user_id&gt;
# <ul>
# <li>User id associated with the current snapshot</li>
# </ul>
# </li>
# <li>&lt;client_version/&gt;
# <ul>
# <li>The oDesk Time Tracker version used to take the snapshot</li>
# 
# </ul>
# </li>
# <li>&lt;teamroom_api&gt;/api/team/v1/teamrooms/agencyone.xml&lt;/teamroom_api&gt;&nbsp;</li>
# <li>&lt;workdiary_api&gt;/api/team/v1/workdiaries/agencyone/scoopwilson/20081217.xml&lt;/workdiary_api&gt;</li>
class RubyDesk::Snapshot < RubyDesk::OdeskEntity
  attribute :status, :time, :billing_status, :report_url, :screenshot_img, :activity,
    :online_presence, :screenshot_url, :mouse_events_count, :company_id,
    :timezone, :uid, :keyboard_events_count, :last_worked_status, :last_worked,
    :memo, :active_window_title, :portrait_img, :report24_img, :computer_name,
    :screenshot_img_thmb, :online_presence_img, :user_id, :role, :client_version,
    :snapshot_api, :workdiary_api

  attribute :user, :class=>RubyDesk::User

  # Retrieves work diary as an array of snapshots.
  # The Work Diary method retrieves all snapshots from a single user account within a single day.
  # Keep in mind that a day is dependent on server time and not the day in which the query is made.
  # Make sure to test with various locations before you're done.
  def self.work_diary(connector, company_id, user_id, date = nil, timezone = "mine")
    json = connector.prepare_and_invoke_api_call(
      "team/v1/workdiaries/#{company_id}/#{user_id}" + (date ? "/"+date : ""),
        :params=>{:timezone=>timezone}, :method=>:get)

    return nil unless json['snapshots']['snapshot']
    [json['snapshots']['snapshot']].flatten.map do |snapshot|
      self.new(snapshot)
    end
  end

  # Retrieves details of one snapshot
  def self.snapshot_details(connector, company_id, user_id, timestamp = nil)
    timestamp_param = case timestamp
      when String then timestamp
      when Date, Time then timestamp.strftime("%Y%m%d")
      when Range then [timestamp.first, timestamp.last].map{|t|t.strftime("%Y%m%d")}.join(",")
      when Array then timestamp.map{|t| t.strftime("%Y%m%d")}.join(";")
    end
    # Invoke API call
    json = connector.prepare_and_invoke_api_call(
      "team/v1/workdiaries/#{company_id}/#{user_id}" +
      (timestamp_param ? "/#{timestamp_param}" : ""), :method=>:get)

    # Generate ruby objects for each snapshot
    [json['snapshot']].flatten.map do |snapshot|
      self.new(snapshot)
    end
  end

end

