extends Node2D

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		if not body.armed and not body.bombs:
			body.ammo = 1
			body.get_parent().equip("JAVELIN")
			queue_free()
