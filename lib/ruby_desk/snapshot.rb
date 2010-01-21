class RubyDesk::Snapshot < RubyDesk::OdeskEntity
  attribute :status, :time, :billing_status, :report_url, :screenshot_img, :activity,
    :online_presence, :screenshot_url, :mouse_events_count, :company_id,
    :timezone, :uid, :keyboard_events_count, :last_worked_status, :last_worked,
    :memo, :active_window_title, :portrait_img, :report24_img, :computer_name,
    :screenshot_img_thmb, :online_presence_img, :user_id, :role, :client_version,
    :snapshot_api, :workdiary_api

  attribute :user, :class=>RubyDesk::User

  def self.work_diary(connector, company_id, user_id, date = nil, timezone = "mine")
    json = connector.prepare_and_invoke_api_call(
      "team/v1/workdiaries/#{company_id}/#{user_id}" + (date ? "/"+date : ""),
        :params=>{:timezone=>timezone}, :method=>:get)

    return nil unless json['snapshots']['snapshot']
    [json['snapshots']['snapshot']].flatten.map do |snapshot|
      self.new(snapshot)
    end
  end

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

