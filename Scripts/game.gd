extends Node

var gameOver = false
var localScore = 0
onready var hud = $Camera2D/hud 
onready var level = GameController.level
onready var exit = get_node("door"+ str(level+1))

#set exit door to an "opened" sprite

func _ready():
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	set_exit(exit)
	updateHudScore(GameController.score)
	updateHudLevel(GameController.level)
	spawnEntities()

func panCam():
	print("new level pos: " + str(get_node(str(level)).get_node("cameraStart").global_position))
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position

func movePlayer():
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position

func set_exit(var door):
	door.get_node("StaticBody2D").set_collision_layer(4)
	door.get_node("StaticBody2D").set_collision_mask(4)

func reset_door(var door):
	door.get_node("StaticBody2D").set_collision_layer(1)
	door.get_node("StaticBody2D").set_collision_mask(1)
	
func _on_door1_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door1:
		print("you can not escape")

func _on_door2_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door2:
		updateLevel()

func _on_door3_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door3:
		updateLevel()

func _on_door4_area_entered(area):
	if area.get_name() == "hitbox" and exit == $door4:
		print("you win!")

func updateLevel():
	removeEntities()
	GameController.score = GameController+localScore
	localScore = 0
	level = level+1
	updateHudLevel()
	GameController.level = level
	GameController._save()
	spawnEntities()
	reset_door(exit)
	exit = get_node("door"+ str(level+1))
	set_exit(exit)
	panCam()
	movePlayer()
	

func restartLevel():
	removeEntities()
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	$Player._reset()
	if gameOver:
		gameOver = false
	localScore = 0
	spawnEntities()

func gameOver():
	gameOver = true
	hud.gameOver()

func equip(var item):
	hud.equip(item)

func updateHudScore(var num = 1):
	hud.addScore(num)
	
func updateHudLevel(var num = 1):
	hud.addLevel(num)

func removeEntities():
	for entity in GameController.coinSpawner:
		for coin in entity:
			coin.queue_free()
	for entity in GameController.enemy:
		for enemy in entity:
			enemy.queue_free()

func spawnEntities():
	for entity in GameController.coinSpawner:
		entity._spawn()
	for entity in GameController.enemy:
		entity._spawn()
