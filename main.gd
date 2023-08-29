extends Node2D
class_name Main

@export var PlayerScene: PackedScene
@export var BossScene: PackedScene
@export var Level1Scene: PackedScene
@export var Level2Scene: PackedScene
@export var Level3Scene: PackedScene
@export var FinalBossScene: PackedScene
@export var ui: UI


var player: Character
var boss: Character
var level
var current_level


func _ready():
	Utils.saveGame()
	Utils.loadGame()


func start_game():
	# Start appropriate level; reduce number of crystals if level hasn't been beaten
	if current_level == 1:
		if Game.crystals < 2:
			Game.crystals = 0
		level = Level1Scene.instantiate()
	elif current_level == 2:
		if Game.crystals < 60:
			Game.crystals = 2
		level = Level2Scene.instantiate()
	elif current_level == 3:
		if Game.crystals < 90:
			Game.crystals = 60
		level = Level3Scene.instantiate()
	elif current_level == 4:
		if Game.crystals < 100:
			Game.crystals = 90
		level = FinalBossScene.instantiate()
	add_child(level)
	move_child(level, 0)
	
	if !player:
		player = PlayerScene.instantiate()
	level.add_child(player)
	level.move_child(player, 2)
	player.position = Vector2(176,192)
	
	if !boss:
		boss = BossScene.instantiate()
	level.add_child(boss)
	level.move_child(boss, 3)
	boss.position = Vector2(2624,320)


func _process(delta):
	check_crystals()

func check_crystals():
	if current_level == 1 and Game.crystals == 2:
		player.alive = false
	elif current_level == 2 and Game.crystals == 60:
		player.alive = false
	elif current_level == 3 and Game.crystals == 90:
		player.alive = false
	elif current_level == 4 and Game.crystals == 100:
		player.alive = false


func _on_ui_start_game():
	current_level = 1
	start_game()


func _on_ui_start_level_2():
	current_level = 2
	start_game()


func _on_ui_start_level_3():
	current_level = 3
	start_game()


func _on_ui_start_final_boss():
	current_level = 4
	start_game()
