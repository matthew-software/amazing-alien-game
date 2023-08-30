extends Fireball


func _ready():
	super()
	direction.x = 0
	direction.y = -1


func _physics_process(delta):
	super(delta)
	
	if anim.animation != "Death":
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		
		anim.play("Up")
		
		move_and_slide()
