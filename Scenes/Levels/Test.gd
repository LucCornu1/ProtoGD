extends RigidBody2D
func is_class(value: String): return value == "" or .is_class(value)
func get_class() -> String: return ""

#### ACCESSORS ####

#### BUILT-IN ####
func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	pass
