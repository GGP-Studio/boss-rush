extends Control
@onready var health_bar: ProgressBar = $PlayerHealth/healthBar
@onready var health: Label = $PlayerHealth/healthBar/Health
@onready var bones: Label = $PlayerBones/Bones
@onready var player: CharacterBody2D = %Player
@onready var game_menager: Node = %GameMenager

func _process(delta):
	health_bar.value = player.health
	health.text = str(player.health) + "/100"
	bones.text = "Kosci: " + str(game_menager.bones)
