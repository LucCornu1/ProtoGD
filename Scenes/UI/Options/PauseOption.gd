extends Option
class_name PauseOption

func is_class(value: String): return value == "PauseOption" or .is_class(value)
func get_class() -> String: return "PauseOption"


#### ACCESSORS ####
func _ready() -> void:
	set_enabled(AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")))


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	get_tree().paused = get_enabled()
