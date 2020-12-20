extends CanvasLayer

# PROPERTIES
signal start_game

onready var score_lbl = $Margin/VBox/ScoreLbl
onready var msg_lbl = $Margin/VBox/MsgLbl
onready var start_btn = $Margin/VBox/StartBtn
onready var msg_timer = $MsgTimer


# SIGNALS
func _on_StartBtn_pressed():
	start_btn.hide()
	emit_signal("start_game")


func _on_MsgTimer_timeout():
	msg_lbl.hide()


# CUSTOM
func show_message(text):
	msg_lbl.text = text
	msg_lbl.show()
	msg_timer.start()


func update_score(score):
	score_lbl.text = str(score)


func show_game_over():
	show_message("Game Over")
	yield(msg_timer, "timeout")
	
	msg_lbl.text = "Dodge the Creeps!"
	msg_lbl.show()
#	yield(get_tree().create_timer(1), "timeout")
	start_btn.show()
