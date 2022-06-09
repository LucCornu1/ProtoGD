extends CelestialObject
class_name CharacterShip

func is_class(value: String): return value == "CharacterShip" or .is_class(value)
func get_class() -> String: return "CharacterShip"

# Export variables
export(float) var thruster_force = 1 setget set_thruster_force, get_thruster_force

# Onready variables

# Variables
var _is_thrusting : int = 0


#### ACCESSORS ####
func set_thruster_force(new_value : float) -> void:
	if new_value != thruster_force:
		thruster_force = new_value
		#emit_signal()

func get_thruster_force() -> float:
	return thruster_force


#### BUILT-IN ####
func _ready() -> void:
	pass

func _physics_process(_delta : float) -> void:
	apply_movement(_delta)

func _process(_delta : float) -> void:
	turn_ship()


#### VIRTUALS ####
#func _compute_gravity(_delta : float) -> void:
#	._compute_gravity(_delta)
#
#	print(self)
#	for body in attracting_bodies:
#		apply_torque_impulse(body.position.angle_to(position))

#### LOGIC ####
func apply_movement(_delta : float) -> void:
	applied_force = applied_force.clamped(40.0)
	applied_force = applied_force * transform.x

func turn_ship() -> void:
	rotation = linear_velocity.angle()


#### INPUTS ####
func _input(event : InputEvent) -> void:
	if !event is InputEventKey:
		return
	
	var action_name : String = ""
	
	if event.is_action_pressed("player_forward"):
		action_name = "MoveForward_Pressed"
	
	elif event.is_action_released("player_forward"):
		action_name = "MoveForward_Released"
	
	if action_name != "": action(action_name)

func action(action_name : String) -> void:
	match(action_name):
		"MoveForward_Pressed":
			add_central_force(transform.x * thruster_force)
		"MoveForward_Released":
			pass
		_:
			return


#### SIGNAL RESPONSES ####
