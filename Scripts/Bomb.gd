extends Node2D

func _process(delta):
	if $Timer.time_left > 0:
		$Sprite.scale.x += $Timer.time_left * 0.01
		$Sprite.scale.y += $Timer.time_left * 0.01

func _on_Timer_timeout():
	$AnimationPlayer.play("explode")

func die():
	queue_free()