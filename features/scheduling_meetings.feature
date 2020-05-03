@scheduling
Feature: Scheduling Meetings
  In order to accept inbound meeting requests
  As a Team Member
  I want a public place for people to schedule meetings with me

  @mvp @wip
  Scenario: Team Member Makes a Available Time Slot by Email Invitation
    Given a Team Member with a Public Schedule Link
    When the Team Member invites their Public Schedule's Availability Email Address to a Calendar Event
    Then an Available Time Slot is visible on the Team Member's Public Schedule Link for that Calendar Event's

  @mvp @future
  Scenario: Guest may Schedule a Meeting with a Team Member using a Public Schedule Link
    Given a Team Member with a Public Schedule Link and Available Time Slots
    When a Guest Books an Available Time Slot on the Team Member's Public Schedule Link
    And a Calendar Invite is sent to the Team Member
    Then a Calendar Invite is sent to the Guest
