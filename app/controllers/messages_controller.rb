class MessagesController < ApplicationController
  before_filter :authenticate
  
  def create
    @message = current_user.messages.build(params[:message])
    @message.game = active_game
    flash[:error] = @message.errors.full_messages.join(', ') if not @message.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { head :ok }
    end
  end
end
