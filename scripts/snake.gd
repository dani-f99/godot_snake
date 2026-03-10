# grid size is 800x640px -> (0,0) to (25,20) * 32 
# grid limit is (24, 19) * 32

extends CharacterBody2D

# defined variables and constants
const speed : float = GlobalVar.speed # constant speed of 32px per x seconds (x = move_time)
var direction : Vector2 = Vector2(0.0, 0.0) # Initial direction (none)
var snake_position : Vector2 = Vector2(0.0, 0.0) # snake head position
var direction_x # x-axis direction
var direction_y # y-axis direction
var move_ready : bool = true # starter move_trimer value


# Timeout function, when timer runs out the snake is ready to move again
func _on_move_timer_timeout() -> void:
	move_ready = true

func _physics_process(_delta):
	# Input change direction only
	if Input.is_action_just_pressed("ui_right"):
		direction = Vector2(1.0, 0.0)
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2(-1.0, 0.0)
	elif Input.is_action_just_pressed("ui_up"):
		direction = Vector2(0.0, -1.0)
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2(0.0, 1.0)
	
	# Snake movement, direction and timing
	while move_ready:
		snake_position = snake_position + Vector2(speed, speed) * direction
		position = snake_position
		move_ready = false # not ready to move again right after the movement
		$move_timer.start() # Cooldown after the movement, will be ready again after set time
	
