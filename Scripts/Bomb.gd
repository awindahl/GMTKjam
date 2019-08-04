extends Node2D

onready var player = get_parent().get_node("Player")

func _ready():
	position = player.position
	position.y += 8

func _process(delta):
	if $Timer.time_left > 0:
		$Sprite.scale.x += $Timer.time_left * 0.01
		$Sprite.scale.y += $Timer.time_left * 0.01
	

func _on_Timer_timeout():
	$AnimationPlayer.play("explode")

func die():
	queue_free()
	
func explode():
	for body in $Area2D.get_overlapping_bodies():
		if body is Wall:
			body.blow_up()
		if body.get("TYPE") == "PLAYER":
			body._hit(position)
		if body.get("TYPE") == "ENEMY":
			body.hit(position)