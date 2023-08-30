extends Character


func _physics_process(delta):
	ai()
	super(delta)
	

func ai():
	pass


# Override Character's method since this is an enemy character
func check_death():
	if alive == false:
		queue_free()
