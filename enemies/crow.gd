extends Bird


func _ready():
	super()


func _physics_process(delta):
	super(delta)


# If player is close by and not looking, approach
func sneak():
	if anim.flip_h != get_node("../../Player/Player/AnimatedSprite2D").flip_h:
		direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = false
		else:
			anim.flip_h = true
