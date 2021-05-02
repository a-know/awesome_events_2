require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "visiting the root page" do
    visit root_url
  
    assert_selector "h1", text: "Events List"
  end

  test "future event is shown but past event is not shown when visit /" do
    future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.day)
    past_event = FactoryBot.create(:event, start_at: Time.zone.now + 1.day)

    travel_to Time.zone.now + 2.day do
      visit root_url
      assert_selector "h5", text: future_event.name
      assert_no_selector "h5", text: past_event.name
    end
  end
end
