extends RigidBody2D
class_name CelestialObject

func is_class(value: String): return value == "CelestialObject" or .is_class(value)
func get_class() -> String: return "CelestialObject"

# Export variables
export(float, 0, 1000) var grav_scale = 1.0

# Onready variables

# Variables
var attracting_bodies : Array = []


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	pass

func _physics_process(_delta : float) -> void:
	_compute_gravity(_delta)
#	_apply_movement()


#### VIRTUALS ####


#### LOGIC ####
func _compute_gravity(_delta : float) -> void:
	for body in attracting_bodies:
		var distance : float = position.distance_squared_to(body.position) #pow(distance, 0.88)
		var force : float = Singleton.grav_const * ((body.mass * mass) / distance)
		var direction : Vector2 = position.direction_to(body.position) 
		apply_central_impulse(force * direction * _delta * grav_scale)
	
#	applied_force = applied_force.clamped(max_force_length)

#func compute_gravity(object : CelestialObject) -> Vector2:
#	return object.grav_acc * ((object.mass * mass) / position.distance_squared_to(object.position)) * position.direction_to(object.position)

#### INPUTS ####


#### SIGNAL RESPONSES ####
