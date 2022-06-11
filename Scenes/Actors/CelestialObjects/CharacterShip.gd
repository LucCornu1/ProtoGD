extends CelestialObject
class_name CharacterShip

func is_class(value: String): return value == "CharacterShip" or .is_class(value)
func get_class() -> String: return "CharacterShip"

# Export variables
export(float) var thruster_power = 10 setget set_thruster_power, get_thruster_power

# Onready variables

# Variables
var _new_angle : float = 0.0 setget set_new_angle, get_new_angle

var initial_thrusting_force : Vector2 = Vector2.ZERO setget set_initial_thrusting_force, get_initial_thrusting_force


#### ACCESSORS ####
func set_thruster_power(new_value : float) -> void:
	if new_value != thruster_power:
		thruster_power = new_value
#		emit_signal()

func get_thruster_power() -> float:
	return thruster_power

func set_new_angle(new_value : float) -> void:
	if new_value != _new_angle:
		_new_angle = new_value
#		emit_signal()

func get_new_angle() -> float:
	return _new_angle

func set_initial_thrusting_force(new_value : Vector2) -> void:
	if new_value != initial_thrusting_force:
		initial_thrusting_force = new_value
#		emit_signal()

func get_initial_thrusting_force() -> Vector2:
	return initial_thrusting_force


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
#	applied_force = applied_force.clamped(40.0)
	applied_force = initial_thrusting_force.length() * Vector2(cos(_new_angle), sin(_new_angle))

func turn_ship() -> void:
	set_new_angle(lerp(_new_angle, linear_velocity.angle(), 0.75))
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
			set_initial_thrusting_force(Vector2(cos(_new_angle), sin(_new_angle)) * thruster_power)
			
		"MoveForward_Released":
			pass
			
		_:
			return


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body):
		if body.is_class("CelestialObject"):
			queue_free()
