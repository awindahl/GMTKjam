extends Node

var coin
export(int) var level = 1

func _ready():
	GameController.coinSpawner.append(self)
	var scene = load("res://Scenes/coin.tscn")
	coin = scene.instance()

func _spawn():
	if GameController.level == level:
		add_child(coin)
