extends CharacterBody2D

const SPEED = 30

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var super_player

@onready var anim = get_node("AnimatedSprite2D")
@onready var death_sound = $DeathSound

var direction = self.position.normalized()


func _ready():
	player = get_node("../../Player/Player")
	super_player = get_node("../../Player/SuperPlayer")
	anim.play("Idle")
	$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta):
	if anim.animation != "Death":
		velocity.y += gravity * delta
	
		move_and_slide()


func face_player():
	direction = (super_player.position - self.position).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true


func is_facing_player():
	direction = (super_player.position - self.position).normalized()
	if direction.x > 0:
		if get_node("AnimatedSprite2D").flip_h == false:
			return true
	elif get_node("AnimatedSprite2D").flip_h == true:
		return true
	
	return false


func death():
	$CollisionShape2D.set_deferred("disabled", true)
	anim.play("Death")
	death_sound.play()
	await anim.animation_finished
	self.queue_free()


func _on_player_detection_body_entered(body):
	if body.name == "SuperPlayer":
		if (body.slow == false) or ((body.slow == true) and (is_facing_player() == true)):
			face_player()
			anim.play("Attack")
			$PlayerCollision/CollisionShape2D.set_deferred("disabled", false)


func _on_player_detection_body_exited(body):
	if body.name == "SuperPlayer":
		anim.play("Idle")
		$PlayerCollision/CollisionShape2D.set_deferred("disabled", true)


func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.extra_jump = true


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.alive = false
