extends CanvasLayer
class_name UI

signal start_game()
signal start_level_2()
signal start_level_3()
signal start_final_boss()

@onready var crystal_progress = %CrystalProgress
@onready var crystal_label = %CrystalLabel
@onready var main_menu = %MainMenu


var crystals = 0:
	set(new_crystals):
		crystals = new_crystals
		_update_crystal_progress()
		_update_crystal_label()


func _ready():
	_update_crystal_progress()
	_update_crystal_label()


func _process(delta):
	crystals = Game.crystals


func _update_crystal_progress():
	crystal_progress.value = crystals


func _update_crystal_label():
	crystal_label.text = str(crystals)


func _on_main_menu_start_game():
	start_game.emit()


func _on_main_menu_start_level_2():
	start_level_2.emit()
	crystal_progress.min_value = 30
	crystal_progress.max_value = 60


func _on_main_menu_start_level_3():
	start_level_3.emit()
	crystal_progress.min_value = 60
	crystal_progress.max_value = 90


func _on_main_menu_start_final_boss():
	start_final_boss.emit()
	crystal_progress.min_value = 90
	crystal_progress.max_value = 100
