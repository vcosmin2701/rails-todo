require "test_helper"

class Api::V1::TasksCotrollerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_tasks_url
    assert_response :success
  end

  test "index returns all tasks as json" do
    get api_v1_tasks_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal Task.count, json_response.length
  end

  test "index returns tasks with correct attributes" do
    get api_v1_tasks_url

    json_response = JSON.parse(response.body)
    task = json_response.first

    assert task.key?("title")
    assert task.key?("completed")
  end
end
