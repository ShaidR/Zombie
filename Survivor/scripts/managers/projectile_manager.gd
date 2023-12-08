class_name ProjectileManager
extends Node

@onready var _base_bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
@onready var projectile_container: Node = $ProjectileContainer

func _ready():
	GameSignalBus.fire_projectile.connect(fire_projectile)

func fire_projectile(projectile_info: Projectile, position: Vector2, direction: Vector2):
	var bullet: Bullet = _base_bullet_scene.instantiate()
	bullet.global_position = position
	bullet.initialize(projectile_info, direction)

	projectile_container.add_child(bullet)