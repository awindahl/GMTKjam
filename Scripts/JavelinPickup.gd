extends Node2D

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		body.ammo = 1
		queue_free()