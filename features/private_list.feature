Feature: Private list

  In order to restrict my lists access
  As a user
  I want to make my lists private

  Background: another user with an user list
    Given I am a logged in user
    And I create a private list
    And I log out
    When I log in as another user

  Scenario: show private list
    When I go to his private list
    Then I should be in my lists path
    And I should see "Unauthorized access"

  Scenario: index private lists
    When I visit the users lists path
    Then I should not see "Private list"
