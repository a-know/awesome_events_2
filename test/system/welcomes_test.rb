require "application_system_test_case"

class WelcomesTest < ApplicationSystemTestCase
  test "visiting the root page" do
    visit root_url
  
    assert_selector "h1", text: "Events List"
  end
end
