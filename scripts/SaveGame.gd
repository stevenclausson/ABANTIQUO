extends Resource


const SAVE_GAME_PATH := "user://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"wildBerries": Global.wildBerries,
		"wildMeat": Global.wildMeat,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)

