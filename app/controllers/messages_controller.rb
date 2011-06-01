class MessagesController < ApplicationController
  before_filter :authenticate
  
  def create
    @message = current_user.messages.build(params[:message])
    @message.game = active_game
    flash[:error] = @message.errors.full_messages.join(', ') if not @message.save
    ajax_redirect_back
  end
end
