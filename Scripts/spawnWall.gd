extends Node

var wall
var scene
export(int) var level = 1

func _ready():
	$Sprite.hide()
	GameController.wall.append(self)
	scene = load("res://Scenes/DestructibleWall.tscn")

func _spawn():
	if GameController.level == level:
		wall = scene.instance()
		call_deferred('_add')

func _add():
	add_child(wall)
