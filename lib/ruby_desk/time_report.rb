require 'date'

# An interface for accessing time reports from oDesk.
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
  # * :select
  #   Here is the fields available for select
  # <table style="border-color: rgb(136, 136, 136); border-width: 1px;" border="1" cellspacing="0"><tbody><tr><td style="text-align: center; background-color: rgb(217, 234, 211); width: 168px; height: 29px;"><strong>&nbsp;Field Name<br></strong></td>
  # <td style="text-align: center; background-color: rgb(217, 234, 211); width: 526px; height: 29px;"><strong>&nbsp;Description</strong></td>
  # <td style="background-color: rgb(217, 234, 211); width: 70px; height: 29px; text-align: center;"><strong>&nbsp;GDS Type</strong></td>
  # <td style="text-align: center; background-color: rgb(217, 234, 211); width: 108px; height: 29px;"><strong>Aggregation</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 20px;">&nbsp;worked_on</td>
  # 
  # <td style="text-align: left; width: 526px; height: 20px;">The date and and time in when exactly the work was performed by the provider</td>
  # <td style="width: 70px; height: 20px; text-align: center;">date</td>
  # <td style="text-align: center; width: 108px; height: 20px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;week_worked_on</td>
  # <td style="width: 526px; height: 19px;">The date of the Monday in which the worked_on occurs.</td>
  # <td style="width: 70px; height: 19px; text-align: center;">date</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;month_worked_on</td>
  # <td style="width: 526px; height: 19px;">The number of the month within the date that appears in the worked_on field</td>
  # <td style="width: 70px; height: 19px; text-align: center;">date</td>
  # 
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;year_worked_on</td>
  # <td style="width: 526px; height: 19px;">The year of the date that appears in the Start Date field</td>
  # <td style="width: 70px; height: 19px; text-align: center;">date</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;provider_id</td>
  # <td style="width: 526px; height: 19px;">The id of Provider</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;provider_name</td>
  # 
  # <td style="width: 526px; height: 19px;">The name of Provider</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;team_id</td>
  # <td style="width: 526px; height: 19px;">The team id of team where time was billed</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;team_name</td>
  # <td style="width: 526px; height: 19px;">The name of team where time was billed</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # 
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;assignment_team_id</td>
  # <td style="width: 526px; height: 19px;">The team id of hiring team in assignment</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="width: 168px; height: 19px;">&nbsp;assignment_name</td>
  # <td style="width: 526px; height: 19px;">The opening title of assignment</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;agency_id</td>
  # 
  # <td style="width: 526px; height: 19px;">The team id of Agency</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;agency_name</td>
  # <td style="width: 526px; height: 19px;">The name of Agency</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;company_id</td>
  # <td style="width: 526px; height: 19px;">The team id of rollup assignment_team_id</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # 
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="width: 168px; height: 19px;">&nbsp;agency_company_id</td>
  # <td style="width: 526px; height: 19px;">The agency id of rollup agency_id</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;task</td>
  # <td style="width: 526px; height: 19px;">The tasks in which the Provider worked on.</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;memo</td>
  # 
  # <td style="width: 526px; height: 19px;">The memos logged by the Provider during work</td>
  # <td style="width: 70px; height: 19px; text-align: center;">string</td>
  # <td style="text-align: center; width: 108px; height: 19px;">&nbsp;</td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;hours</td>
  # <td style="width: 526px; height: 19px;">The total hours in which the Provider worked during the date of worked_on</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;charges</td>
  # <td style="width: 526px; height: 19px;">The total amount charged to Buyer</td>
  # 
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;earnings</td>
  # <td style="width: 526px; height: 19px;">The total amount earned by Provider</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;hours_online</td>
  # <td style="width: 526px; height: 19px;">The number of online hours in hours</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # 
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;charges_online</td>
  # <td style="width: 526px; height: 19px;">The charges of work performed online</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;earnings_online</td>
  # <td style="width: 526px; height: 19px;">The earnings of work performed online</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # 
  # <tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;hours_offline</td>
  # <td style="width: 526px; height: 19px;">The number of offline hours in hours</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;charges_offline</td>
  # <td style="width: 526px; height: 19px;">The charges of work performed offline</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr><tr><td style="text-align: left; width: 168px; height: 19px;">&nbsp;earnings_offline</td>
  # 
  # <td style="width: 526px; height: 19px;">The earnings of work performed offline</td>
  # <td style="width: 70px; height: 19px; text-align: center;">number</td>
  # <td style="text-align: center; width: 108px; height: 19px;"><strong>X</strong></td>
  # </tr></tbody></table>
  # * :conditions
  #   Here is the limited support for the <strong>where</strong> clause.
  #   <p>Fields</p>
  #   <div style="margin-left: 40px;">
  #   <table style="border-color: rgb(136, 136, 136); border-width: 1px; border-collapse: collapse;" border="1" cellspacing="0"><tbody><tr style="background-color: rgb(217, 234, 211);" align="center"><td style="width: 124px; height: 16px;"><strong>&nbsp;Name</strong></td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;company_id</td>
  # 
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;agency_id</td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;provider_id</td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;worked_on</td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;assignment_team_id</td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;provider_id</td>
  #   </tr><tr><td style="width: 124px; height: 16px;">&nbsp;task</td>
  #   </tr></tbody></table></div>
  #
  # <p>Multiple conditions can be joined by <strong>and</strong> operator. For a multiple values condition matching a specific field, they can be joined by <strong>or</strong> operator and enclosed by parentheses.&nbsp;</p>
  # 
  # <p>&nbsp;</p>
  # <p>The comparison operators are also limited by fields' data types.</p>
  # <p>&nbsp;</p>
  # <div style="margin-left: 40px;">
  # <div>
  # <table border="1" cellpadding="3" cellspacing="0"><tbody><tr><td style="text-align: center; background-color: rgb(217, 234, 211); width: 151px; height: 16px;"><strong>Field<br></strong></td>
  # <td style="text-align: center; background-color: rgb(217, 234, 211); width: 82px; height: 16px;"><strong>Data Type<br></strong></td>
  # <td style="text-align: center; background-color: rgb(217, 234, 211); width: 72px; height: 16px;"><strong>Operator<br></strong></td>
  # </tr><tr><td style="width: 151px; height: 17px;">company_id</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # 
  # </tr><tr><td style="width: 151px; height: 17px;">agency_id</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # </tr><tr><td style="width: 151px; height: 17px;">provider_id</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # </tr><tr><td style="width: 151px; height: 17px;">assignment_team_id</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # 
  # </tr><tr><td style="width: 151px; height: 17px;">provider_id</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # </tr><tr><td style="width: 151px; height: 17px;">task</td>
  # <td style="text-align: center; width: 82px; height: 17px;">Text</td>
  # <td style="text-align: center; width: 72px; height: 17px;">=</td>
  # </tr><tr><td style="width: 151px; height: 85px;">worked_on</td>
  # <td style="text-align: center; width: 82px; height: 85px;">Date</td>
  # <td style="text-align: center; width: 72px; height: 85px;">&gt;<br> &gt;=<br> =<br> &lt;=<br> &lt;</td>
  # 
  # </tr></tbody></table></div>
  # </div>
  # * :order
  #    We allow sorting on row values to all the fields specified in select  clause. 
  def self.find(connector, options={})
    options = DEFAULT_OPTIONS.merge(options)
    options[:conditions].each_pair do |k, v|
      if Array === v && v.size == 1
        options[:conditions][k] = v.first
      elsif Array === v && v.empty?
        options[:conditions].delete(k)
      end
    end
    call_url = "timereports/v1"
    # Adjust a URL that has as much information as we can
    if String === options[:conditions][:company_id]
      # Limit to one company in url (better looking)
      call_url << "/companies/#{options[:conditions].delete :company_id}"
    end
    if String === options[:conditions][:provider_id]
      call_url << "/providers/#{options[:conditions].delete :provider_id}"
    end
    if String === options[:conditions][:agency_id]
      # Limit to one agency in url (better looking)
      call_url << "/agencies/#{options[:conditions].delete :agency_id}"
    end
    if String === options[:conditions][:team_id]
      # Limit to one team in url (better looking)
      call_url << "/teams/#{options[:conditions].delete :team_id}"
    end

    call_url << "/hours" if options[:hours]

    gds_query = build_query(options)
    json = connector.prepare_and_invoke_api_call(call_url, :method=>:get,
      :base_url=>RubyDesk::Connector::ODESK_GDS_URL, :format=>nil,
      :params=>{:tq=>gds_query, :tqx=>"out:json"})

    raise RubyDesk::Error, json['errors'].inspect if json['status'] == "error"

    columns = [json['table']['cols']].flatten
    rows = [json['table']['rows']].flatten.map do |row_data|
      next if row_data.empty?
      row = {}
      [row_data['c']].flatten.each_with_index do |row_element, element_index|
        column = columns[element_index]
        row[column['label']] = str_to_value(row_element['v'], column['type'])
      end
      row
    end
    return rows.compact
  end

protected
  # Builds a query in Google Data Source Language using the given options.
  # Called internally by find
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

  # Converts an object to string based on its type
  def self.value_to_str(value)
    case value
      when String then "'#{value}'"
      when Date, Time then "'"+value.strftime("%Y-%m-%d")+"'"
      when Numeric then value.to_s
    end
  end

  # Converts a string representation in first parameter back to its original value based on the second parameter
  def self.str_to_value(string, type)
    case type
      when 'number' then string.to_f
      when 'date' then Date.strptime(string, "%Y%m%d")
      when 'string' then string
    end
  end


end

