require 'helper'

class TestRubyDesk < Test::Unit::TestCase
  def test_provider_search
    connector = Object.new
    def connector.prepare_and_invoke_api_call(*args)
      File.read(File.join(File.dirname(__FILE__), 'providers.json'))
    end
    
    providers = RubyDesk::Provider.search(connector, 'rails')
    
    assert providers.is_a?Array
    assert_equal 20, providers.size
  end
end
