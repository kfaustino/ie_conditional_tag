require 'helper'
require 'action_view/template/handlers/erb'

class TestIEConditionalTag < ActionView::TestCase
  tests IEConditionalTag::Helper

  setup do
    @response = ActionController::TestResponse.new
    IEConditionalTag.config.clear
    IEConditionalTag.configure do |config|
      config.on 'lt IE 7', :class => 'ie6'
      config.on 'IE 7', :class => 'ie7'
      config.on 'IE 8', :class => 'ie8'
      config.on 'IE 9', :class => 'ie9'
      config.on 'gt IE 9'
      config.on '!IE'
    end
  end

  test "browser body tag with no options and no block" do
    rendered = ie_conditional_tag(:html)
    assert rendered.include?('<!--[if lt IE 7]><html class="ie6"><![endif]-->')
    assert rendered.include?('<!--[if IE 7]><html class="ie7"><![endif]-->')
    assert rendered.include?('<!--[if IE 8]><html class="ie8"><![endif]-->')
    assert rendered.include?('<!--[if IE 9]><html class="ie9"><![endif]-->')
    assert rendered.include?('<!--[if gt IE 9]><html><![endif]-->')
    assert rendered.include?('<!--[if !IE]><!--><html><!--<![endif]-->')
  end

end
