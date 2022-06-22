extends Option
class_name InformationOption

func is_class(value: String): return value == "InformationOption" or .is_class(value)
func get_class() -> String: return "InformationOption"


signal seek_information


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_button_pressed() -> void:
	._on_button_pressed()
	emit_signal("seek_information", get_enabled())
