extends CanvasLayer

signal start_game

func show_msg(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func game_over():
	show_msg("Game Over")
	await($MessagaTimer.timeout)
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
		
func _on_message_timer_timeout():
	$MessageLabel.hide()
	
func _on_start_button_pressed():
	$StartButton.hide()
	emit_signal("start_game")
