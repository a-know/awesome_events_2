require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test '#created_by? when owner_id equals #id of args' do
    event = FactoryBot.create(:event)
    user = User.new
    # stub user
    user.stub(:id, event.owner_id) do
      assert_equal(true, event.created_by?(user))
    end
  end

  test '#created_by? when owner_id not equals #id of args' do
    event = FactoryBot.create(:event)
    # mock user
    another_user = MiniTest::Mock.new.expect(:id, "another_user_id")
    assert_equal(false, event.created_by?(another_user))
  end

  test '#created_by? when args is null' do
    event = FactoryBot.create(:event)
    assert_equal(false, event.created_by?(nil))
  end

  test 'start_at_should_be_before_end_at validation OK' do
    start_at = rand(1..30).days.from_now
    end_at = start_at + rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_empty(event.errors[:start_at])
  end

  test 'start_at_should_be_before_end_at validation NG' do
    start_at = rand(1..30).days.from_now
    end_at = start_at - rand(1..30).hours
    event = FactoryBot.build(:event, start_at: start_at, end_at: end_at)
    event.valid?
    assert_not_empty(event.errors[:start_at])
  end
end
