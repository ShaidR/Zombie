class_name HealthBar
extends TextureProgressBar

func _on_player_health_changed(currentHealth, maxHealth):
	value = currentHealth / maxHealth * 100.0 
