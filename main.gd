extends Node2D


func _ready():
	Utils.saveGame()
	Utils.loadGame()


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
