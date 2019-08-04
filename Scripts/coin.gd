extends Node

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		get_parent().get_parent().get_parent().updateHudScore()
		self.queue_free()
