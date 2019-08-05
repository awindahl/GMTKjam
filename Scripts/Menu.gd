extends Node

func _ready():
	GameController._load()
	menuMusic.get_node("menuMusic").play(0)
	if GameController.gameWon:
		$Bg2.visible = true
	if GameController.hasSave:
		$Continue_Btn.visible = true

func _on_Quit_Btn_pressed():
	menuMusic.get_node("coin").play(0)
	get_tree().quit()

func _on_Options_Btn_pressed():
	menuMusic.get_node("coin").play(0)
	transition.fade_to("res://Scenes/Menu/Options.tscn", 0.9, "startSlide")

func _on_Continue_Btn_pressed():
	menuMusic.inMenu = false
	menuMusic.get_node("coin").play(0)
	transition.fade_to("res://Scenes/map.tscn", 0.9, "startSlide")

func _on_New_Btn_pressed():
	menuMusic.inMenu = false
	menuMusic.get_node("coin").play(0)
	GameController.level = 1
	GameController.score = 0
	GameController._save()
	transition.fade_to("res://Scenes/map.tscn", 0.9, "startSlide")
