extends Level

#@onready var super_boss = $Enemies/SuperBoss
#@export var CrystalBeamScene: PackedScene

@onready var crystal_beam = $CrystalBeam
@onready var crystal_beam_2 = $CrystalBeam2
@onready var death_sound = $DeathSound


var crystal_beam_anim
var crystal_beam_2_anim


func _ready():
	crystal_beam_anim = crystal_beam.get_node("AnimatedSprite2D")
	crystal_beam_2_anim = crystal_beam_2.get_node("AnimatedSprite2D")
	crystal_beam.get_node("AnimatedSprite2D").flip_h = true
	crystal_beam.hide()
	crystal_beam_2.hide()


func _on_inferno_body_entered(body):
	if body is Character:
		death_sound.play()
		body.pause = true
		body.hurt_sound.play()
		body.death_timer.start()
		await body.hurt_sound.finished
	else:
		body.death()


func _on_super_boss_attacking_started(left):
	if left == true:
		crystal_beam_anim.play("Blast")
		crystal_beam.show()
	else: # right == true
		crystal_beam_2_anim.play("Blast")
		crystal_beam_2.show()


func _on_super_boss_attacking_finished():
	crystal_beam.hide()
	crystal_beam_2.hide()
