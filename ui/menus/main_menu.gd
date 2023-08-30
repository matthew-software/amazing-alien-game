extends Control

signal start_game()
signal start_level_2()
signal start_level_3()
signal start_final_boss()
@onready var start_menu = %StartMenu
@onready var level_menu = %LevelMenu


# Start Menu #

func _ready():
	level_menu.hide()
	focus_button()


func _on_start_pressed():
	start_menu.hide()
	level_menu.show()
	focus_button()


func _on_quit_pressed():
	get_tree().quit()


###
# Level Menu #

func _on_level_1_pressed():
	start_game.emit()
	hide()


func _on_level_2_pressed():
	start_level_2.emit()
	hide()


func _on_level_3_pressed():
	start_level_3.emit()
	hide()


func _on_final_boss_pressed():
	start_final_boss.emit()
	hide()


###


func _on_visibility_changed():
	if visible:
		focus_button()


func focus_button():
	if start_menu and start_menu.is_visible_in_tree():
		var button : Button = start_menu.get_child(0)
		if button is Button:
			button.grab_focus()

	if level_menu and level_menu.visible == true:
		var button : Button = level_menu.get_child(0)
		if button is Button:
			button.grab_focus()
