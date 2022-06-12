extends Node2D
class_name TransitionSprite

func is_class(value: String): return value == "TransitionSprite" or .is_class(value)
func get_class() -> String: return "TransitionSprite"


# Export variables

# Onready variables
onready var sprite_node : Sprite = get_node("Sprite")
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

# Variables

# Signals


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	sprite_node.texture = Singleton.screenshot
	animation_player.play("RESET")
	animation_player.play("Transition")



#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
