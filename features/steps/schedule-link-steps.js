const { Given } = require("cucumber");

Given('a(n) {actor} with a {permission} Schedule Link and {availability} Time Slots', function (actor, permission, availability) {
  // Write code here that turns the phrase above into concrete actions
  return 'pending';
});

Given('a(n) {actor} with a {permission} Schedule Link', function (actor, permission) {
  return this.apiClient({ actor }).createScheduleLink({ visibility: permission })
});
