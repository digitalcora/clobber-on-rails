class MessagesController < ApplicationController
  before_filter :authenticate
  
  def create
    @message = current_user.messages.build(params[:message])
    @message.game = active_game
    if not @message.content.blank?
      flash[:error] = @message.errors.first[1] if not @message.save
    end
    ajax_redirect_back
  end
end
