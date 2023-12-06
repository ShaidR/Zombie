class_name WeaponHandler
extends Node2D

@onready var _fire_timer: Timer = $FireTimer

var _active_weapon: Weapon;
var _can_fire: bool = false;

func _ready() -> void:
	_fire_timer.connect("timeout", _on_fire_timer_timeout)

func _on_fire_timer_timeout() -> void:
	_can_fire = true

func shoot(direction: Vector2) -> void:
	if _can_shoot():
		_can_fire = false
		print_debug("shooting ", direction)
		_fire_timer.start()

func _can_shoot() -> bool:
	return _active_weapon != null and _can_fire

func set_active_weapon(weapon: Weapon) -> void:
	_active_weapon = weapon
	# Note: If we allow manual swapping of weapon, we should preserve the fire
	# cooldown so players can't cheat.
	_fire_timer.wait_time = _active_weapon.fire_rate
	_can_fire = true
