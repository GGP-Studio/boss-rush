extends CharacterBody2D
@export var health = 50
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var item_scene: PackedScene 

func take_damage(damage: int) -> void:
	animated_sprite.self_modulate = Color.RED
	health -= damage
	print(health)
	await get_tree().create_timer(0.2).timeout 
	animated_sprite.self_modulate = Color.WHITE
	
func _physics_process(delta: float) -> void:
	if health <=0:
		die()

func drop_loot():
	var item = item_scene.instantiate()  
	item.position = position + Vector2(0, -3) 
	get_parent().add_child(item)
	
func die():
	print(self.name," died")
	animated_sprite.play("death")
	await animated_sprite.animation_finished
	set_physics_process(false)
	drop_loot()
	queue_free()
	
