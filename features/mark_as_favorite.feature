Feature: Mark list as favorite

  In order to remember the lists I liked
  As an user
  I want to mark them as favorites

  Scenario: mark as favorite
    Given I am a logged in user
    And I am in the path of a public list from another user
    When I click "Include to favorites"
    Then the list should be in my favorites list
    And I should be in the list path
    And I should see "Marked as favorite"
    And I should see "Remove from favorites"

  Scenario: unmark favorite
    Given I am a logged in user
    And I am in the path of a public list from another user marked as favorite
    When I click "Remove from favorites"
    Then the list should not be in my favorites list
    And I should be in the list path
    And I should see "Removed from favorites"
    And I should see "Include to favorites"
