extends Node2D

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		if not body.armed and not body.ammo:
			menuMusic.get_node("pickup").play(0)
			body.bombs = 1
			body.get_parent().equip("BOMB")
			queue_free()
