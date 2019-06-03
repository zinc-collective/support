class InboxesController < ApplicationController

  def show
    @inbox = Inbox.find_by(id: params[:id])
    @inbound_message = @inbox.inbound_messages.build
  end
end
