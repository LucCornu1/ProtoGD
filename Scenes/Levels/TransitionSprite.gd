extends Control
class_name TransitionSprite

func is_class(value: String): return value == "TransitionSprite" or .is_class(value)
func get_class() -> String: return "TransitionSprite"


# Export variables

# Onready variables
onready var sprite_node : TextureRect = get_node("Sprite")
onready var label_node : Label = get_node("ColorRect/Label")
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

# Variables

# Signals
signal is_ready


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	animation_player.play("RESET")
	if Singleton.screenshot != null:
		sprite_node.texture = Singleton.screenshot
	#	sprite_node.set_scale(Vector2(1.25, 1.25)) ### HOTFIX : Will not work for every PC
		animation_player.play("Transition")
	else:
		Singleton.level_ready = false
		label_node.text = Singleton.level_name
		animation_player.play("NewLevel")
	Singleton.screenshot = null


#### VIRTUALS ####


#### LOGIC ####
func signal_ready() -> void:
	Singleton.level_ready = true


#### INPUTS ####


#### SIGNAL RESPONSES ####
