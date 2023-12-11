extends Control

@onready var killLabel = $Panel/HBoxContainer/KillsLabel
@onready var weaponLabel = $Panel/HBoxContainer/WeaponLabel
@onready var timerLabel = $Panel/HBoxContainer/TimerLabel
@onready var wcm = $"../WeaponCycleManager" as WeaponCycleManager

func _init() -> void:
	GameSignalBus.enemy_killed.connect(_on_enemy_killed)

func _ready():
	_reset()
	
func _process(_delta: float):
	var timer = wcm._weapon_cycle_timer
	timerLabel.text = "TIME LEFT: %02d" % timer.time_left
	
func _on_enemy_killed():
	_reset()

func _reset() -> void:
	killLabel.text = "KILLS: " + str(GameManager.kills)
	weaponLabel.text = "WEAPON: " + GameManager.weapon
	timerLabel.text = "TIME LEFT: " + str(GameManager.timer)