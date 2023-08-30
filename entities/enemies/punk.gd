extends Enemy


func _ready():
	super()
	speed = 0
	anim.play("Idle")
	$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta):
	super(delta)
	if anim.animation != "Death":
		velocity.y += gravity * delta
	
		move_and_slide()


# When facing player, or not facing player but player not slow, face player and attack
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if (body.slow == false) or ((body.slow == true) and (is_facing_player() == true)):
				face_player()
				anim.play("Attack")
				$PlayerCollision/CollisionShape2D.set_deferred("disabled", false)


# If player leaves vicinity, idle
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		if anim.animation != "Death":
			anim.play("Idle")
			$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)
