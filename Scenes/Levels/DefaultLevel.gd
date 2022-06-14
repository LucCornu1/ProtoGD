extends Node2D
class_name DefaultLevel

func is_class(value: String): return value == "DefaultLevel" or .is_class(value)
func get_class() -> String: return "DefaultLevel"

# Export variables

# Onready variables
onready var character_ship : CharacterShip = get_node_or_null("CelestialBodies/CharacterShip")
onready var particle_handler : Node2D = get_node_or_null("Other/ParticleHandler")

# Variables


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	var __ = character_ship.connect("is_launched_changed", particle_handler, "_on_playership_launched")

func _physics_process(_delta : float) -> void:
	pass

func _process(_delta : float) -> void:
	if is_instance_valid(character_ship) and is_instance_valid(particle_handler):
		particle_handler.set_position(character_ship.get_position())
		particle_handler.set_rotation(character_ship._new_angle)


#### VIRTUALS ####


#### LOGIC ####
#func _compute_forces() -> void:
#	pass
#		if _i.is_class("CelestialObject"):
#			_i.set_applied_force(Vector2(0.0, 0.0))
#			for _j in _ysort.get_children():
#				if _j.is_class("CelestialObject") and _i != _j:
#					var grav = _compute_gravity(_i, _j)
#					_i.set_applied_force(_i.get_applied_force() + grav)
#
#	if _character.is_class("CelestialObject"):
#		_character.set_applied_force(Vector2(0.0, 0.0))
#		for _j in _ysort.get_children():
#			if _j.is_class("CelestialObject") and _character != _j:
#				var grav = _compute_gravity(_character, _j)
#				_character.set_applied_force(_character.get_applied_force() + grav)
#
#func _compute_gravity(A : CelestialObject, B : CelestialObject) -> Vector2:
#	return Vector2(0.0, 0.0)
#P = m*g

#G * ((A.mass * B.mass) / A.position.distance_squared_to(B.position) / 100) * A.position.direction_to(B.position)
#G * (M_a * M_b / d²) * (B_Vector - A_Vector).normalized()


#### INPUTS ####


#### SIGNAL RESPONSES ####
