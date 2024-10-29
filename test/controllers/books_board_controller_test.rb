require "test_helper"

class BooksBoardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get books_board_index_url
    assert_response :success
  end
end
