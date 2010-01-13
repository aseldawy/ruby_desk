require 'helper'

class TestRubyDesk < Test::Unit::TestCase
  def test_provider_search
    connector = Object.new
    def connector.prepare_and_invoke_api_call(*args)
      File.read(File.join(File.dirname(__FILE__), 'providers.json'))
    end
    
    providers = RubyDesk::Provider.search(connector, 'rails')
    
    assert providers.is_a?(Array)
    assert_equal 20, providers.size
    assert_equal RubyDesk::Provider, providers.first.class
    assert_equal RubyDesk::Skill, providers.first.skills.first.class
  end

  def test_get_profile
    connector = Object.new
    def connector.prepare_and_invoke_api_call(*args)
      File.read(File.join(File.dirname(__FILE__), 'profile.json'))
    end
    
    profile = RubyDesk::Provider.get_profile(connector, 'aseldawy')
    
    assert_equal RubyDesk::Provider, profile.class
    assert_equal RubyDesk::Skill, profile.skills.first.class
    assert_equal RubyDesk::Competency, profile.competencies.first.class
  end
end
