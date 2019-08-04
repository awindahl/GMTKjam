extends Node

var coin
var scene
export(int) var level = 1

func _ready():
	GameController.coinSpawner.append(self)
	scene = load("res://Scenes/coin.tscn")

func _spawn():
	if GameController.level == level:
		coin = scene.instance()
		_add()

func _add():
	add_child(coin)
