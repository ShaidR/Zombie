extends Control

@onready var killLabel = $Panel/HBoxContainer/KillsLabel
@onready var weaponLabel = $Panel/HBoxContainer/WeaponLabel
func _ready():
	killLabel.text = "KILLS: " + str(GameManager.kills)
	weaponLabel.text = "WEAPON: " + GameManager.weapon 
	
func _on_enemy_killed():
	_ready()
	
func _on_player_health_changed(currentHealth, maxHealth):
	pass # Replace with function body.
