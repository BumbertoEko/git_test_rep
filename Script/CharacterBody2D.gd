extends CharacterBody2D

const SPEED = 500.0
var health = 100.0

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
	
	
	velocity = velocity.normalized() * SPEED
	move_and_slide()
	
	#--------------------------------------------------- movement
	
	$ProgressBar.value = health
	
	if health < 0:
		print("dead")

func _on_timer_timeout():
	health = health - 0.5
	$Timer.start()
