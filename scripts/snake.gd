# grid size is 800x640px -> (0,0) to (25,20) * 32 
# grid limit is (24, 19) * 32

extends CharacterBody2D

# defined variables and constants
const speed : float = GlobalVar.speed # constant speed of 32px per x seconds (x = move_time)
var direction : Vector2 = Vector2(0.0, 0.0) # Initial direction (none)
var move_ready : bool = true # starter move_trimer value
var snake_position : Vector2 = Vector2(320, 320) # snake head position
var direction_x : Vector2 # x-axis direction
var direction_y : Vector2 # y-axis direction
var unlock_movement : bool = true
var direction_bool : Array = [true, true, true, true]
var direction_dict : Dictionary = {Vector2(1.0, 0.0) : [true, false, true, true], 
								   Vector2(-1.0, 0.0): [false, true, true, true],
								   Vector2(0.0, -1.0): [true, true, true, false],
								   Vector2(0.0, 1.0): [true, true, false, true],
								   Vector2(0.0, 0.0): [true, true, true, true]}
								# right, left, up, down

# GlobalVar.score - global score var
# GlobalVar.snake_array - global snake array
var cell_size : float = GlobalVar.pixel_factor
var screen_size : Vector2 = GlobalVar.screen_size

# edges dict
var dict_edge = {- cell_size : screen_size.x , 
				 screen_size.x : - cell_size}

func _ready() -> void:
	GlobalVar.snake_array.append(snake_position)
	
# Timeout function, when timer runs out the snake is ready to move again
func _on_move_timer_timeout() -> void:
	move_ready = true

var input_locked : bool = false
func _physics_process(_delta):
	# right, left, up, down
	# Input change direction only
	if not input_locked and unlock_movement:
		if (Input.is_action_just_pressed("right")) and (direction_bool[0]):
			direction = Vector2(1.0, 0.0)
			input_locked = true
		elif Input.is_action_just_pressed("left") and (direction_bool[1]):
			direction = Vector2(-1.0, 0.0)
			input_locked = true
		elif Input.is_action_just_pressed("up") and (direction_bool[2]):
			direction = Vector2(0.0, -1.0)
			input_locked = true
		elif Input.is_action_just_pressed("down") and (direction_bool[3]):
			direction = Vector2(0.0, 1.0)
			input_locked = true
		
	# Snake movement, direction and timing
	while move_ready:
		snake_position = snake_position + Vector2(speed, speed) * direction
		
		# Snake parts tracking
		GlobalVar.snake_array.insert(0, snake_position)
		if GlobalVar.snake_array.size() > GlobalVar.score:
			GlobalVar.snake_array.pop_back()
			
		position = snake_position
		move_ready = false # not ready to move again right after the movement
		$move_timer.start() # Cooldown after the movement, will be ready again after set time
		
		unlock_movement = true
		# Synchronizing edge teleportation with snake movement		
		if (position.x == - cell_size) or (position.x == screen_size.x):
			snake_position.x = dict_edge[snake_position.x]
			unlock_movement = false

		elif (position.y == - cell_size) or (position.y == screen_size.y):
			snake_position.y = dict_edge[snake_position.y]
			unlock_movement = false
		
		input_locked = false

		
	# Reset game if snake eats hes tail
	var sliced_snake_array = GlobalVar.snake_array.slice(1)
	if snake_position in sliced_snake_array:
		print(GlobalVar.snake_array)
		GlobalFunc.restart_game()
		
	direction_bool = direction_dict[direction]
		
	if false:
		#print(GlobalVar.snake_array, GlobalVar.snake_array.size(), GlobalVar.score)
		#print(Engine.get_frames_per_second())
		print(GlobalVar.snake_array)
