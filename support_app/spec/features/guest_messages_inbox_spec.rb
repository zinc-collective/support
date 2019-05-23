require "rails_helper"

RSpec.describe "Guest messages inbox", :type => :system do
  before do
    driven_by(:rack_test)
    @inbox = FactoryBot.create(:inbox)
    @guest = FactoryBot.build(:guest)
  end

  it "enables me to create widgets" do
    visit inbox_path(@inbox)
    message_content = "Can you send me the pricing for your services?"

    fill_in "Name", with: guest.name
    fll_in "Email", with: guest.email
    fill_in "Message:", with: message_content
    click_button "Send Message"

    message = @inbox.messages.where(name: @guest.email,
                                    email: @guest.name,
                                    status: :sent,
                                    content: message_content).last

    expect(page).to have_text("Message submitted! Your receipt is in your email!")
    expect(message).to be_present
    expect(message.receipts.where(email: @guest.email, stage: :received)).to be_present
    expect(message.received_at).to be_within(1.second.ago).to(Time.now)
  end
end