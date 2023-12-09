class_name Player
extends Unit

@export var _weapon_inventory: Array[Weapon];
@onready var _animations: AnimationPlayer = $AnimationPlayer
@onready var _weapon_handler: WeaponHandler = $WeaponHandler
@onready var _sprite: Sprite2D = $Sprite2D

var _active_weapon_index: int;

func _init() -> void:
	unit_name = "Player"
	canInteract = true
	
func _ready() -> void:
	currentHealth = unit_stats.max_health
	_active_weapon_index = 0 
	_weapon_handler.set_active_weapon(_weapon_inventory[_active_weapon_index])
	GameSignalBus.cycle_weapon.connect(_cycle_weapon)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta) -> void:
	_handleInput()
	_updateAnimation()

func _handleInput() -> void:
	var move_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction * unit_stats.speed
	if move_direction.x > 0.1:
		_sprite.flip_h = false
	elif move_direction.x < -0.1:
		_sprite.flip_h = true

	if Input.is_action_pressed("shoot"):
		var shoot_direction: Vector2 = Vector2.LEFT if  _sprite.flip_h else Vector2.RIGHT
		_shoot(shoot_direction)

func _shoot(move_direction: Vector2) -> void:
	_weapon_handler.shoot(move_direction)

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

func _on_body_entered_hurt_area(body: Node2D):
	if body.is_in_group("enemies"):
		var enemy = body as Unit 
		if enemy:
			_damage(enemy.unit_stats.damage)

func _damage(damage: float) -> void:
	currentHealth -= damage
	print(currentHealth)
	# TODO: Check for game over and fire event

func _cycle_weapon() -> void:
	_active_weapon_index = (_active_weapon_index + 1) % _weapon_inventory.size()
	
	_weapon_handler.set_active_weapon(
		_weapon_inventory[_active_weapon_index])