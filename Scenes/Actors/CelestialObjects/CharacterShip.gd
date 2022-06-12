extends CelestialObject
class_name CharacterShip

func is_class(value: String): return value == "CharacterShip" or .is_class(value)
func get_class() -> String: return "CharacterShip"

# Export variables
export(float) var max_thruster_power = 35.0 setget set_max_thruster_power, get_max_thruster_power
export(float, 1.0, 10.0) var thruster_efficiency = 5.0 setget set_thruster_efficiency, get_thruster_efficiency
export(float) var max_fuel = 100.0 setget set_max_fuel, get_max_fuel
export(float, 1.0, 10.0) var fuel_consumption_rate = 5.0 setget set_fuel_consumption_rate, get_fuel_consumption_rate

# Onready variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
onready var animated_sprite : AnimatedSprite = get_node("AnimatedSprite")
onready var animated_sprite_material : Material = animated_sprite.get_material()

# Variables
var _new_angle : float = 0.0 setget set_new_angle, get_new_angle

var is_thrusting : bool = false setget set_is_thrusting, get_is_thrusting
var current_thruster_power : float = 0.0 setget set_current_thruster_power, get_current_thruster_power
var current_thrusting_force : Vector2 = Vector2.ZERO setget set_current_thrusting_force, get_current_thrusting_force

var current_fuel : float = max_fuel setget set_current_fuel, get_current_fuel

var is_dead : bool = false setget set_is_dead, get_is_dead

# Signals
signal is_dead_changed


#### ACCESSORS ####
func set_max_thruster_power(new_value : float) -> void:
	if new_value != max_thruster_power:
		max_thruster_power = new_value
#		emit_signal()

func get_max_thruster_power() -> float:
	return max_thruster_power

func set_thruster_efficiency(new_value : float) -> void:
	if new_value != thruster_efficiency:
		thruster_efficiency = new_value
#		emit_signal()

func get_thruster_efficiency() -> float:
	return thruster_efficiency

func set_max_fuel(new_value : float) -> void:
	if new_value != max_fuel:
		max_fuel = new_value
#		emit_signal()

func get_max_fuel() -> float:
	return max_fuel

func set_fuel_consumption_rate(new_value : float) -> void:
	if new_value != fuel_consumption_rate:
		fuel_consumption_rate = new_value
#		emit_signal()

func get_fuel_consumption_rate() -> float:
	return fuel_consumption_rate

func set_new_angle(new_value : float) -> void:
	if new_value != _new_angle:
		_new_angle = new_value
#		emit_signal()

func get_new_angle() -> float:
	return _new_angle

func set_is_thrusting(new_bool : bool) -> void:
	if new_bool != is_thrusting:
		is_thrusting = new_bool
#		emit_signal()

func get_is_thrusting() -> bool:
	return is_thrusting

func set_current_thruster_power(new_value : float) -> void:
	if new_value != current_thruster_power:
		current_thruster_power = new_value
#		emit_signal()

func get_current_thruster_power() -> float:
	return current_thruster_power

func set_current_thrusting_force(new_value : Vector2) -> void:
	if new_value != current_thrusting_force:
		current_thrusting_force = new_value
#		emit_signal()

func get_current_thrusting_force() -> Vector2:
	return current_thrusting_force

func set_current_fuel(new_value : float) -> void:
	if new_value != current_fuel:
		current_fuel = new_value
#		emit_signal()

func get_current_fuel() -> float:
	return current_fuel

func set_is_dead(new_value : bool) -> void:
	if new_value != is_dead:
		is_dead = new_value
		emit_signal("is_dead_changed")

func get_is_dead() -> bool:
	return is_dead


#### BUILT-IN ####
func _ready() -> void:
#	init_shaders()
	var __ = connect("is_dead_changed", self, "_on_is_dead_changed")
	
	_new_angle = rotation
#	current_thruster_power = 20

func _physics_process(_delta : float) -> void:
	_compute_thrusting_force(_delta)

func _process(_delta : float) -> void:	
	turn_ship()
#	print(current_thrusting_force.length())


#### VIRTUALS ####
func _compute_forces(_delta : float) -> void:
	if is_dead:
		linear_velocity = Vector2.ZERO
		applied_force = Vector2.ZERO
		return
	._compute_forces(_delta)
	
	applied_force = current_thrusting_force.length() * Vector2(cos(_new_angle), sin(_new_angle)) + current_gravity_force
###	applied_force = applied_force.clamped(80.0) #DO NOT DELETE !! This as for effect to make orbiting 100x easier at the cost of realism


#### LOGIC ####
func _compute_thrusting_force(_delta : float) -> void:	
	if is_thrusting and current_fuel > 0:
		set_current_thruster_power(current_thruster_power + _delta * thruster_efficiency)
		set_current_fuel(clamp(current_fuel - _delta * fuel_consumption_rate, 0.0, max_fuel))
	elif current_gravity_force.length_squared() > 0:
		var scalaire = current_thrusting_force.normalized().dot(current_gravity_force.normalized())
		set_current_thruster_power(current_thruster_power + scalaire * _delta)
#		print(scalaire * _delta)
#		print(current_thruster_power)
	set_current_thrusting_force(Vector2(cos(_new_angle), sin(_new_angle)) * current_thruster_power)

func turn_ship() -> void:
	if !is_dead:
		set_new_angle(linear_velocity.angle()) #lerp(_new_angle, linear_velocity.angle(), 0.75))
	rotation = _new_angle

func init_shaders() -> void:
	var noise = OpenSimplexNoise.new()
	# Configure
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	animated_sprite_material.set_shader_param("dissolveNoise", noise.get_image(512, 512))

func restart_scene() -> void:
	get_tree().reload_current_scene()


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
			set_is_thrusting(true)
			
		"MoveForward_Released":
			set_is_thrusting(false)
			
		_:
			return


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body):
		if body.is_class("CelestialObject"):
			set_is_dead(true)

func _on_is_dead_changed() -> void:
	if is_dead:
		animation_player.play("Death")
