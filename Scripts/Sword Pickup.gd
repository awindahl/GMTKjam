extends Node2D

var startTimer = true

func _on_Area2D_body_entered(body):
	if body is Player and not body.armed and body.ammo == 0 and body.bombs == 0:
		menuMusic.get_node("pickup").play(0)
		body.armed = true
		body.get_parent().equip("SWORD")
		$Sprite.frame = 1
	
func _process(delta):
	if not GameController.player.armed and $Sprite.frame == 1 and startTimer:
		startTimer = false
		$Timer.start()

func _on_Timer_timeout():
	$Sprite.frame = 0
	startTimer = true
