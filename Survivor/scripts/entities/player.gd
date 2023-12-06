class_name Player
extends Unit

@export var _weapon_inventory: Array[Weapon];
@onready var _animations: AnimationPlayer = $AnimationPlayer
@onready var _weapon_handler: WeaponHandler = $WeaponHandler
@onready var _sprite: Sprite2D = $Sprite2D

var _active_weapon: Weapon;

func _init() -> void:
	unit_name = "Player"
	canInteract = true
	
func _ready() -> void:
	currentHealth = unit_stats.max_health
	_active_weapon = _weapon_inventory[0]
	_weapon_handler.set_active_weapon(_active_weapon)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta) -> void:
	handleInput()
	_updateAnimation()

func handleInput() -> void:
	var move_direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = move_direction * unit_stats.speed
	if move_direction.x > 0.1:
		_sprite.flip_h = false
	elif move_direction.x < -0.1:
		_sprite.flip_h = true

	if Input.is_action_pressed("shoot"):
		_shoot()

func _shoot() -> void:
	_weapon_handler.shoot()

func _updateAnimation() -> void:
	if velocity.length() == 0:
		if _animations.is_playing():
			_animations.stop()
	else:	
		var direction = "Right"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Right"
		_animations.play("walk" + direction)


func _on_hurt_box_hurt(damage):
	currentHealth -= damage
	print(currentHealth)
