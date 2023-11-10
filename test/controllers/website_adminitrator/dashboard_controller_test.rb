require "test_helper"

class WebsiteAdminitrator::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get website_adminitrator_dashboard_index_url
    assert_response :success
  end
end
