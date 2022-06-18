extends NinePatchRect
class_name Button_

func is_class(value: String): return value == "Button_" or .is_class(value)
func get_class() -> String: return "Button_"


# Export variables
export(PackedScene) var next_level

# Onready variables
onready var label_node : Label = get_node("Label")
onready var animation_player : AnimationPlayer = get_node("TextureRect/AnimationPlayer")


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_TextureButton_pressed() -> void:
	get_tree().change_scene_to(next_level)

func _on_TextureButton_mouse_entered() -> void:
	label_node.add_color_override("font_color", Color(1.0, 0.0, 0.0))
	animation_player.play("Rotation")

func _on_TextureButton_mouse_exited() -> void:
	label_node.add_color_override("font_color", Color(1.0, 1.0, 1.0))
	animation_player.stop(false)
