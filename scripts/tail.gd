extends Area2D

# This replaces your init_score. It tells the tail which index to follow.
var segment_index 

func _ready():
	position = Vector2(-100, -100)

func _physics_process(_delta: float) -> void:
	# Make sure the array is large enough before trying to access the index
	# to prevent "index out of bounds" crash.
	if GlobalVar.snake_array.size() >= segment_index :
		position = GlobalVar.snake_array[segment_index - 1]
