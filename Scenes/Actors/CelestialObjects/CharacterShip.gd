extends CelestialObject
class_name CharacterShip

func is_class(value: String): return value == "CharacterShip" or .is_class(value)
func get_class() -> String: return "CharacterShip"

# Export variables
export(float) var thruster_force = 1 setget set_thruster_force, get_thruster_force

# Onready variables

# Variables
var _is_thrusting : int = 0
var _new_angle : float = 0.0 setget set_new_angle, get_new_angle


#### ACCESSORS ####
func set_thruster_force(new_value : float) -> void:
	if new_value != thruster_force:
		thruster_force = new_value
#		emit_signal()

func get_thruster_force() -> float:
	return thruster_force

func set_new_angle(new_value : float) -> void:
	if new_value != _new_angle:
		_new_angle = new_value
#		emit_signal()

func get_new_angle() -> float:
	return _new_angle


#### BUILT-IN ####
func _ready() -> void:
	pass

func _physics_process(_delta : float) -> void:
	apply_movement(_delta)

func _process(_delta : float) -> void:
	turn_ship()


#### VIRTUALS ####


#### LOGIC ####
func apply_movement(_delta : float) -> void:
	applied_force = applied_force.clamped(40.0)
	applied_force = applied_force.length() * Vector2(cos(_new_angle), sin(_new_angle))
#	printt(applied_force.length())

func turn_ship() -> void:
	set_new_angle(linear_velocity.angle())
	rotation = _new_angle


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
			add_central_force(Vector2(cos(_new_angle), sin(_new_angle)) * thruster_force)
		"MoveForward_Released":
			pass
		_:
			return


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body):
		if body.is_class("CelestialObject"):
			queue_free()
