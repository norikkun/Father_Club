require "test_helper"

class Public::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_users_edit_url
    assert_response :success
  end

  test "should get index" do
    get public_users_index_url
    assert_response :success
  end

  test "should get show" do
    get public_users_show_url
    assert_response :success
  end

  test "should get update" do
    get public_users_update_url
    assert_response :success
  end

  test "should get follower" do
    get public_users_follower_url
    assert_response :success
  end

  test "should get followed" do
    get public_users_followed_url
    assert_response :success
  end

  test "should get connfirm" do
    get public_users_connfirm_url
    assert_response :success
  end

  test "should get withdraw" do
    get public_users_withdraw_url
    assert_response :success
  end
end
