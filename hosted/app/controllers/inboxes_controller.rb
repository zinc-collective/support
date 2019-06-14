class InboxesController < ApplicationController
  def show
    @inbox = Inbox.friendly.find(params[:id])
    @inbound_message = @inbox.inbound_messages.build
  end
end
