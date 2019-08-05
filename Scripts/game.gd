extends Node

var gameOver = false
var localScore = 0
onready var hud = $CanvasLayer/hud 
onready var level = GameController.level
onready var player = GameController.player
onready var exit = get_node("door"+ str(level+1))

#	remember to go to Export, 
#	then the resources tab and set the export mode to 
#	Export all resources in the project to 
#	make godot include the JSON file in the build

func _ready():
	$Camera2D.global_position = get_node(str(level)).get_node("cameraStart").global_position
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	set_exit(exit)
	menuMusic.get_node("gameMusic").play(0)
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
	

func _on_door2_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door2:
		updateLevel()

func _on_door3_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door3:
		updateLevel()

func _on_door4_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door4:
		updateLevel()

func _on_door5_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door5:
		updateLevel()
		
func _on_door6_body_entered(body):
	if body.get("TYPE") == "PLAYER" and exit == $door6:
		removeEntities()
		transition.fade_to("res://Scenes/Game Over.tscn", 0.9)

func updateLevel():
	menuMusic.get_node("win").play(0)
	removeEntities()
	GameController.score += localScore
	hud.updateScore(GameController.score)
	localScore = 0
	level = level+1
	updateHudLevel()
	player.ammo = 0
	player.bombs = 0
	player.armed = false
	hud.equip("UNARMED")
	GameController.level = level
	GameController._save()
	spawnEntities()
	reset_door(exit)
	exit = get_node("door"+ str(level+1))
	set_exit(exit)
	panCam()
	movePlayer()
	$Player._reset()

func restartLevel():
	removeEntities()
	$Player.global_position = get_node(str(level)).get_node("playerStart").global_position
	$Player._reset()
	hud.equip("UNARMED")
	if gameOver:
		gameOver = false
	localScore = 0
	hud.updateScore(GameController.score + localScore)
	spawnEntities()

func gameOver():
	menuMusic.get_node("hurt").play(0)
	gameOver = true
	hud.gameOver()

func equip(var item):
	hud.equip(item)

func updateHudScore(var num = 1):
	localScore += num;
	hud.addScore(num)
	
func updateHudLevel(var num = 1):
	hud.addLevel(num)

func removeEntities():
	for entity in GameController.coinSpawner:
		for coin in entity.get_children():
			if not str(coin.get_name()).match("Position2D"):
				coin.call_deferred('free') 
	for entity in GameController.enemy:
		for enemy in entity.get_children():
			if not str(enemy.get_name()).match("Position2D") and not str(enemy.get_name()).match("Sprite"):
				enemy.call_deferred('free') 
	for entity in GameController.box:
		for box in entity.get_children():
			if not str(box.get_name()).match("Sprite"):
				box.call_deferred('free') 
	for entity in GameController.wall:
		for wall in entity.get_children():
			if not str(wall.get_name()).match("Sprite"):
				wall.call_deferred('free')

func spawnEntities():
	for entity in GameController.coinSpawner:
		entity._spawn()
	for entity in GameController.enemy:
		entity._spawn()
	for entity in GameController.box:
		entity._spawn()
	for entity in GameController.wall:
		entity._spawn()
