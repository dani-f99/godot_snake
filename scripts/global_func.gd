extends Node

###
# Custom function that chooses random number from range
func random_numner(array_length : int) -> int:
	return randi_range(0, array_length)
	
###
# Custom function that select unccopuied cell
func teleport_apple(occupied_cells : Array, 
					grid_size = GlobalVar.grid_size - Vector2(1, 1))-> Vector2:
	# getting the x,y arrays lengths
	var x_grid = range(grid_size[0])
	var y_grid = range(grid_size[1])
	
	# Removing occupied values from the list
	for cell in occupied_cells:
		x_grid.erase(cell[0])
		y_grid.erase(cell[0])
	
	# Choosing random index of element from y and x grids
	var xi_rand = random_numner(x_grid.size()-1)
	var yi_rand = random_numner(y_grid.size()-1)
	
	return Vector2(x_grid[xi_rand], y_grid[yi_rand]) * GlobalVar.speed

# reload scene function
func restart_game():
	GlobalVar.snake_array  = []
	GlobalVar.score = 1
	get_tree().reload_current_scene()
	
func move_snake():
	# right, left, up, down
	# Input change direction only
	if (Input.is_action_just_pressed("ui_right")):
		return Vector2(1.0, 0.0)
	elif Input.is_action_just_pressed("ui_left"):
		return Vector2(-1.0, 0.0)
	elif Input.is_action_just_pressed("ui_up"):
		return Vector2(0.0, -1.0)
	elif Input.is_action_just_pressed("ui_down"):
		return Vector2(0.0, 1.0)
