class ChallengesController < ApplicationController
  before_filter :authenticate
  before_filter :active_game_redirect

  def create
    @challenge = current_user.build_challenge(params[:challenge])
    flash[:error] = @challenge.errors.first[1] if not @challenge.save
    ajax_redirect_back
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
    
    ajax_redirect_back
  end
end
