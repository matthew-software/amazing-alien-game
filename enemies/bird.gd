extends Enemy
class_name Bird

var fleeing = false
var flying = false
var flight_time = 3 # seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	speed = 30
	direction = self.position.normalized()
	face_player()
	anim.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if anim.animation != "Death":
		if flying == false:
			velocity.y += gravity * delta
			if fleeing == true:
				flee()
			else:
				velocity.x = 0
				anim.play("Idle")
		else: # flying == true
			fly(delta)
		
		move_and_slide()


# Run away; fly into the air if wall is hit
func flee():
	# If wall is hit upon fleeing, stop and fly up in the air
	if is_on_wall():
		direction.y = -1
		velocity.y = direction.y * speed
		velocity.x = 0
		face_player()
		anim.play("Fly")
		flying = true
		fleeing = false
	# If wall is not hit yet upon fleeing, keep fleeing
	else:
		direction = (self.position - player.position).normalized()
		if direction.x > 0:
			anim.flip_h = false
		else:
			anim.flip_h = true
		
		# Do something special depending on type of bird
		sneak()
		
		velocity.x = direction.x * speed
		anim.play("Run")


# Fly "flight_time" seconds into the air
func fly(delta):
	if flight_time > 0:
		flight_time -= delta
		# Once "flight_time" has been completed, suspend flight in midair indefinitely
		if flight_time <= 0:
			flight_time = 0
			velocity.y = 0


# Override if bird sneaks
func sneak():
	pass


# On death, player "super jumps" (overridden from "Enemy" parent class's "extra jumping")
func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.super_jump = true


# When on the ground, if player gets too close, flee
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if flying == false:
				fleeing = true


# If player leaves vicinity, don't flee, but face player
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		if anim.animation != "Death":
			fleeing = false
			face_player()
