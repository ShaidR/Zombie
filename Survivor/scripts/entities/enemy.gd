class_name Enemy
extends Unit

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

signal enemy_killed

func _ready() -> void:
	anim.play("walk")
	currentHealth = unit_stats.max_health

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * unit_stats.speed
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true

func _on_body_entered_hurt_area(body: Node2D):
	if body.is_in_group("projectiles"):
		var bullet = body as Bullet
		if bullet:
			_damage(bullet.damage)
			bullet.queue_free()

func _damage(damage: float) -> void:
	currentHealth -= damage
	print(currentHealth)
	if currentHealth <= 0:
		GameManager.kills += 1
		emit_signal("enemy_killed")
		queue_free()
