extends Button

func _on_Button_pressed():
	menuMusic.inMenu = true
	menuMusic.get_node("gameMusic").stop()
	GameController.clearEntityLists()
	transition.fade_to("res://Scenes/Menu/MainMenu.tscn")
