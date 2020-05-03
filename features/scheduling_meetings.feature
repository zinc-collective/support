@scheduling
Feature: Scheduling Meetings
  In order to accept inbound meeting requests
  As a Team Member
  I want a public place for people to schedule meetings with me

  @mvp @wip
  Scenario: Team Member Creates New Available Time Slot through Invitation
    From Their preferred Calendar Application
    Given a Team Member with a Public Schedule Link
    When the Team Member invites their Public Schedule Link Email ID to an event using their preferred Calendar application
    Then the Available Time Slot is visible on the Team Member's Public Schedule Link

  @mvp @future
  Scenario: Guest may Schedule a Meeting with a Team Member using a Public Schedule Link
    Given a Team Member with a Public Schedule Link and Available Time Slots
    When a Guest Books an Available Time Slot on the Team Member's Public Schedule Link
    And a Calendar Invite is sent to the Team Member
    Then a Calendar Invite is sent to the Guest
