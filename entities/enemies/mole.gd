extends Enemy
class_name Mole

# possible terrains: city, dungeon
@export var terrain: String = "city"


func _ready():
	speed = 60
	
	if terrain == "city":
		anim.play("CityPeak")
	else: # terrain == dungeon
		anim.play("DungeonPeak")


func _physics_process(delta):
	super(delta)
	
	
