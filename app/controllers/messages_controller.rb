class MessagesController < ApplicationController
  def create
    @message = Message.new(params[:message])
    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    else
      redirect_to :contact, :alert => "Please fill in all fields."
    end
  end
end