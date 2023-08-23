extends Enemy
class_name Mammal


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	anim.play("Run")
	get_node("AnimatedSprite2D").flip_h = true
	direction = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if anim.animation != "Death":
		velocity.y += gravity * delta
		
		# Flip direction if Rat hits wall
		if is_on_wall():
			if get_node("AnimatedSprite2D").flip_h == false:
				get_node("AnimatedSprite2D").flip_h = true
				direction = -1
			else:
				get_node("AnimatedSprite2D").flip_h = false
				direction = 1
		
		# Handle running.
		velocity.x = direction * speed
		anim.play("Run")
		
		move_and_slide()
