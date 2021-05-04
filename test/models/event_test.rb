require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test '#created_by? when owner_id equals #id of args' do
    event = FactoryBot.create(:event)
    assert_equal(true, event.created_by?(event.owner))
  end

  test '#created_by? when owner_id not equals #id of args' do
    event = FactoryBot.create(:event)
    another_user = FactoryBot.create(:user)
    assert_equal(false, event.created_by?(another_user))
  end

  test '#created_by? when args is null' do
    event = FactoryBot.create(:event)
    assert_equal(false, event.created_by?(nil))
  end
end
