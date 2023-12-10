class_name WeaponCycleManager
extends Node

@onready var _weapon_cycle_timer = $WeaponCycleTimer

func _ready() -> void:
	_weapon_cycle_timer.autostart = true
	_weapon_cycle_timer.connect("timeout", _on_weapon_cycle_timer_timeout)
	
func _on_weapon_cycle_timer_timeout() -> void:
	GameSignalBus.cycle_weapon.emit()
