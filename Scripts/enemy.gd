extends CharacterBody2D
var health = 50
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var item_scene: PackedScene 
func take_damage(damage: int) -> void:
	health -= damage
	print(health)
	
func _physics_process(delta: float) -> void:
	if health <=0:
		die()

func drop_loot():
	var item = item_scene.instantiate()  # Tworzy nowy przedmiot
	item.position = position  # Ustawia go w miejscu śmierci przeciwnika
	get_parent().add_child(item) # Dodaje go do sceny
	
func die():
	print(self.name," died")
	animated_sprite.animation="death"
	set_physics_process(false)
	drop_loot()
	queue_free()
