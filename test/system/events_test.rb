require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "visiting /events/:id" do
    event = FactoryBot.create(:event)
    visit event_url(event)
  
    assert_selector "h1", text: event.name
  end

  test "visiting /events/new" do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
  
    assert_selector "h1", text: "Create new Event"
  end
end
