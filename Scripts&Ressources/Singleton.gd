extends Node

func is_class(value: String): return value == "Singleton" or .is_class(value)
func get_class() -> String: return "Singleton"


# Export variables

# Onready variables

# Variables
var game_speed : Dictionary = {STOP = 0, SLOW = 0.5, NORMAL = 1, FAST = 2, FOCUS = 4}
var curr_game_speed : float = game_speed.NORMAL

var screenshot : ImageTexture
var level_name : String = "Force = masse * Acceleration"
var level_ready : bool = false

const grav_const : float = 6.67


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
