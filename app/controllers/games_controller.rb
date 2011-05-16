class GamesController < ApplicationController
  before_filter :authenticate
  before_filter :find_records, :except => :create
  before_filter :setup_show, :only => [:show, :edit]

  def show
    # Nothing special
  end
  
  def create
    
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
end
