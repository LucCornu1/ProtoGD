extends Option
class_name RestartOption

func is_class(value: String): return value == "RestartOption" or .is_class(value)
func get_class() -> String: return "RestartOption"


signal Restart


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	emit_signal("Restart")
