extends Node

# PROPERTIES
export (PackedScene) var Mob

onready var hud = $HUD
onready var bg_music = $SFX/BGMusic
onready var game_over_sfx = $SFX/GameOverSFX
onready var player = $Player
onready var player_start_pos = $PlayerStartPos
onready var start_timer = $Timers/StartTimer
onready var mob_timer = $Timers/MobTimer
onready var score_timer = $Timers/ScoreTimer
onready var mob_spawn_loc = $MobPath/MobSpawnLoc

var score


# DEFAULTS
func _ready():
	randomize()


# SIGNALS
func _on_Player_hit():
	end_game()


func _on_StartTimer_timeout():
	mob_timer.start()
	score_timer.start()


func _on_MobTimer_timeout():
	spawn_random_mob()


func _on_ScoreTimer_timeout():
	score += 1
	hud.update_score(score)


func _on_HUD_start_game():
	start_game()


# CUSTOM
func start_game():
	score = 0
	player.reset(player_start_pos.position)
	start_timer.start()
	hud.update_score(score)
	hud.show_message("Get ready")
	bg_music.play()


func spawn_random_mob():
	mob_spawn_loc.offset = randi()
	var mob = Mob.instance()
	var direction = mob_spawn_loc.rotation + PI / 2
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.position = mob_spawn_loc.position
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	
	add_child(mob)


func end_game():
	get_tree().call_group("mobs", "queue_free")
	mob_timer.stop()
	score_timer.stop()
	hud.show_game_over()
	bg_music.stop()
	game_over_sfx.play()
