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

  test "visiting /events/new and register new event" do
    sign_in_as(FactoryBot.create(:user))

    visit new_event_url
  
    assert_selector "h1", text: "Create new Event"

    fill_in "Name", with: "E2E test meetup"
    fill_in "Place", with: "online"
    fill_in "Content", with: "about E2E test"

    start_at = Time.current
    end_at = start_at + 3.hour

    start_at_field = "event_start_at"
    select start_at.strftime("%Y"), from: "#{start_at_field}_1i"
    select I18n.l(start_at, format: '%B'), from: "#{start_at_field}_2i"
    select start_at.strftime("%-d"), from: "#{start_at_field}_3i"
    select start_at.strftime("%H"), from: "#{start_at_field}_4i"
    select start_at.strftime("%M"), from: "#{start_at_field}_5i"

    end_at_field = "event_end_at"
    select end_at.strftime("%Y"), from: "#{end_at_field}_1i"
    select I18n.l(end_at, format: '%B'), from: "#{end_at_field}_2i"
    select end_at.strftime("%-d"), from: "#{end_at_field}_3i"
    select end_at.strftime("%H"), from: "#{end_at_field}_4i"
    select end_at.strftime("%M"), from: "#{end_at_field}_5i"

    click_on "Create Event"
    assert_selector "div.alert", text: "Event created."
  end

  test "delete event" do
    sign_in_as(FactoryBot.create(:user))
    event = FactoryBot.create(:event, owner: current_user)
    visit event_url(event)

    assert_difference("Event.count", -1) do
      accept_confirm do
        click_on "Delete this Event"
      end
      assert_selector "div.alert", text: "Event deletion completed."
    end
  end
end
