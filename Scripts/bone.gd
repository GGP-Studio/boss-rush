extends Area2D
@onready var game_menager: Node = get_tree().current_scene.get_node("GameMenager")
func ready() -> void:
	print(get_parent())
	 
	

func _on_body_entered(body: Node2D) -> void:
	game_menager.add_bone();
	queue_free()
	
