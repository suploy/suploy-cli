Feature: Deploy a repository
  In order to make other people see my awesome work
  As a regular user
  I want to deploy my webapp

  Scenario: Upload repository from command line
    Given I am in my project repository
    When I enter "git push suploy master"
    Then I see the url of the deployed app

  Scenario: Deploying from command line not working
    Given I am in my project repository
    When I enter "git push suploy master"
    And the build on the server fails
    Then I see the error message
