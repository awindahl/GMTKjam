extends Node

var block
var scene
export(int) var level = 1

func _ready():
	$Sprite.hide()
	GameController.box.append(self)
	scene = load("res://Scenes/PushableBlock.tscn")

func _spawn():
	if GameController.level == level:
		block = scene.instance()
		call_deferred('_add')

func _add():
	add_child(block)
