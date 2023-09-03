extends Enemy


func _ready():
	super()
	run_left()


func _physics_process(delta):
	super(delta)
	if anim.animation != "Death":
		velocity.y += gravity * delta
		wall_to_wall()
		
		# Handle running.
		velocity.x = direction * speed
		anim.play("Run")
		
		move_and_slide()
