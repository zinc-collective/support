const { setWorldConstructor } = require('cucumber')

function AttachDrivers() {
  this.apiClient = ({ actor }) => ({
    createScheduleLink: ({ teamMember, visiblity }) => {
      return new Promise(() => true, () => false);
    }
  })
}

setWorldConstructor(AttachDrivers)