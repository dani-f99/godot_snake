# grid size is 800x640px -> (0,0) to (25,20) * 32 
# grid limit is (24, 19) * 32

extends StaticBody2D
var apple_pos = Vector2(0, 0)
var snake_pos
var score : int = 0


# Custom function that chooses random number from range
func random_numner(array_length : int) -> int:
	return randi_range(0, array_length)
	
	
# Custom function that select unccopuied cell
func teleport_apple(occupied_cells : Array, 
					grid_size : Vector2 = Vector2(25, 20)) -> Vector2:
	# getting the x,y arrays lengths
	var x_grid = range(grid_size[0])
	var y_grid = range(grid_size[1])
	
	# Removing occupied values from the list
	for cell in occupied_cells:
		x_grid.erase(cell[0])
		y_grid.erase(cell[0])
	
	# Choosing random index of element from y and x grids
	var xi_rand = random_numner(x_grid.size())
	var yi_rand = random_numner(y_grid.size())
	
	return Vector2(x_grid[xi_rand], y_grid[yi_rand]) * 32


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	position = teleport_apple([apple_pos])
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	snake_pos = get_node("/root/snake_game/snake")
	var snake_pos = snake_pos.snake_position
