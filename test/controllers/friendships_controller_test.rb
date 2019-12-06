require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get friendships_select_url
    assert_response :success
  end

end
