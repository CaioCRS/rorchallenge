require 'test_helper'

class CnabControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cnab_index_url
    assert_response :success
  end

end
