require "rails_helper"

describe ClientBuilder do
  describe "#populate" do
    it "sets up cohere" do
      ClientBuilder.new.populate
      cohere_inbox = Inbox.find_by(name: "Cohere")
      expect(cohere_inbox).to be_present
      expect(cohere_inbox.slug).to eql("cohere")
      expect(cohere_inbox).to be_honeytrap
      expect(cohere_inbox.redirect_on_completion?).to eql true
      expect(cohere_inbox.redirect_on_success_url).to eql "https://www.wecohere.com/thanks/for-reaching-out"
      expect(cohere_inbox.redirect_on_failure_url).to eql "https://www.wecohere.com/contact"
      expect(cohere_inbox.support_staff.count).to eql(1)
      expect(cohere_inbox.support_staff.first.email).to eql("info@wecohere.com")
    end

    it "sets up wegotyourbacktoday" do
      ClientBuilder.new.populate
      wgybt_inbox = Inbox.find_by(name: "WeGotYourBackToday")

      expect(wgybt_inbox).to be_present
      expect(wgybt_inbox.confirmation_message).to eql "Thanks! We'll get back to you shortly!"
      expect(wgybt_inbox.slug).to eql "wegotyourbacktoday"
      expect(wgybt_inbox.redirect_on_completion?).to eql false
      expect(wgybt_inbox.redirect_on_success_url).to be_nil
      expect(wgybt_inbox.redirect_on_failure_url).to be_nil
      expect(wgybt_inbox.support_staff.count).to eql(1)
      expect(wgybt_inbox.support_staff.first.email).to eql("hello+wegotyourback@zincma.de")
    end
  end
end
