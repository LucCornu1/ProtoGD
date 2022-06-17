extends CanvasLayer
class_name HUD

func is_class(value: String): return value == "HUD" or .is_class(value)
func get_class() -> String: return "HUD"


signal is_hovered_changed


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_HBoxContainer_mouse_entered():
	emit_signal("is_hovered_changed", true)

func _on_HBoxContainer_mouse_exited():
	emit_signal("is_hovered_changed", false)
