extends Enemy
class_name Fireball


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super(delta)


# Override Enemy method to die when it hits anything
func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.pause = true
			body.hurt_sound.play()
			body.death_timer.start()
			await body.hurt_sound.finished
	death()
