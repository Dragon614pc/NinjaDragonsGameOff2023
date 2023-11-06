extends CharacterBody2D

signal sword_hit
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var can_attack = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	if Input.is_action_just_pressed("Attack") and can_attack:
		can_attack = false
		$Sword/SwordShape.disabled = false # enable attack hitbox
		print("attack")
		$Sword/SwordTimer.start() # starts attack cooldown
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_sword_timer_timeout(): # when sword cooldown ends
	$Sword/SwordShape.disabled = true
	can_attack = true
	


func _on_sword_body_entered(body):
	#print("hit")
	sword_hit.emit()
	




func _on_area_2d_body_entered(body):
	get_tree().reload_current_scene()
