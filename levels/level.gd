extends Node2D
class_name Level


func _on_abyss_body_entered(body):
	if body.name == "Player":
		body.plunge_sound.play()
		body.death_timer.start()
		await body.hurt_sound.finished
