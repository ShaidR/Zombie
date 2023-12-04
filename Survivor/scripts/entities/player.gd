class_name Player
extends Unit

@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var walkBox = $walkBox
@onready var hurtBox = $hurtBox

func _init():
	unit_name = "Player"
	canInteract = true
	
func _ready() -> void:
	currentHealth = unit_stats.maxHealth
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta) -> void:
	handleInput()
	_updateAnimation()

func handleInput() -> void:
	var moveDirection = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity = moveDirection * unit_stats.speed

	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _shoot() -> void:
	#TODO: Create weapon class
	#TODO: Create 3 weapons
	#TODO: Add 3 weapons to player's inventory
	#TODO: Setup active weapon
	#TODO: Shoot weapon
	print_debug("shoot")

func _updateAnimation() -> void:
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:	
		var direction = "Right"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Right"
		animations.play("walk" + direction)
