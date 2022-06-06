extends RigidBody2D
class_name CelestialObject

func is_class(value: String): return value == "CelestialObject" or .is_class(value)
func get_class() -> String: return "CelestialObject"

# Export variables
export(float) var mass_Kg = 0.0

# Onready variables

# Variables
var _speed : Vector2 = Vector2(0.0, 0.0) setget set_speed, get_speed
var _acceleration : Vector2 = Vector2(0.0, 0.0) setget set_acceleration, get_acceleration
var _applied_force : Vector2 = Vector2(0.0, -20.0) setget set_applied_force, get_applied_force


#### ACCESSORS ####
func set_speed(value : Vector2) -> void:
	if value != _speed:
		_speed = value
		emit_signal("_speed_changed")

func get_speed() -> Vector2:
	return _speed

func set_acceleration(value : Vector2) -> void:
	if value != _acceleration:
		_acceleration = value
		emit_signal("_acceleration_changed")

func get_acceleration() -> Vector2:
	return _acceleration

func set_applied_force(value : Vector2) -> void:
	if value != _applied_force:
		_applied_force = value
		emit_signal("_applied_force_changed")

func get_applied_force() -> Vector2:
	return _applied_force


#### BUILT-IN ####
func _ready() -> void:
	pass

func _physics_process(_delta) -> void:
	_apply_movement()


#### VIRTUALS ####



#### LOGIC ####
func _apply_movement() -> void:
	if _applied_force != Vector2.ZERO:
		add_central_force(_applied_force)


#### INPUTS ####



#### SIGNAL RESPONSES ####
