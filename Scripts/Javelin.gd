extends Area2D

const SPEED = 10
var forward_dir = Vector2()

onready var player = get_parent().get_node("Player")

func _ready():
	position = player.position
		
	if player.facing == 'right':
		forward_dir = Vector2(1,0)
		$Sprite.flip_h = true
	elif player.facing == 'left':
		forward_dir = Vector2(-1,0)
		$Sprite.flip_h = false
	
func _process(delta):
	global_translate(forward_dir * SPEED)

func _on_TimeToLive_timeout():
	queue_free()

func _on_Javelin_body_entered(body):
	if body.get("TYPE") == "ENEMY":
		body.hit(position)