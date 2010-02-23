require 'uri'
require 'date'

class RubyDesk::TimeReport
  DEFAULT_OPTIONS = {:select => "worked_on, provider_id, sum(hours)",
    :conditions=>{} }

  # The time reports API uses the Google Visualization API's query language to
  # run detailed reports on a user's team, company, as well as provider
  # specific detail.
  # In order to use the reports API you need to understand the data model
  # accessible as well as the supported Google query language elements.
  # Please see the
  # <a href="http://developers.odesk.com/oDesk-Google-Data-Source-Language">
  # oDesk Google Data Source Language</a> page for a detailed description of
  # what's available.
  # For more details around how to construct data parameters see the
  # <a href="http://code.google.com/apis/visualization/documentation/querylanguage.html">
  # google documentation</a>.
  #
  # Allowed values for options are
  # :select
  # :conditions
  #   Here is the limited support for the where clause.
  #     Fields
  #      * Name
  #      * company_id
  #      * agency_id
  #      * provider_id
  #      * worked_on
  #      * assignment_team_id
  #      * provider_id
  #      * task
  # :order
  def self.find(connector, options={})
    options = DEFAULT_OPTIONS.merge(options)
    call_url = "timereports/v1"
    # Adjust a URL that has as much information as we can
    if String === options[:conditions][:company_id]
      # Limit to one company in url (better looking)
      call_url << "/companies/#{options[:conditions].delete :company_id}"

      if String === options[:conditions][:agency_id]
        # Limit to one agency in url (better looking)
        call_url << "/agencies/#{options[:conditions].delete :agency_id}"
      elsif String === options[:conditions][:team_id]
        # Limit to one team in url (better looking)
        call_url << "/teams/#{options[:conditions].delete :team_id}"
      end
    elsif String === options[:conditions][:provider_id]
      call_url << "/providers/#{options[:conditions].delete :provider_id}"
    end

    call_url << "/hours" if options[:hours]

    gds_query = build_query(options)
    json = connector.prepare_and_invoke_api_call(call_url, :method=>:get,
      :base_url=>RubyDesk::Connector::ODESK_GDS_URL, :format=>nil,
      :params=>{:tq=>URI.escape(gds_query," ,%&=./"), :tqx=>"out:json"})

    raise RubyDesk::Error, json['errors'].inspect if json['status'] == "error"

    columns = [json['table']['cols']].flatten
    rows = [json['table']['rows']].flatten.map do |row_data|
      row = {}
      [row_data['c']].flatten.each_with_index do |row_element, element_index|
        column = columns[element_index]
        row[column['label']] = str_to_value(row_element['v'], column['type'])
      end
      row
    end
    return rows
  end

  def self.build_query(options)
    gds_query = ""
    gds_query << "SELECT " << (options[:select].respond_to?(:join)?
      options[:select].join(",") : options[:select])
    if options[:conditions] && options[:conditions].any?
      gds_query << " WHERE "
      combined = options[:conditions].map do |field, condition|
        "(" +
        case condition
          when String, Numeric, Date, Time then
            "#{field}=#{value_to_str(condition)}"
          when Array then
            condition.map{|v| "#{field}=#{value_to_str(v)}"}.join(" OR ")
          when Range then
            "#{field}>=#{value_to_str(condition.first)} AND #{field}" +
              (condition.exclude_end? ? "<" : "<=") +
              value_to_str(condition.last)
          else raise "Invalid condition for field: #{field}"
        end +
        ")"
      end
      gds_query << combined.join(" AND ")
    end
    if options[:order]
      gds_query << " ORDER BY " << options[:order]
    end
    gds_query
  end

  def self.value_to_str(value)
    case value
      when String then value
      when Date, Time then "'"+value.strftime("%Y-%m-%d")+"'"
      when Numeric then value.to_s
    end
  end

  def self.str_to_value(string, type)
    case type
      when 'number' then string.to_f
      when 'date' then Date.strptime(string, "%Y%m%d")
      when 'string' then string
    end
  end


end

