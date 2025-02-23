extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	var state := $AnimatedSprite2D
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("game_attack"):
		state.animation = "attack"
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		state.animation = "run"
		state.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		state.animation = "idle"
		

	move_and_slide()
