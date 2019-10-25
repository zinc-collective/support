class ClientBuilder
  CLIENTS = [
    {
      name: "Zinc", support_staff: ["hello@zinc.coop"],
      confirmation_message: "Thanks! We'll et back to you shortly!"
    },
    {
      name: "Moment Park", support_staff: ["hello+moment-park@zinc.coop"],
      confirmation_message: "Thanks! We'll et back to you shortly!"
    },
    {
      name: "Cohere", support_staff: ["info@wecohere.com"],
      on_success_redirect: "https://www.wecohere.com/thanks/for-reaching-out",
      on_failure_redirect: "https://www.wecohere.com/contact",
      honeytrap: true,
    },
    {
      name: "WeGotYourBackToday",
      confirmation_message: "Thanks! We'll get back to you shortly!",
      support_staff: ["hello+wegotyourback@zincma.de"],
    },
    {
      name: "Nourish",
      confirmation_message: "Thanks! We'll get back to you shortly!",
      support_staff: ["hello+wegotyourback@zincma.de"],
    },
  ]

  def populate
    CLIENTS.each do |client|
      inbox = Inbox.find_or_create_by(name: client[:name])
      inbox.update(confirmation_message: client[:confirmation_message]) if client[:confirmation_message].present?
      inbox.update(honeytrap: client[:honeytrap]) if client[:honeytrap].present?
      if client[:on_success_redirect] || client[:on_failure_redirect]
        inbox.update(redirect_on_success_url: client[:on_success_redirect],
                     redirect_on_failure_url: client[:on_failure_redirect],
                     redirect_on_completion: true)
      else
        inbox.update(redirect_on_success_url: nil,
                     redirect_on_failure_url: nil,
                     redirect_on_completion: false)
      end
      client[:support_staff].each do |email|
        staff = Person.find_or_create_by(email: email)
        inbox.inbox_permissions.find_or_create_by(person: staff)
      end
    end
  end
end
