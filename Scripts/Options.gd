extends Node

func _ready():
	pass # Replace with function body.

func _on_GoldenGit_pressed():
	OS.shell_open("https://github.com/awindahl");


func _on_GoldenItch_pressed():
	OS.shell_open("https://goldenapples.itch.io/");


func _on_SumGit_pressed():
	OS.shell_open("https://github.com/Sumaris");


func _on_SumItch_pressed():
	OS.shell_open("https://sumaris.itch.io/");


func _on_Back_Btn_pressed():
	transition.fade_to("res://Scenes/Menu/MainMenu.tscn", 0.9, "startSlide")
