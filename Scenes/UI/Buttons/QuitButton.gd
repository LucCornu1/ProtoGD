extends Button_
class_name QuitButton

func is_class(value: String): return value == "QuitButton" or .is_class(value)
func get_class() -> String: return "QuitButton"


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_TextureButton_pressed() -> void:
	get_tree().quit()
