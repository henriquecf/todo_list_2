Feature: Create todo list

  In order to keep my things organized
  As a user
  I want to create a todo list

  Scenario: Successful creation
    Given I am a logged in user
    And I am in list creation path
    When I fill in "Name" with "Market list"
    And I check "Is private"
    And I click "Create"
    Then I list named "Market list" should have been created
