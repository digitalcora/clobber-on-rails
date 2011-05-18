class GamesController < ApplicationController
  before_filter :authenticate
  before_filter :find_records, :except => :create
  before_filter :find_challenge, :only => :create
  before_filter :check_player_access, :except => :create
  before_filter :check_player_turn, :only => [:edit, :update]
  before_filter :setup_show, :only => [:show, :edit]

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
    
    def find_challenge
      @challenge = Challenge.find_by_id(params[:challenge_id])
      if @challenge.nil?
        flash[:notice] = 'The challenge you were attempting to accept has been canceled.'
        redirect_to :back
      end
    end
    
    def check_player_access
      if @game.players.include?(current_user.active_player)
        return true
      elsif (@game.players & current_user.players).any?
        redirect_to root_path, :notice => 'The game is over: ' + outcome_string
      else
        redirect_to root_path
      end
    end
    
    def check_player_turn
      if not current_user.active_player.turn_up
        redirect_to :back,
          :flash => { :error => "Can't perform this action when it's not your turn!" }
      end
    end
    
    def setup_show
      @title = 'Game versus ' +
        @game.players.reject{ |p| p == current_user.active_player}.
          map{ |p| p.user.username }.join(', ')
      @message = Message.new
      @messages = @game.messages
    end
    
    def outcome_string
      if @game.winner.nil?
        'It was abandoned.'
      elsif current_user.players.include?(@game.winner)
        'You won!'
      else
        'You lost!'
      end
    end
end
