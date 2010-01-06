module RubyDesk
  class Snapshot
    attr_reader :status, :time, :billing_status, :report_url, :screenshot_img, :activity,
      :online_presence, :user, :screenshot_url, :mouse_events_count, :company_id,
      :timezone, :uid, :keyboard_events_count, :last_worked_status, :last_worked,
      :memo, :active_window_title, :portrait_img, :report24_img, :computer_name,
      :screenshot_img_thmb, :online_presence_img, :user_id, :role, :client_version,
      :snapshot_api, :workdiary_api
    def initialize(params={})
      params.each do |k, v|
        if k.to_s == 'user'
          @user = RubyDesk::User.new(v)
        else
          self.instance_variable_set("@#{k}", v)
        end
      end
    end
  end
end