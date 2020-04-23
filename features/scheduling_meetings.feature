Feature: Scheduling Meetings

@scheduling @mvp @future
Scenario: Guest may Schedule a Meeting with a Team Member using a Public Schedule Link
  Given a Team Member with a Public Schedule Link and Available Time Slots
  When a Guest Books an Available Time Slot on the Team Member's Public Schedule Link
  And a Calendar Invite is sent to the Team Member
  Then a Calendar Invite is sent to the Guest
