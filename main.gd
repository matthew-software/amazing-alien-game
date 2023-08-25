extends Node2D
class_name Main

@export var PlayerScene: PackedScene
@export var BossScene: PackedScene
@export var LevelScene: PackedScene
@export var ui: UI


var player: Character
var boss: Character
var level


func _ready():
	Utils.saveGame()
	Utils.loadGame()


func start_game():
	level = LevelScene.instantiate()
	add_child(level)
	move_child(level, 0)
	
	player = PlayerScene.instantiate()
	level.add_child(player)
	level.move_child(player, 2)
	player.position = Vector2(176,192)
	
	boss = BossScene.instantiate()
	level.add_child(boss)
	level.move_child(boss, 3)
	boss.position = Vector2(2624,320)

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_play_2_pressed():
	get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_play_3_pressed():
	get_tree().change_scene_to_file("res://levels/level_3.tscn")


func _on_play_4_pressed():
	get_tree().change_scene_to_file("res://levels/final_boss.tscn")


func _on_ui_start_game():
	start_game()
