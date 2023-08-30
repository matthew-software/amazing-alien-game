extends Character
class_name Player


func _physics_process(delta):
	move_jump = Input.is_action_just_pressed("ui_accept")
	move_horizontal = Input.get_axis("ui_left", "ui_right")
	move_slow = Input.is_action_pressed("slow")
	super(delta)
