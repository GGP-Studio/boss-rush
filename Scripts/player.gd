extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func take_damage(damage: int) -> void:
	health -= damage
	
		
func die():
	print("i've died")
	animated_sprite.animation="death"
	set_physics_process(false)
	timer.start()
	
		
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("seppuku"):
		take_damage(10)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attack"):
		animated_sprite.animation = "attack"
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		animated_sprite.animation = "run"
		animated_sprite.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.animation = "idle"
	

	move_and_slide()
	if health <=0:
		die()
		
