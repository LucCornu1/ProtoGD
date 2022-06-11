extends CelestialObject
class_name BasePlanet

func is_class(value: String): return value == "BasePlanet" or .is_class(value)
func get_class() -> String: return "BasePlanet"

# Export variables

# Onready variables
onready var gravity_well_node : Area2D = get_node("GravityWell")

# Variables


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	var __ = gravity_well_node.connect("body_entered", self, "_on_gravity_well_body_entered")
	__ = gravity_well_node.connect("body_exited", self, "_on_gravity_well_body_exited")

func _process(_delta : float) -> void:
	pass


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_gravity_well_body_entered(body : Node) -> void:
	if is_instance_valid(body):
		if body != self and body.is_class("CelestialObject"):
			body.append_to_attracting_bodies(self)

func _on_gravity_well_body_exited(body : Node) -> void:
	if is_instance_valid(body):
		if body != self and body.is_class("CelestialObject"):
			body.erase_from_attracting_bodies(self)
