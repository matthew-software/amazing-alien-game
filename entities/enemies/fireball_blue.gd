extends Fireball


func _ready():
	super()


func _physics_process(delta):
	super(delta)
	
	if anim.animation != "Death":
		chase()
		
		# Handle moving (with sideways movement involved).
		if abs(direction.x) > .5:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
			if direction.x < 0:
				anim.play("Left")
			else:
				anim.play("Right")
		# Handle moving directly up or down.
		elif direction.y:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
			if direction.y < 0:
				anim.play("Up")
			else:
				anim.play("Down")
	
		move_and_slide()


# Override face_player because BlueFireball has left and right animations
func face_player():
	direction = (player.position - self.position).normalized()
