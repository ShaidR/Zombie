class_name HealthBar
extends TextureProgressBar

func _init() -> void:
	GameSignalBus.health_changed.connect(_on_player_health_changed)

func _on_player_health_changed(currentHealth, maxHealth):
	value = currentHealth / maxHealth * 100.0 
