class ChallengesController < ApplicationController
  before_filter :authenticate
  before_filter :active_game_redirect

  def create
    @challenge = current_user.build_challenge(params[:challenge])
    flash[:error] = @challenge.errors.full_messages.join(', ') if not @challenge.save
    redirect_to :back
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    if current_user?(@challenge.user)
      @challenge.destroy
      flash[:notice] = 'Challenge canceled.'
    elsif current_user?(@challenge.target_user)
      @challenge.destroy
      flash[:notice] = 'Challenge declined.'
    end
    redirect_to :back
  end
end
