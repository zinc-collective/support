class ClientBuilder
  CLIENTS = [
    {
      name: "Cohere", support_staff: ['info@wecohere.com'],
      on_success_redirect: 'https://www.wecohere.com/thanks/for-reaching-out',
      on_failure_redirect: 'https://www.wecohere.com/contact',
     },
    { name: "WeGotYourBackToday", support_staff: ['hello+wegotyourback@zincma.de'] },
  ]

  def populate
    CLIENTS.each do |client|
      inbox = Inbox.find_or_create_by(name: client[:name])
      if(client[:on_success_redirect] || client[:on_failure_redirect])
        inbox.update(redirect_on_success_url: client[:on_success_redirect],
                     redirect_on_failure_url: client[:on_failure_redirect],
                     redirect_on_completion: true)
      end
      client[:support_staff].each do |email|
        staff = Person.find_or_create_by(email: email)
        inbox.inbox_permissions.create(person: staff)
      end
    end
  end
end