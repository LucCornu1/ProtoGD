extends RigidBody2D
class_name CelestialObject

func is_class(value: String): return value == "CelestialObject" or .is_class(value)
func get_class() -> String: return "CelestialObject"

# Export variables
export(float, 0, 100000) var grav_scale = 1.0

# Onready variables

# Variables
var attracting_bodies : Array = []
var current_gravity_force : Vector2 = Vector2.ZERO setget set_current_gravity_force, get_current_gravity_force

# Signals
signal gravity_well_entered
signal gravity_well_exited


#### ACCESSORS ####
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


#### BUILT-IN ####
func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")

func _physics_process(_delta : float) -> void:
	_compute_forces(_delta)

func _process(_delta : float) -> void:
	pass


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
	
	applied_force = current_gravity_force


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	print ("Hit")
