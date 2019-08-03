extends Area2D

const SPEED = 10
var forward_dir = Vector2()

func _process(delta):
	var player = get_parent()
	
	if player.get_node("Sprite").flip_h:
		print("left")
		forward_dir = Vector2(-1,0)
	elif not player.get_node("Sprite").flip_h:
		forward_dir = Vector2(1,0)
		print("right")
		
	global_translate(forward_dir * SPEED)

func _on_TimeToLive_timeout():
	queue_free()

func _on_Javelin_body_entered(body):
	if body is Enemy:
		pass
		#body.hit()