extends RigidBody2D
class_name CelestialObject

func is_class(value: String): return value == "CelestialObject" or .is_class(value)
func get_class() -> String: return "CelestialObject"

# Export variables
export(float, 0, 1000) var grav_scale = 1.0 setget set_grav_scale, get_grav_scale

# Onready variables

# Variables
var attracting_bodies : Array = []
var current_gravity_force : Vector2 = Vector2.ZERO setget set_current_gravity_force, get_current_gravity_force

var is_sucked : bool = false setget set_is_sucked, get_is_sucked

# Signals
signal gravity_well_entered
signal gravity_well_exited


#### ACCESSORS ####
func set_grav_scale(new_value : float) -> void:
	if new_value != grav_scale:
		grav_scale = new_value
#		emit_signal()

func get_grav_scale() -> float:
	return grav_scale

func append_to_attracting_bodies(body : PhysicsBody2D) -> void:
	attracting_bodies.append(body)
	emit_signal("gravity_well_entered")

func erase_from_attracting_bodies(body : PhysicsBody2D) -> void:
	attracting_bodies.erase(body)
	emit_signal("gravity_well_exited")

func set_current_gravity_force(new_value : Vector2) -> void:
	if new_value != current_gravity_force:
		current_gravity_force = new_value
#		emit_signal()

func get_current_gravity_force() -> Vector2:
	return current_gravity_force

func set_is_sucked(new_value : bool) -> void:
	if new_value != is_sucked:
		is_sucked = new_value
#		emit_signal()

func get_is_sucked() -> bool:
	return is_sucked


#### BUILT-IN ####
func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")

func _physics_process(_delta : float) -> void:
	_compute_forces(_delta)

func _process(_delta : float) -> void:
	if is_sucked:
		set_scale(lerp(scale, Vector2.ZERO, 0.9))


#### VIRTUALS ####


#### LOGIC ####
func _compute_forces(_delta : float) -> void:
	current_gravity_force = Vector2.ZERO
	
	for body in attracting_bodies:
		if is_instance_valid(body):
			var distance : float = position.distance_squared_to(body.position) #pow(distance, 0.88)
			var force : float = Singleton.grav_const * ((body.mass * mass) / distance)
			var direction : Vector2 = position.direction_to(body.position)
			current_gravity_force += force * direction * grav_scale
			
			if body.is_class("BlackHole") and is_sucked:
				applied_force = current_gravity_force
				return
	
	applied_force = current_gravity_force


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	print ("Hit")
