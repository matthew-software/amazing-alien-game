extends Mole


func _ready():
	super()
	speed = 60


func _physics_process(delta):
	super(delta)


func _on_player_detection_body_entered(body):
	if (body.name == "Player") and (body.slow == false):
		if (anim.animation != "Death"):
			$Death/CollisionShape2D.set_deferred("disabled", true)
			
			if terrain == "city":
				anim.play("CityHide")
				await anim.animation_finished
				anim.play("CityFlag")
			else: # terrain == dungeon
				anim.play("DungeonHide")
				await anim.animation_finished
				anim.play("DungeonFlag")


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		if anim.animation != "Death":
			if terrain == "city":
				anim.play("CityPeak")
			else: # terrain == dungeon
				anim.play("DungeonPeak")
			
			$Death/CollisionShape2D.set_deferred("disabled", false)
