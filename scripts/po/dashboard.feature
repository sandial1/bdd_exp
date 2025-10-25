Feature: Dashboard

  Scenario: Dashboard page should have "Appointment Planner - Syncfusion Angular Components Showcase App" title
    When I open "Dashboard" page
    Then Page title should "be equal to" "Appointment Planner - Syncfusion Angular Components Showcase App"

  Scenario: It should be possible to open a modal window
    When I open "Dashboard" page
    And I click "Doctors" link from the side menu
    And I click add new doctor button from list header
    Then modal window should be displayed

    When I click "close" button in modal window
    Then modal window should not be displayed
