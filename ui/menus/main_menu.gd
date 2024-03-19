extends Control

signal start_game()
signal start_level_2()
signal start_level_3()
signal start_final_boss()
@onready var start_menu = %StartMenu
@onready var level_menu = %LevelMenu
@onready var menu_focus_sound = $MenuFocusSound
@onready var menu_press_sound = $MenuPressSound

# Start Menu #

func _ready():
	level_menu.hide()
	focus_button()
	activate_menu_sounds()


func activate_menu_sounds():
	start_menu.get_node("Start").connect("mouse_entered", on_button_target)
	start_menu.get_node("Start").connect("focus_entered", on_button_target)
	start_menu.get_node("Quit").connect("mouse_entered", on_button_target)
	start_menu.get_node("Quit").connect("focus_entered", on_button_target)
	level_menu.get_node("Level1").connect("mouse_entered", on_button_target)
	level_menu.get_node("Level1").connect("focus_entered", on_button_target)
	level_menu.get_node("Level2").connect("mouse_entered", on_button_target)
	level_menu.get_node("Level2").connect("focus_entered", on_button_target)
	level_menu.get_node("Level3").connect("mouse_entered", on_button_target)
	level_menu.get_node("Level3").connect("focus_entered", on_button_target)
	level_menu.get_node("FinalBoss").connect("mouse_entered", on_button_target)
	level_menu.get_node("FinalBoss").connect("focus_entered", on_button_target)


func on_button_target():
	menu_focus_sound.play()


func _on_start_pressed():
	start_menu.hide()
	menu_press_sound.play()
	level_menu.show()
	focus_button()


func _on_quit_pressed():
	get_tree().quit()


###
# Level Menu #

func _on_level_1_pressed():
	menu_press_sound.play()
	start_game.emit()
	hide()


func _on_level_2_pressed():
	menu_press_sound.play()
	start_level_2.emit()
	hide()


func _on_level_3_pressed():
	menu_press_sound.play()
	start_level_3.emit()
	hide()


func _on_final_boss_pressed():
	menu_press_sound.play()
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
