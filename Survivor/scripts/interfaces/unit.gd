class_name Unit
extends CharacterBody2D

# Signals
signal healthChanged

# Variables
var unit_name = " "
var canInteract : bool = true
var isHurt : bool = false

@onready var currentHealth: float
@export var hurt_timer : Timer
@export var unit_stats: UnitStats

func _ready() -> void:
	pass
func _on_hurt_timer_timeout() -> void:
	pass
func _on_hurt_box_body_exited(_body) -> void:
	pass

func is_alive() -> bool:
	return currentHealth > 0
