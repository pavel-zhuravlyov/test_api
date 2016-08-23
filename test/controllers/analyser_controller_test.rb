require 'test_helper'

class AnalyserControllerTest < ActionDispatch::IntegrationTest
  test "should get analyse" do
    get analyser_analyse_url
    assert_response :success
  end

  test "should get correlation" do
    get analyser_correlation_url
    assert_response :success
  end

end
