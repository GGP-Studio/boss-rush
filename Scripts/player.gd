extends CharacterBody2D


@export var SPEED = 150.0
@export var JUMP_VELOCITY = -300.0
@export var health = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var katana_damage_area: CollisionShape2D = $DamagAareas/KatanaDamageArea
@onready var is_attaking: bool = false
const ARROW = preload("res://Scenes/arrow.tscn")

func ready() -> void:
	katana_damage_area.disabled = true

func take_damage(damage: int) -> void:
	animated_sprite.self_modulate = Color.DARK_RED
	health -= damage
	await get_tree().create_timer(0.2).timeout 
	animated_sprite.self_modulate = Color.WHITE
	
func katana_attack():
	is_attaking = true
	animated_sprite.play("attack")

	while animated_sprite.animation == "attack" and animated_sprite.frame <= 7:
		katana_damage_area.disabled = not (5 <= animated_sprite.frame)
		await get_tree().process_frame  # Czeka na kolejną klatkę gry

	katana_damage_area.disabled = true
	is_attaking = false
	
func bow_attack(direction):
	var arrow = ARROW.instantiate()
	arrow.position = position  + Vector2(direction*10, -16) 
	arrow.direction = Vector2(direction, 0)
	get_parent().add_child(arrow)

	
func die():
	print(self.name, " died")
	animated_sprite.play("death")
	set_physics_process(false)
	await get_tree().create_timer(1).timeout 
	get_tree().reload_current_scene()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("seppuku"):
		take_damage(10)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction := Input.get_axis("move_left", "move_right")
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attack"):
		katana_attack()
	if Input.is_action_just_pressed("arrow"):
		bow_attack(animated_sprite.scale.x)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.


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
	
