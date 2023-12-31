class_name Bullet
extends CharacterBody2D

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _visibility_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier
@onready var _death_timer: Timer = $DeathTimer

var direction: Vector2 = Vector2.RIGHT
var speed: float = 0.0
var damage: float = 0.0
var texture: Texture2D

func _ready() -> void:
	_visibility_notifier.connect("screen_exited", _on_screen_exited)
	_death_timer.connect("timeout", _on_death_timer_timeout)

	_sprite.texture = texture

func _physics_process(delta: float) -> void:
	move_and_collide(direction * speed * delta)

func _on_screen_exited() -> void:
	_death_timer.start(0.8)

func _on_death_timer_timeout() -> void:
	queue_free()

func initialize(projectile_info: Projectile, in_direction: Vector2) -> void:
	texture = projectile_info.sprite
	speed = projectile_info.speed
	damage = projectile_info.damage
	self.direction = in_direction