extends Area2D
@onready var game_menager: Node = %GameMenager



func _on_body_entered(body: Node2D) -> void:
	game_menager.add_bone();
	

	queue_free()
