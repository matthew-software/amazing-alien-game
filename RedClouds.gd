extends ParallaxLayer


var cloud_speed = 1


func _process(delta):
	motion_offset.x -= cloud_speed * delta
