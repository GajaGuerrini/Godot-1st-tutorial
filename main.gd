extends Node2D
@export var Mob: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():  # choosing a random mob
	randomize()


func new_game():  #setting new game
	score = 0
	$Player.start($StartPos4Player.position) # repositioning player
	$StartTimer.start()
	$HUD.show_msg("Get ready")
	$HUD.update_score(score)


func game_over():
	$ScoreTimer.stop() # our score timer stops
	$MobTimer.stop()  # we dont spawn mobs anymore
	$HUD.game_over()

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout(): #spawning mobs timer
	$MobPath/MobSpawnLocation.set_progress(randi())
	var mob = Mob.instantiate()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(randf_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
