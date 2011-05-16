class MessagesController < ApplicationController
  before_filter :authenticate
  
  def create
    @message = current_user.messages.build(params[:message])
    @message.game = current_user.active_game
    flash[:error] = @message.errors.full_messages.join(', ') if not @message.save
    redirect_to :back
  end
end
