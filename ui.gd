extends CanvasLayer
class_name UI

signal start_game()

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
