Feature: User sign in

  In order to be able to create a list
  As a user
  I want to sign in

  Scenario: successful sign in
    Given a user with email "elo.henrique@gmail.com" and password "hc031190"
    And I am in sign in page
    When I fill in "Email" with "elo.henrique@gmail.com"
    And I fill in "Password" with "hc031190"
    And I click "Log in"
    Then I should be logged in
