extends ParallaxLayer


var cloud_speed = 2


func _process(delta):
	motion_offset.x -= cloud_speed * delta
