extends Control

@onready var health_bar: ProgressBar = $PlayerInfoBox/healthBar
@onready var health: Label = $PlayerInfoBox/healthBar/Health


@onready var player: CharacterBody2D = %Player
@onready var game_menager: Node = %GameMenager

func _process(delta):
	health_bar.value = player.health
	health.text = str(player.health) + "/100"
	#bones_bar.text = "Kosci: " + str(game_menager.bones)
