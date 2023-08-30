extends Level


func _on_inferno_body_entered(body):
	if body.name == "Player":
		body.pause = true
		body.hurt_sound.play()
		body.death_timer.start()
		await body.hurt_sound.finished
	else:
		body.death()
