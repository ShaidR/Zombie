extends Node

signal fire_projectile(projectile_info: Projectile, position: Vector2, direction: Vector2)
signal cycle_weapon()

signal health_changed(currentHealth, maxHealth)

signal enemy_killed