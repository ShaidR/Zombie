class_name Enemy
extends Unit

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer

func _ready():
	anim.play("walk")
	currentHealth = unit_stats.max_health

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * unit_stats.speed
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true


func _on_hurt_box_hurt(damage):
	currentHealth -= damage
	print(currentHealth)
	if currentHealth <= 0:
		queue_free()
