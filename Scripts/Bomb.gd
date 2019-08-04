extends Node2D

func _process(delta):
	if $Timer.time_left > 0:
		$Sprite.scale.x += $Timer.time_left * 0.01
		$Sprite.scale.y += $Timer.time_left * 0.01
	

func _on_Timer_timeout():
	$AnimationPlayer.play("explode")

func die():
	queue_free()
	
func explode():
	menuMusic.get_node("explode").play(0)
	for body in $Area2D.get_overlapping_bodies():
		if body.get("TYPE") == "WALL":
			body.blow_up()
		if body.get("TYPE") == "PLAYER":
			body._hit(position)
		if body.get("TYPE") == "ENEMY":
			body.hit(position)
