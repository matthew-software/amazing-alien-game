extends Enemy


signal attacking_started(left)
signal attacking_finished()
@onready var crystal_beam_timer = $CrystalBeamTimer


var tremor = false
var tremor_amount = 1.0


func _ready():
	anim.play("Idle")
	$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta):
	super(delta)
	if anim.animation != "Death":
		velocity.y += gravity * delta
		
		if tremor:
			player.camera.set_offset(Vector2( \
				randf_range(-1.0, 1.0) * tremor_amount, \
				randf_range(-1.0, 1.0) * tremor_amount \
			))
	
		move_and_slide()


func _on_player_detection_body_entered(body):
	if (body.name == "Player") and (anim.animation == "Idle"):
		if (body.slow == false) or ((body.slow == true) and (is_facing_player() == true)):
			face_player()
			anim.play("Attack")
			$PlayerCollision/CollisionShape2D.set_deferred("disabled", false)
			if anim.flip_h == true:
				attacking_started.emit(true)
			else:
				attacking_started.emit(false)
			crystal_beam_timer.start()


#func _on_player_detection_body_exited(body):
	#if body.name == "Player":
		#anim.play("Idle")
		#$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)


func _on_crystal_beam_timer_timeout():
	anim.play("Idle")
	$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)
	attacking_finished.emit()


func _on_special_attack_timer_timeout():
	if anim.animation == "Idle":
		special_attack()


func special_attack():
	# Animate this to increase/decrease/fade the shaking
	tremor = true
	anim.play("Special")
	await anim.animation_finished
	tremor = false
	anim.play("Idle")
