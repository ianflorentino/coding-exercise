require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'should not save without a title' do
    task = Task.new
    assert_not task.save
  end
end
