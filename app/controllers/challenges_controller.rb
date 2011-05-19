class ChallengesController < ApplicationController
  before_filter :authenticate
  before_filter :active_game_redirect

  def create
    @challenge = current_user.build_challenge(params[:challenge])
    flash[:error] = @challenge.errors.full_messages.join(', ') if not @challenge.save
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { head :ok }
    end
  end

  def destroy
    @challenge = Challenge.find_by_id(params[:id])
    if @challenge.nil?
      flash[:notice] = 'The challenge you were attempting to decline was already canceled.'
    elsif current_user?(@challenge.user)
      @challenge.destroy
      flash[:notice] = 'Challenge canceled.'
    elsif current_user?(@challenge.target_user)
      @challenge.destroy
      flash[:notice] = 'Challenge declined.'
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { head :ok }
    end
  end
end
