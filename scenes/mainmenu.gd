extends Control



func _on_new_game_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/char_creation.tscn")
