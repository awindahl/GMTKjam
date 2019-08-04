extends Area2D

const SPEED = 10
var forward_dir = Vector2()

onready var player = get_parent().get_node("Player")

func _ready():
	position = player.position
		
	if player.get_node("Sprite").flip_h:
		forward_dir = Vector2(-1,0)
		$Sprite.flip_h = false
	elif not player.get_node("Sprite").flip_h:
		forward_dir = Vector2(1,0)
	
	
func _process(delta):
	global_translate(forward_dir * SPEED)

func _on_TimeToLive_timeout():
	queue_free()

func _on_Javelin_body_entered(body):
	if body is Enemy:
		body.hit(position)