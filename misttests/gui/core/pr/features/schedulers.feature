@schedulers
Feature: Schedulers

  Background:
    Given I am logged in to mist.core

  @scheduler-add
  Scenario: Add schedule
    Given "Docker" cloud has been added
    When I visit the Machines page
    Then "ui-testing-machine" machine state has to be "running" within 20 seconds
    When I visit the Schedules page
    When I click the button "+"
    Then I expect the "schedule" add form to be visible within max 10 seconds
    When I set the value "TestScheduler" to field "Name" in "schedule" add form
    And I open the "Task" drop down
    And I wait for 2 seconds
    When I click the button "stop" in the "Task" dropdown
    And I wait for 2 seconds
#    And I select "Perform an action" from "script_or_action" radio-group
#    Then I open the "Action" drop down
#    And I click the button "Reboot" in the "Action" dropdown
#    And I wait for 1 seconds
    And I select "Specific Machines" from "ids_or_tags" radio-group
    And I wait for 1 seconds
    And I select the "ui-testing-machine" checkbox
    And I select "Repeat" from "schedule_type" radio-group
    #When I set the value "2" to field "Maximum Run Count" in "schedule" add form
    When I set the value "1" to field "interval" in "schedule" add form
    And I click the button "Add" in "schedule" add form
    And I wait for 1 seconds
    When I visit the Machines page
    Then "Spiros-test-scheduler" machine state has to be "stopped" within 30 seconds


   @scheduler-rename
   Scenario: Rename schedule
     When I visit the Schedules page
     When I click the "TestScheduler" "schedule"
     And I expect the "schedule" edit form to be visible within max 5 seconds
     Then I click the button "Edit" from the menu of the "schedule" edit form
     And I expect the dialog "Edit Schedule" is open within 4 seconds
     When I set the value "RenamedSchedule" to field "Name" in "Edit Schedule" dialog
     And I click the "Save" button in the dialog "Edit Schedule"
     And I expect the dialog "Edit Schedule"  is closed within 4 seconds
     Then I visit the Home page
     When I visit the Schedules page
     Then "TestScheduler" schedule should be absent within 5 seconds
     And "RenamedSchedule" schedule should be present within 5 seconds
  #
  # @schedule-delete
  # Scenario: Delete schedule
  #   When I visit the Schedulers page
  #   Then I click the button "Delete" from the menu of the "SecInt" scheduler
  #   And I expect the dialog "Delete Schedule" is open within 4 seconds
  #   And I click the "Delete" button in the dialog "Delete Scheduler"
  #   And I expect the dialog "Delete Scheduler" is closed within 4 seconds
  #   Then "SecInt" script should be absent within 5 seconds
  #   When I click the "myCron" "script"
  #   And I expect the "scheduler" edit form to be visible within max 5 seconds
  #   Then I click the button "Delete Scheduler" from the menu of the "schedule" edit form
  #   And I expect the dialog "Delete Scheduler" is open within 4 seconds
  #   And I click the "Delete" button in the dialog "Delete Scheduler"
  #   And I expect the dialog "Delete Scheduler" is closed within 4 seconds
  #   Then "myCron" script should be absent within 5 seconds
