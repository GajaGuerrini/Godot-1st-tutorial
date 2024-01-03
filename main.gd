extends Node2D
@export var Mob: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func new_game():
	score = 0
	$Player.start($StartPos4Player.position)
	$StartTimer.start()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
