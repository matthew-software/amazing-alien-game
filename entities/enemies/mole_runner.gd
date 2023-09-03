extends Mole


@export var run: bool = false

func _ready():
	if run == true:
		speed = 60
		run_right()
	else: # run == false
		super()


func _physics_process(delta):
	super(delta)
	if anim.animation != "Death":
		if run == true:
			#speed = 60
			velocity.y += gravity * delta
			wall_to_wall()
			
			# Handle running.
			velocity.x = direction * speed
			anim.play("Run")
			
			move_and_slide()


func _on_player_detection_body_entered(body):
	if (body.name == "Player") and (body.slow == false):
		if (anim.animation != "Death") and (anim.animation != "Vacate"):
			if run == false:
				anim.play("Vacate")
				position.y -= 16
				await anim.animation_finished
				run_right()
				run = true
