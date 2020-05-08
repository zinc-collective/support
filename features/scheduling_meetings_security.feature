@wip
Feature: Scheduling Meetings Security
  In order to prevent my time from being sucked away
  As a Team Member
  I would like to be the sole authority for when I am available for scheduling

  Scenario: Malicious Actor Invites Team Member's Public Schedule Availability Email Address to an Event
    Given a Team Member with a Public Schedule Link
    When Anyne Else invites their Public Schedule's Availability Email Address to a Calendar Event
    Then an Available Time Slot is not visible on the Team Member's Public Schedule Link for that Calendar Event's