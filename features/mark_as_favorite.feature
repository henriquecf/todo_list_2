Feature: Mark list as favorite

  In order to remember the lists I liked
  As an user
  I want to mark them as favorites

  @wip
  Scenario: mark as favorite
    Given I am a logged in user
    And I am in the path of a public list from another user
    When I click "Mark as favorite"
    Then the list should be in my favorites list
