extends Node2D
class_name Wall

onready var particles = get_node("Particles2D")

const TYPE = "WALL"

func blow_up():
	particles.emitting = true
	$Timer.start()
	$Sprite.visible = false
	print("AA")

func _on_Timer_timeout():
	queue_free()
