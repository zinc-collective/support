class InboundMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @inbox = Inbox.find_by(id: inbound_messages_params[:inbox_id])
    @inbound_message = @inbox.process_inbound_message(inbound_messages_params)

    if @inbox.redirect_on_completion? && @inbound_message.persisted?
      redirect_to @inbox.redirect_on_success_url
    elsif @inbox.redirect_on_completion? && !@inbound_message.persisted?
      redirect_to @inbox.redirect_on_failure_url
    elsif @inbox.persisted?
      redirect_to @inbound_message
    else
      render :edit
    end
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
