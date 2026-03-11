extends Node

const speed : float = 32.0 # constant speed of 32px per x seconds (x = move_time)
const screen_size : Vector2 = Vector2(672, 672) # Size of the game screen in pixels
const grid_size : Vector2 = Vector2(21, 21) # number of cells on the grid
const pixel_factor : float = 32.0 # 32x32 pixels per cell

var score : int = 1
var snake_array : Array = []
var tail_ready : bool = false
