extends Control

signal start_game()
@onready var buttons_v_box = %ButtonsVBox


func _ready():
	focus_button()


func _on_start_pressed():
	start_game.emit()
	hide()


func _on_quit_pressed():
	get_tree().quit()


func _on_visibility_changed():
	if visible:
		focus_button()


func focus_button():
	if buttons_v_box:
		var button : Button = buttons_v_box.get_child(0)
		if button is Button:
			button.grab_focus()
