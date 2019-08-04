extends Node2D

onready var player = get_parent().get_parent().get_node("Player")
var startTimer = true

func _on_Area2D_body_entered(body):
	if body is Player and not body.armed and not body.ammo and not body.bombs:
		body.armed = true
		$Sprite.frame = 1
	
func _process(delta):
	if not player.armed and $Sprite.frame == 1 and startTimer:
		startTimer = false
		print("OO")
		$Timer.start()

func _on_Timer_timeout():
	$Sprite.frame = 0
	print("AA")
	startTimer = true