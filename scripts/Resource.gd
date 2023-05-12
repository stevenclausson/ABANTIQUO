extends Node
class_name SaveGame

const SAVE_GAME_PATH := "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"wildBerries": Global.wildBerries,
		"wildMeat": Global.wildMeat,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	print("Game Saved")

func loadGame():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_GAME_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Global.wildBerries = current_line["wildBerries"]
				Global.wildMeat = current_line["wildMeat"]
