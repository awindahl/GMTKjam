extends Node

func _ready():
	pass # Replace with function body.

func _on_AudioStreamPlayer_finished():
	get_node("/root/menuMusic").play(0)

func _on_gameMusic_finished():
	$gameMusic.play(0)
