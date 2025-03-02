extends Area2D
const SPEED = 200
var direction = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
@onready var sprite: Sprite2D = $Sprite
@export var time = 100
func _ready() -> void:
	rotation_degrees = 90-90*direction.x



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= 1
	position += direction * SPEED * delta
	if time <= 0:
		queue_free()



func _on_colision(body: Node2D) -> void:
	
	if body.name != "Map":
		print(body.name)
		body.take_damage(10)
	queue_free()
