extends Node2D
class_name LevelExit

func is_class(value: String): return value == "LevelExit" or .is_class(value)
func get_class() -> String: return "LevelExit"


# Export variables
export(PackedScene) var next_level
export(String) var next_level_name

# Onready variables
onready var area_2D : Area2D = get_node("Area2D")

# Variables

# Signals


#### ACCESSORS ####


#### BUILT-IN ####
func _ready() -> void:
	var __ = area_2D.connect("body_entered", self, "_on_body_entered")

func _physics_process(_delta : float) -> void:
	pass

func _process(_delta : float) -> void:
	pass


#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####
func _on_body_entered(body : PhysicsBody2D) -> void:
	if is_instance_valid(body):
		if body.is_class("CharacterShip"):
			if next_level != null:
				Singleton.level_name = next_level_name
				get_tree().change_scene_to(next_level)
			else:
				get_tree().change_scene("res://Scenes/Levels/GameLevels/Menu.tscn")
