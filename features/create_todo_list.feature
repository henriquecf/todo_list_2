Feature: Create todo list

  In order to keep my things organized
  As a user
  I want to create a todo list

  Background: logged in user in list path
    Given I am a logged in user
    And I am in list creation path

  Scenario: Successful creation
    When I fill in "Name" with "Market list"
    And I check "Is private"
    And I click "Create"
    Then a list named "Market list" should have been created

  @wip
  Scenario: create list with task
    When I fill in "Name" with "My list"
    And I find "Task name" number 0 and fill in with "My first task"
    And I click "Create"
    Then a list named "My list" should have been created
    And that list should have 3 tasks assigned to it
