extends Node

func _ready():
	if GameController.level != 1:
		$Continue_Btn.visible = true
	#check if savefile exists
	#if it does - show continueBtn and load right data for it

func _on_Quit_Btn_pressed():
	get_tree().quit()


func _on_Options_Btn_pressed():
	transition.fade_to("res://Scenes/Menu/Options.tscn", 0.9, "startSlide")


func _on_Continue_Btn_pressed():
	transition.fade_to("res://Scenes/map.tscn", 0.9, "startSlide")


func _on_New_Btn_pressed():
	transition.fade_to("res://Scenes/map.tscn", 0.9, "startSlide")
	#delete current save if it exists
