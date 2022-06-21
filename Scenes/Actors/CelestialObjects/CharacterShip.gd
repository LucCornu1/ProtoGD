extends CelestialObject
class_name CharacterShip

func is_class(value: String): return value == "CharacterShip" or .is_class(value)
func get_class() -> String: return "CharacterShip"

# Export variables
export(float) var max_thruster_power = 50.0 setget set_max_thruster_power, get_max_thruster_power
export(float, 1.0, 10.0) var thruster_efficiency = 5.0 setget set_thruster_efficiency, get_thruster_efficiency
export(float) var max_fuel = 100.0 setget set_max_fuel, get_max_fuel
export(float, 1.0, 10.0) var fuel_consumption_rate = 5.0 setget set_fuel_consumption_rate, get_fuel_consumption_rate

# Onready variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")
onready var animated_sprite : AnimatedSprite = get_node("AnimatedSprite")
onready var animated_sprite_material : Material = animated_sprite.get_material()
onready var hud_node : CanvasLayer = get_node("HUD")
onready var restart_button : Option = get_node_or_null("HUD/AlwaysOnScreen/HBoxContainer/RestartOption")

# Variables
var _new_angle : float = 0.0 setget set_new_angle, get_new_angle
var _is_charging : bool = false
var _is_valid : bool = true
var _level_ready : bool = false

var current_thruster_power : float = 0.0 setget set_current_thruster_power, get_current_thruster_power
var current_thrusting_force : Vector2 = Vector2.ZERO setget set_current_thrusting_force, get_current_thrusting_force

var current_fuel : float = max_fuel setget set_current_fuel, get_current_fuel

var is_dead : bool = false setget set_is_dead, get_is_dead
var is_launched : bool = false setget set_is_launched, get_is_launched

# Signals
signal is_dead_changed
signal is_launched_changed


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

func set_is_launched(new_value : bool) -> void:
	if new_value != is_launched:
		is_launched = new_value
		emit_signal("is_launched_changed", is_launched)

func get_is_launched() -> bool:
	return is_launched


#### BUILT-IN ####
func _ready() -> void:
#	init_shaders()
	var __ = connect("is_dead_changed", self, "_on_is_dead_changed")
	__ = hud_node.connect("is_hovered_changed", self, "_on_is_hovered_changed")
	
	if is_instance_valid(restart_button):
		__ = restart_button.connect("Restart", self, "restart_scene")
#	__ = connect("is_launched_changed", self, "_on_is_launched_changed", [is_launched])
	
	animation_player.play("RESET")
	_new_angle = rotation

func _physics_process(_delta : float) -> void:
	_compute_thrusting_force(_delta)

func _process(_delta : float) -> void:
	if _is_charging:
		_charging(_delta)
	
	turn_ship()
	check_distance()
#	print(applied_force.length())
#	print(current_thrusting_force.length())


#### VIRTUALS ####
func _compute_forces(_delta : float) -> void:
	if is_dead or !is_launched:
		linear_velocity = Vector2.ZERO
		applied_force = Vector2.ZERO
		return
	._compute_forces(_delta)
	
	if !is_sucked:
		applied_force = current_thrusting_force.length() * Vector2(cos(_new_angle), sin(_new_angle)) + current_gravity_force
###	applied_force = applied_force.clamped(80.0) #DO NOT DELETE !! This as for effect to make orbiting 100x easier at the cost of realism


#### LOGIC ####
func _compute_thrusting_force(_delta : float) -> void:
	if current_gravity_force.length_squared() > 0:
		var scalaire = current_thrusting_force.normalized().dot(current_gravity_force.normalized())
		set_current_thruster_power(current_thruster_power + scalaire * _delta)
#		print(scalaire * _delta)
#		print(current_thruster_power)
	set_current_thrusting_force(Vector2(cos(_new_angle), sin(_new_angle)) * current_thruster_power)

func turn_ship() -> void:
	if is_dead:
		return
		
	if is_launched and linear_velocity != Vector2.ZERO:
		set_new_angle(linear_velocity.angle()) #lerp(_new_angle, linear_velocity.angle(), 0.75))
	else:
		var mouse_pos : Vector2 = get_viewport().get_mouse_position()
		var direction : Vector2 = position.direction_to(mouse_pos)
		_new_angle = direction.angle()
	
	rotation = _new_angle

func check_distance() -> void:
	if position.x < -150.0 or position.x > 2070.0:
		restart_scene()
	
	if position.y < -150.0 or position.y > 1230.0:
		restart_scene()

func _charging(_delta : float) -> void:
	set_current_thruster_power(clamp(current_thruster_power + _delta * 10.0, 0.0, max_thruster_power))
#	print("Power" + str(current_thruster_power))
	
	var charge : float = current_thruster_power / max_thruster_power
#	print("Charge" + str(charge))
	animated_sprite_material.set_shader_param("charge", charge)

func restart_scene() -> void:
	var image : Image = get_viewport().get_texture().get_data()
	image.flip_y()
	Singleton.screenshot = ImageTexture.new()
	Singleton.screenshot.create_from_image(image)
	
	get_tree().reload_current_scene()


#### INPUTS ####
func _input(event : InputEvent) -> void:
	if !Singleton.level_ready:
		return
	var action_name : String = ""
	
	if event.is_action_pressed("player_forward"):
		action_name = "MoveForward_Pressed"
	
	elif event.is_action_released("player_forward"):
		action_name = "MoveForward_Released"
	
	elif event.is_action_pressed("reset"):
		action_name = "reset_level"
	
	if action_name != "": action(action_name)

func action(action_name : String) -> void:
	match(action_name):
		"MoveForward_Pressed":
			if !is_launched and _is_valid:
				_is_charging = true
		
		"MoveForward_Released":
			if !is_launched and _is_valid:
				set_is_launched(true)
				_is_charging = false
				animated_sprite_material.set_shader_param("charge", 0.0)
	#			particles_2D.set_emitting(true)
		
		"reset_level":
			restart_scene()
		
		_:
			return


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body):
		if body.is_class("CelestialObject"):
			set_is_dead(true)

func _on_is_dead_changed() -> void:
	if is_dead:
		set_is_launched(false)
		animation_player.play("Death")

func _on_is_hovered_changed(value : bool) -> void:
	_is_valid = !value
