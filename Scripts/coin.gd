extends Node

func _ready():
	pass # Replace with function body.

func _on_Area2D_area_entered(area):
	get_parent().get_parent().get_parent().updateHudScore(1)
	self.queue_free()
