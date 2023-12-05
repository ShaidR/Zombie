class_name HealthBar
extends TextureProgressBar

@export var unit: Unit

func _ready():
	unit.healthChanged.connect(update)
	update()

func update():
	value = unit.currentHealth * 100.0 / unit.unit_stats.max_health
