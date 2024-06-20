extends Node

@onready var health_pickup_scene = preload("res://Scenes/health_pickup.tscn")
@onready var player = $"../Player"

var player_pos

func _on_timer_for_health_pick_gen_timeout():
	player_pos = player.position
	spawn_in(Vector2(randf_range(-400, 400), randf_range(-400, 400)))

func spawn_in(cords):
	var inst = health_pickup_scene.instantiate()
	add_child(inst)
	var new_position = player_pos + cords
	inst.position = new_position
