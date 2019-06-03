class InboundMessagesController < ApplicationController
  def create
    @inbox = Inbox.find_by(id: inbound_messages_params[:inbox_id])
    @inbound_message = @inbox.process_inbound_message(inbound_messages_params)


    redirect_to @inbound_message if @inbound_message.persisted?
  end

  def show
    @inbound_message = InboundMessage.find(params[:id])
  end

  private def inbound_messages_params
    params.require(:inbound_message)
          .permit(:inbox_id, :sender_id, :sender_name, :sender_email, :raw_body)
          .merge(received_at: Time.now)

  end
end
