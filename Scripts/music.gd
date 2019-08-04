extends Node

var inMenu = true
func _ready():
	pass # Replace with function body.

func _on_gameMusic_finished():
	if not inMenu:
		$gameMusic.play(0)

func _on_menuMusic_finished():
	if inMenu:
		$menuMusic.play(0)
