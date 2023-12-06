extends Area2D

@export var damage = 1

@onready var collision = $hitShape
@onready var disableTimer = $hitTimer

func tempdisable():
	collision.call_deferred("set","disabled",true)
	disableTimer.start()

func _on_hit_timer_timeout():
	collision.call_deferred("set","disabled",false)
