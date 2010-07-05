require 'helper'
require 'date'

class TestRubyDesk < Test::Unit::TestCase

  def dummy_connector(result_filename)
    connector = RubyDesk::Connector.new('824d225a889aca186c55ac49a6b23957',
      '984aa36db13fff5c', 'fffff')
    connector.instance_variable_set '@result_filename', result_filename
    def connector.invoke_api_call(*args)
      File.read(File.join(File.dirname(__FILE__), @result_filename))
    end if result_filename
    return connector
  end

  def test_sign
    connector  = RubyDesk::Connector.new('824d225a889aca186c55ac49a6b23957',
      '984aa36db13fff5c')
    assert_equal 'dc30357f7c6b62aadf99e5313ac93365',
      connector.sign(:online=>'all', :tz=>'mine',
        :api_key=>'824d225a889aca186c55ac49a6b23957',
        :api_token=>'ffffffffffffffffffffffffffffffff')
  end

  def test_sign_escaped_params
    connector  = RubyDesk::Connector.new('824d225a889aca186c55ac49a6b23957',
      '984aa36db13fff5c')
    assert_equal 'dc30357f7c6b62aadf99e5313ac93365',
      connector.sign(:online=>'a%6C%6C', :tz=>'mine',
        :api_key=>'824d225a889aca186c55ac49a6b23957',
        :api_token=>'ffffffffffffffffffffffffffffffff')
  end

  def test_api_call
    connector  = RubyDesk::Connector.new('824d225a889aca186c55ac49a6b23957',
      '984aa36db13fff5c', 'fff')
    api_call = connector.prepare_api_call('auth/v1/keys/tokens',
      :params=>{:frob=>'342423', :api_key=>@api_key},
      :method=>:post, :format=>'json')
    assert api_call[:url].index('.json')
    assert api_call[:url].index('/api/auth/v1/keys/tokens')
    assert api_call[:params][:api_sig]
  end

  def test_gds_api_call
    connector  = RubyDesk::Connector.new('824d225a889aca186c55ac49a6b23957',
      '984aa36db13fff5c', 'ff')
    api_call = connector.prepare_api_call('timereports/v1/companies/1',
      :method=>:post, :base_url=>RubyDesk::Connector::ODESK_GDS_URL)
    assert api_call[:url].index('/gds/timereports/v1/companies/1')
    assert api_call[:params][:api_sig]
  end

  def test_provider_search
    connector = dummy_connector('providers.json')

    providers = RubyDesk::Provider.search(connector, 'rails')

    assert providers.is_a?(Array)
    assert_equal 20, providers.size
    assert_equal RubyDesk::Provider, providers.first.class
    assert_equal RubyDesk::Skill, providers.first.skills.first.class
  end

  def test_get_profile
    connector = dummy_connector('profile.json')

    profile = RubyDesk::Provider.get_profile(connector, 'aseldawy')

    assert_equal RubyDesk::Provider, profile.class
    assert_equal RubyDesk::Skill, profile.skills.first.class
    assert_equal RubyDesk::Competency, profile.competencies.first.class
  end

  def test_team_rooms
    connector = dummy_connector('teamrooms.json')

    teamrooms = RubyDesk::TeamRoom.get_teamrooms(connector)

    assert_equal 5, teamrooms.size
    assert_equal RubyDesk::TeamRoom, teamrooms.first.class
  end

  def test_workdiary
    connector = dummy_connector('workdiary.json')

    snapshots = RubyDesk::Snapshot.work_diary(connector, 'techunlimited',
      'aseldawy')
    assert_equal 14, snapshots.size
    assert_equal RubyDesk::Snapshot, snapshots.first.class
  end

  def test_jobs_search
    connector = dummy_connector('jobs.json')

    jobs = RubyDesk::Job.search(connector, "simple_query")
    assert_equal 20, jobs.size
    assert_equal RubyDesk::Job, jobs.first.class
  end
  def test_snapshot
    connector = dummy_connector('snapshot.json')

    snapshots = RubyDesk::Snapshot.snapshot_details(connector, 'techunlimited',
      'aseldawy', Time.now)
    assert_equal 1, snapshots.size
    assert_equal RubyDesk::Snapshot, snapshots.first.class
  end

  def test_query_builder
    test_data = [
      [{:select=>"worked_on", :conditions=>{:worked_on=>Time.mktime(2009, 10, 10)}},
        "SELECT worked_on WHERE (worked_on='2009-10-10')"],
      [{:select=>"worked_on, provider_id", :conditions=>{:provider_id=>[1,2,3]}},
        "SELECT worked_on, provider_id WHERE (provider_id=1 OR provider_id=2 OR provider_id=3)"],
      [{:select=>"worked_on", :conditions=>{:provider_id=>'aseldawy', :agency_id=>3}},
        ["SELECT worked_on WHERE (agency_id=3) AND (provider_id='aseldawy')",
        "SELECT worked_on WHERE (provider_id='aseldawy') AND (agency_id=3)"]],
      [{:select=>"worked_on", :conditions=>{:provider_id=>1..3}},
        "SELECT worked_on WHERE (provider_id>=1 AND provider_id<=3)"],
      [{:select=>"worked_on", :conditions=>{:provider_id=>1...3}},
        "SELECT worked_on WHERE (provider_id>=1 AND provider_id<3)"],
      [{:select=>["worked_on", "hours"]},
        "SELECT worked_on,hours"],
    ]
    test_data.each do |options, query|
      # I use include? because some queries have more than possible form
      assert query.include?(RubyDesk::TimeReport.build_query(options))
    end
  end

  def test_timreport
    connector = dummy_connector('timereport.json')

    timereport = RubyDesk::TimeReport.find(connector,
      :select=>"worked_on, sum(hours), provider_id")
    assert_equal 15, timereport.size
    assert_equal Hash, timereport.first.class
    assert_equal Date, timereport.first['worked_on'].class
    assert timereport.first['hours'].is_a?(Numeric)
  end

  def test_empty_timreport
    connector = dummy_connector('empty_timereport.json')

    timereport = RubyDesk::TimeReport.find(connector,
      :select=>"worked_on, sum(hours)")
    assert_equal 0, timereport.size
  end

  def test_timreport_error
    assert_raises RubyDesk::Error do
      connector = dummy_connector('timereport_error.json')
      timereport = RubyDesk::TimeReport.find(connector,
        :select=>"worked_on, sum(hours), provider_id")
    end
  end

end

