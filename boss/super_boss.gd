extends Enemy


func _ready():
	anim.play("Idle")
	$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)
	player = get_node("../../Player/Player")


func _physics_process(delta):
	if anim.animation != "Death":
		velocity.y += gravity * delta
	
		move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if (body.slow == false) or ((body.slow == true) and (is_facing_player() == true)):
			face_player()
			anim.play("Attack")
			$PlayerCollision/CollisionShape2D.set_deferred("disabled", false)


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		anim.play("Idle")
		$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)
