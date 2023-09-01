extends Enemy


var chasing = false


func _ready():
	super()
	anim.play("Idle")


func _physics_process(delta):
	super(delta)
	if anim.animation != "Death":
		if chasing == true:
			anim.play("Fly")
			chase()
	
		move_and_slide()


# On death, player "super jumps" (overridden from "Enemy" parent class's "extra jump")
func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.super_jump = true


# When facing player, or not facing player but player not slow, face player and attack
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if (body.slow == false):
				face_player()
				anim.play("Fly")
				chasing = true


# If player approaches larger vicinity before the chase but not slowly, stare (open eyes)
func _on_warning_detection_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if chasing == false and body.slow == false:
				anim.play("Stare")


# If player leaves larger vicinity before the chase, idle (close eyes)
func _on_warning_detection_body_exited(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if chasing == false:
				anim.play("Idle")
