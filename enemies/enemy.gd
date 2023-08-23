extends CharacterBody2D
class_name Enemy

@export var speed: int = 30
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player

@onready var anim = get_node("AnimatedSprite2D")
@onready var death_sound = $DeathSound

var direction = self.position.normalized()


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../../Player/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Makes sure enemy is facing the player
func face_player():
	direction = (player.position - self.position).normalized()
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true


# Returns true if currently facing the player, false otherwise
func is_facing_player():
	direction = (player.position - self.position).normalized()
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
	print("commence.")
	print("ABOUT TO FREEEEE")
	self.queue_free()
	print("...............................................free")


# On death, player "extra jumps"
func _on_death_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			death()
			body.extra_jump = true


# If jumped on by player, die
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if anim.animation != "Death":
			body.alive = false
