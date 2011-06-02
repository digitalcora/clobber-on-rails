# Size in pixels of the game board tiles
# (floating point for better precision in SVG)
TILE_SIZE = 100.0

# Time in milliseconds between ajax updates
UPDATE_DELAY = 750

# Player/piece colors and color names
PLAYER_COLORS = [
  [ 'red',  'red',  '#a11' ],
  [ 'blue', 'blue', '#119' ]
].map do |colors|
  { :name => colors[0], :primary => colors[1], :secondary => colors[2] }
end

# Content for the contextual help feature
HELP_CONTENT = {
  'fallback' => %~
    <p>There is no help content for this page. Sorry!</p>
  ~,
  'users#edit' => %~
    <p>This page allows you to edit the details of your account. Note that currently you must re-enter and re-confirm your password to change your username.</p>
  ~,
  'pages#home' => %~
    <p>You are in the Game Lobby. To the right is a list of online users and their <span class="stats">[ <span class="wins">win</span> / <span class="losses">loss</span> ]</span> records. To chat with them, type your message in the text box and press Enter. To challenge a user to a game, click the <span class="inverse button yellow">C!</span> button next to their name. If they accept, you will both enter the game immediately.</p>
  ~,
  'games#show' => %~
    <p>You are in a game of Clobber. The rules are simple: When it is your turn, select one of your pieces, then select an adjacent opposing piece to clobber it! You cannot move diagonally, and you can <b>only</b> move a piece into an opposing piece (not into an empty space). The winner is the one who makes the last move, i.e. leaves their opponent with no possible moves. Good luck!</p>
  ~
}
