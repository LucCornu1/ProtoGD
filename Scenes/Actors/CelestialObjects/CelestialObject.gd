extends RigidBody2D
class_name CelestialObject

func is_class(value: String): return value == "CelestialObject" or .is_class(value)
func get_class() -> String: return "CelestialObject"

# Export variables

# Onready variables

# Variables
var _applied_force : Vector2 = Vector2(0.0, 0.0) setget set_applied_force, get_applied_force
var attracting_bodies : Array = []


#### ACCESSORS ####
func set_applied_force(value : Vector2) -> void:
	if value != _applied_force:
		_applied_force = value
		emit_signal("_applied_force_changed")

func get_applied_force() -> Vector2:
	return _applied_force


#### BUILT-IN ####
func _ready() -> void:
	var __ = connect("_applied_force_changed", self, "_on_applied_force_changed")

func _physics_process(_delta : float) -> void:
	_compute_forces(_delta)
#	_apply_movement()


#### VIRTUALS ####


#### LOGIC ####
# TO-DO : Fusionner l'ancienne version avec cette nouvelle version
# Le niveau donne au personnage tous les objets attirant celui-ci
func _compute_forces(_delta : float) -> void:
	_applied_force = Vector2(0.0, 0.0)
	for body in attracting_bodies:
		var force : float = body.grav_acc * ((body.mass * mass) / position.distance_squared_to(body.position))
		var direction : Vector2 = position.direction_to(body.position) 
		apply_central_impulse(force * direction * _delta * 100.0)

#func compute_gravity(object : CelestialObject) -> Vector2:
#	return object.grav_acc * ((object.mass * mass) / position.distance_squared_to(object.position)) * position.direction_to(object.position)

#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_applied_force_changed() -> void:
	pass
