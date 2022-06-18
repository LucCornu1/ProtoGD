extends Option
class_name ExitOption

func is_class(value: String): return value == "ExitOption" or .is_class(value)
func get_class() -> String: return "ExitOption"


#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	pass

#### VIRTUALS ####

#### LOGIC ####

#### INPUTS ####

#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	get_tree().change_scene("res://Scenes/Levels/GameLevels/Menu.tscn")
