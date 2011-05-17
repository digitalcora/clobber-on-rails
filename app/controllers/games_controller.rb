class GamesController < ApplicationController
  before_filter :authenticate
  before_filter :find_records, :except => :create
  before_filter :setup_show, :only => [:show, :edit]
  before_filter :find_challenge, :only => :create

  def show
    # Nothing special
  end
  
  def create
    @game = Game.create!
    [@challenge.user, @challenge.target_user].each_with_index do |user, i|
      player = user.players.build
      player.game = @game
      player.turn_order = i + 1
      player.save!
    end
    @challenge.destroy
    
    players = @game.players.each
    player = players.next
    @game.height.times do |y|
      @game.width.times do |x|
        player.pieces.create!(:x => x, :y => y)
        begin
          player = players.next
        rescue StopIteration
          players.rewind
          retry
        end
      end
    end
    
    redirect_to @game
  end
  
  def edit
    flash.now[:notice] = 'Piece moving not implemented yet!'
    render 'show'
  end
  
  def update
    redirect_to @game, :notice => 'Piece moving not implemented yet!'
  end
  
  private
  
    def find_records
      if params[:game_id]
        # We came from a Piece route (edit/update)
        @game = Game.find(params[:game_id])
        @piece = Piece.find(params[:id])
      else
        # We came from a Game route (show)
        @game = Game.find(params[:id])
      end
    end
    
    def setup_show
      @title = 'Game versus ' +
        @game.players.reject{ |p| p == current_user.active_player}.
          map{ |p| p.user.username }.join(', ')
      @message = Message.new
      @messages = @game.messages
    end
    
    def find_challenge
      @challenge = Challenge.find_by_id(params[:challenge_id])
      if @challenge.nil?
        flash[:notice] = 'The challenge you were attempting to accept has been canceled.'
        redirect_to :back
      end
    end
end
