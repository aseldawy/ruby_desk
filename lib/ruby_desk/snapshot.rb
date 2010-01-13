class RubyDesk::Snapshot < RubyDesk::OdeskEntity
  attribute :status, :time, :billing_status, :report_url, :screenshot_img, :activity,
    :online_presence, :screenshot_url, :mouse_events_count, :company_id,
    :timezone, :uid, :keyboard_events_count, :last_worked_status, :last_worked,
    :memo, :active_window_title, :portrait_img, :report24_img, :computer_name,
    :screenshot_img_thmb, :online_presence_img, :user_id, :role, :client_version,
    :snapshot_api, :workdiary_api

  attribute :user, :class=>RubyDesk::User

end