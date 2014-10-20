Feature: User sign up

  In order to be able to sign in
  As a user
  I want to sign up

  Scenario: successful sign up
    Given I visit sign_up
    When I fill in "Email" with "elo.henrique@gmail.com"
    And I fill in "user_password" with "hc031190"
    And I fill in "user_password_confirmation" with "hc031190"
    And I click "Sign up"
    Then there should exist a user with email "elo.henrique@gmail.com"
