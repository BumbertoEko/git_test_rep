extends CharacterBody2D

const SPEED = 500.0
var health_display = str("Health: ")
@onready var game_over_screen = preload("res://game_over.tscn")
@onready var world = $".."
@onready var cpu_particles_2d = preload("res://health_pickup_particles.tscn")

#-------------------------------------------------------------------------------- movement
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y = Input.get_axis("Up", "Down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if Global.player_life_state == true:
		velocity = velocity.normalized() * SPEED
		move_and_slide()
	
	#--------------------------------------------------- movement

func _process(delta):
	
	if Global.got_health == true:
		var cpu_inst = cpu_particles_2d.instantiate()
		add_child(cpu_inst) 
		print("shot")
	Global.got_health = false
	
	if Global.health < 0:
		Global.player_life_state = false
	
	if Global.player_life_state == false:
		print("dead")
		var game_restart = game_over_screen.instantiate()
		var total = get_viewport().size
		total = total / 2
		$".".position = total
		add_child(game_restart)
	
	$ProgressBar.value = Global.health
	Global.health = clamp(Global.health, 0, 100)

func _ready():
	$"../RichTextLabel".text = health_display

func _on_timer_timeout():
	Global.health = Global.health - 1
	$Timer.start()
	health_display = str("Health: ") + str(Global.health)
	$"../RichTextLabel".text = health_display 

func _input(event):
		if event.is_action_pressed("R"):
			Global.player_life_state = true
			print("restart")
			get_tree().reload_current_scene()
			Global.health = 100


func _on_for_particl_timeout():
	var cpu_inst = cpu_particles_2d.instantiate()
	remove_child(cpu_inst)
