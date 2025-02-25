extends CharacterBody2D


@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0
@export var health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var katana_damage_area: CollisionShape2D = $DamagAareas/KatanaDamageArea
@onready var is_attaking: bool = false

func ready() -> void:
	katana_damage_area.disabled = true

func take_damage(damage: int) -> void:
	health -= damage
	
func katana_attack():
	is_attaking = true
	katana_damage_area.disabled = false
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	katana_damage_area.disabled = true
	is_attaking =false
	
	
func die():
	print(self.name, " died")
	animated_sprite.play("death")
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
		katana_attack()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		if !is_attaking:
			animated_sprite.play("run")
		animated_sprite.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if !is_attaking:
			animated_sprite.play("idle")
	

	move_and_slide()
	if health <=0:
		die()
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.take_damage(10)
	
