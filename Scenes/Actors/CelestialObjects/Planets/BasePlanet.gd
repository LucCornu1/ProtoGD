extends CelestialObject
class_name BasePlanet

func is_class(value: String): return value == "BasePlanet" or .is_class(value)
func get_class() -> String: return "BasePlanet"

# Export variables
export(float) var grav_acc = 9.81 setget set_grav_acc, get_grav_acc

# Onready variables
onready var gravity_well_node : Area2D = get_node("GravityWell")

# Variables


#### ACCESSORS ####
func set_grav_acc(new_value : float) -> void:
	if new_value != grav_acc:
		grav_acc = new_value
		#emit_signal()

func get_grav_acc() -> float:
	return grav_acc


#### BUILT-IN ####
func _ready() -> void:
	._ready()
	
	var __ = gravity_well_node.connect("body_entered", self, "_on_gravity_well_body_entered")

func _process(_delta : float) -> void:
	pass


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_gravity_well_body_entered(body : Node) -> void:
	if is_instance_valid(body):
		if body != self:
			if body.is_class("CelestialObject"):
				body.attracting_bodies.append(self)
