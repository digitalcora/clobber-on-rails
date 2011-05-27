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
