extends Node2D

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		if not body.armed and not body.ammo:
			body.bombs = 1
			queue_free()