module GamesHelper

  def status_string
    current_user.active_player.turn_up ? 'Your Turn' : "Opponent's Turn"
  end

end
