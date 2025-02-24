extends Control
@onready var bones_bar: Label = $Bones
@onready var health_bar: Label = $Health

@onready var player: CharacterBody2D = %Player
@onready var game_menager: Node = %GameMenager

func _process(delta):
	health_bar.text = "Życie: " + str(player.health)
	bones_bar.text = "Kosci: " + str(game_menager.bones)
