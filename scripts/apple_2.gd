# grid size is 800x640px -> (0,0) to (25,20) * 32 
# grid limit is (24, 19) * 32

extends Area2D

# Variables
@onready var snake_pos_node = get_node("/root/snake_game/snake")
var apple_pos = Vector2(0, 0)
var snake_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = GlobalFunc.teleport_apple([apple_pos])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	snake_pos = snake_pos_node.snake_position

# Collision function
func _on_area_entered(_area: Area2D) -> void:
	GlobalVar.score += 1
	print(GlobalVar.score)
	position = GlobalFunc.teleport_apple([snake_pos])
