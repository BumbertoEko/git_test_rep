extends Area2D

func _on_body_entered(body):
	queue_free()
	Global.health = Global.health + 10
