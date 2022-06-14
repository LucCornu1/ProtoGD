extends Node2D
class_name ParticleHandler

func is_class(value: String): return value == "ParticleHandler" or .is_class(value)
func get_class() -> String: return "ParticleHandler"


# Export variables

# Onready variables
onready var particles_2D : Particles2D = get_node("Particles2D")

# Variables

# Signals


#### ACCESSORS ####


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_playership_launched(value : bool) -> void:
	particles_2D.set_emitting(value)
