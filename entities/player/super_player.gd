extends Character
class_name SuperPlayer


func _ready():
	speed = 150.0


func _physics_process(delta):	
	move_horizontal = Input.get_axis("ui_left", "ui_right")
	move_vertical = Input.get_axis("ui_up", "ui_down")
	move_slow = Input.is_action_pressed("slow")
	super(delta)
	
	if alive == false:
		Game.lives -= 1
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")


# Overridden to fly
func move():
	fly()


func fly():
	# Fly (with sideways movement involved)
	if direction.x:
		if slow:
			velocity.x = direction.x * slow_speed
			velocity.y = direction.y * slow_speed
			anim.play("Fly")
		else:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
			anim.play("Soar")
	# Fly directly up or down
	elif direction.y:
		velocity.x = move_toward(velocity.x, 0, speed)
		get_node("AnimatedSprite2D").flip_h = false
		if slow:
			velocity.y = direction.y * slow_speed
			if direction.y < 0:
				anim.play("FlyUp")
			else:
				anim.play("FlyDown")
		else:
			velocity.y = direction.y * speed
			if direction.y < 0:
				anim.play("SoarUp")
			else:
				anim.play("SoarDown")
	# Stop
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		anim.play("Idle")
