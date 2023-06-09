extends Node
class_name SaveGame

const SAVE_GAME_PATH := "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"wildBerries": Global.wildBerries,
		"wildMeat": Global.wildMeat,
		"research": GlobalResearch.research,
		"baseResearchRate": GlobalResearch.baseResearchRate,
		"researchRateBonus": GlobalResearch.researchRateBonus,
		"currentDay": Global.currentDay,
		"year": Global.year,
		"malePopulation": Global.malePopulation,
		"femalePopulation": Global.femalePopulation,
		"populationGrowthRate": Global.populationGrowthRate,
		"foodConsumption": Global.foodConsumption,
		"foragedFood": Global.foragedFood,
		"foragingBonus": Global.foragingBonus,
		"water": Global.water,
		"waterGatherRate": Global.waterGatherRate,
		"timber": Global.timber,
		"timberGatherRate": Global.timberGatherRate,
		"stone": Global.stone,
		"stoneGatherRate": Global.stoneGatherRate,
		"flint": Global.flint,
		"flintGatherRate": Global.flintGatherRate,
		"thatch": Global.thatch,
		"huntingBonus": Global.huntingBonus,
		"timberCamp": Global.timberCamp,
		"stoneCamp": Global.stoneCamp,
		"flintCamp": Global.flintCamp,
		"primitiveWell": Global.primitiveWell,
		"huntersCamp": Global.huntersCamp,
		"dolmen": Global.dolmen,
		"dominionLevel": Global.dominionLevel,
		"maxDominionLevel": Global.maxDominionLevel,
		"thatchGatherRate": Global.thatchGatherRate,
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
				GlobalResearch.research = current_line["research"]
				GlobalResearch.baseResearchRate = current_line["baseResearchRate"]
				GlobalResearch.researchRateBonus = current_line["researchRateBonus"]
				Global.currentDay = current_line["currentDay"]
				Global.year = current_line["year"]
				Global.malePopulation = current_line["malePopulation"]
				Global.femalePopulation = current_line["femalePopulation"]
				Global.populationGrowthRate = current_line["populationGrowthRate"]
				Global.foodConsumption = current_line["foodConsumption"]
				Global.foragedFood = current_line["foragedFood"]
				Global.foragingBonus = current_line["foragingBonus"]
				Global.water = current_line["water"]
				Global.waterGatherRate = current_line["waterGatherRate"]
				Global.timber = current_line["timber"]
				Global.timberGatherRate = current_line["timberGatherRate"]
				Global.stone = current_line["stone"]
				Global.stoneGatherRate = current_line["stoneGatherRate"]
				Global.flint = current_line["flint"]
				Global.flintGatherRate = current_line["flintGatherRate"]
				Global.thatch = current_line["thatch"]
				Global.thatchGatherRate = current_line["thatchGatherRate"]
				Global.huntingBonus = current_line["huntingBonus"]
				Global.timberCamp = current_line["timberCamp"]
				Global.flintCamp = current_line["flintCamp"]
				Global.stoneCamp = current_line["stoneCamp"]
				Global.primitiveWell = current_line["primitiveWell"]
				Global.huntersCamp = current_line["huntersCamp"]
				Global.dolmen = current_line["dolmen"]
				Global.dominionLevel = current_line["dominionLevel"]
				Global.maxDominionLevel = current_line["maxDominionLevel"]
