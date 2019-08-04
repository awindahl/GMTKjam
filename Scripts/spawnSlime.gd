extends Node

var enemy
var scene
export(int) var level = 1

func _ready():
	GameController.enemy.append(self)
	scene = load("res://Scenes/Slime.tscn")

func _spawn():
	if GameController.level == level:
		enemy = scene.instance()
		_add()

func _add():
	add_child(enemy)
