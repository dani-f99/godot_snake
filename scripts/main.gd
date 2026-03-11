extends Node2D

# In your Main, Game, or Head script
@onready var tail_scene = preload("res://scenes/tail.tscn") 

func grow_snake():
	# 1. Create the new tail instance
	var tail = tail_scene.instantiate()
	
	# 2. Assign its index based on the current score or array size
	# If the head is index 0, the first tail is 1, the second is 2, etc.
	tail.segment_index = GlobalVar.score 
	
	# 3. Add it to the scene tree
	add_child(tail) # Note: add it to the correct parent node (e.g., a "SnakeParts" node)

func _on_apple_2_area_entered(_area: Area2D) -> void:
	grow_snake()
