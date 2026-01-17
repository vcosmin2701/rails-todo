require "test_helper"

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest
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

  test "show returns only one task" do
    get api_v1_task_url(tasks(:one))
    assert_response :success

    json_response = JSON.parse(response.body)

    assert_instance_of Hash, json_response
    assert_equal tasks(:one).id, json_response["id"]
  end

  test "delete modifies the size of the items" do
    assert_difference "Task.count", -1 do
      delete api_v1_task_url(tasks(:one))
    end

    assert_response :no_content
  end

  test "create adds a new task" do
    assert_difference "Task.count", 1 do
      post api_v1_tasks_url, params: { task: { title: "New task " } }
    end

    assert_response :created
  end
end
