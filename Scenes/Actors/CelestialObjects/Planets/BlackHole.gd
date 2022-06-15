extends BasePlanet
class_name BlackHole

func is_class(value: String): return value == "BlackHole" or .is_class(value)
func get_class() -> String: return "BlackHole"


# Export variables

# Onready variables
onready var event_horizon : Area2D = get_node("EventHorizon")

# Variables

# Signals


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	var __ = event_horizon.connect("body_entered", self, "_on_event_horizon_body_entered")

func _physics_process(_delta : float) -> void:
	pass

func _process(_delta : float) -> void:
	pass


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_event_horizon_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body) and body != self:
		body.set_is_sucked(true)
