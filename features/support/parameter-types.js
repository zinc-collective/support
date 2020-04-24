const { defineParameterType } = require("cucumber");
defineParameterType({
  regexp: /(Team Member|Guest)/,
  name: "actor",
});

defineParameterType({
  regexp: /(Public|Private)/,
  name: "permission",
});


defineParameterType({
  regexp: /(Available|Unavailable)/,
  name: "availability",
});
