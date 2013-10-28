Feature: Deploy a repository
  In order to make other people see my awesome work
  As a regular user
  I want to deploy my webapp

  Scenario: Init Repository from command line
    Given I am in a git repository
    When I enter "./suploy init"
    Then I have a new git remote pointing to the suploy server

  Scenario: Init Repository with remote existent
    Given I am in a git repository
    When I enter "./suploy init"
    And the remote is already existent
    Then I see an error message
