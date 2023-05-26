extends Control

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(2)
	timer.connect("timeout",Callable(self,"_on_Timer_timeout"))
	timer.start()

func _on_Timer_timeout():
	Global.EndDay()
	Global.CheckSeason()
	Global.PopulationGrowth()
	Global.AutoForage()
	Global.ForagerFoodConsumption()
	Global.GatherResources()
	Global.StarvationCheck()
	#GlobalResearch.CheckHordeIdeas()
	DisplayData()
	DisplayAlerts()

func DisplayData():
	$TopPanel/DayLbl.text = "Day: " + str(Global.currentDay)
	$TopPanel/YearLbl.text = "Year: " + str(Global.year)
	$TopPanel/SeasonLbl.text = str(Global.stringSeason)
	#Alerts
	if (GlobalResearch.newResearch == true):
		GlobalResearch.newResearch = false
		$GameDialog.visible = true
		$GameDialog.title = str(GlobalResearch.gameDialogTitle)
		$GameDialog.dialog_text = str(GlobalResearch.gameDialogText)
	#Resources
	$TabContainer/Resources/HSplitContainer/VBoxContainer/TimberLbl.text = "Timber: " + str(floor(Global.timber))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/FlintLbl.text = "Flint :" + str(floor(Global.flint))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/StoneLbl.text = "Stone: " + str(floor(Global.stone))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/ThatchLbl.text = "Thatch: " + str(floor(Global.thatch))
	#Buildings
	$TabContainer/Buildings/VBoxContainer/TimberCampBtn/TimberCampLbl.text = ": " + str(Global.timberCamp)
	$TabContainer/Buildings/VBoxContainer/FlintCampBtn/FlintCampLbl.text = ": " + str(Global.flintCamp)
	$TabContainer/Buildings/VBoxContainer/StoneCampBtn/StoneCampLbl.text = ": " + str(Global.stoneCamp)
	#Food
	$TabContainer/Resources/HSplitContainer/VBoxContainer2/WaterLbl.text = "Water: " + str(floor(Global.water))
	$TabContainer/Resources/HSplitContainer/VBoxContainer2/WildBerriesLbl.text = "Wild Berries: " + str(floor(Global.wildBerries))
	$TabContainer/Resources/HSplitContainer/VBoxContainer2/WildMeatLbl.text = "Wild Meat: " + str(floor(Global.wildMeat))
	$InfoPanel/VBoxContainer/Label.text = "The " + str(Global.civilizedLevel) + " people of the " + str(Global.cultureText) + " culture are led by a [leadertrait] [title] named [playername]. The " + str(Global.provincePopulation) + " people that live here are [health] and [happiness]."
	$TopPanel/DominionBar.value = Global.dominionLevel
	$TopPanel/DominionBar.max_value = Global.maxDominionLevel
	$TopPanel/DominionBar/MaxDominionLbl.text = str(Global.maxDominionLevel)
	$TopPanel/DominionBar/CurrentDominionLbl.text = str(Global.dominionLevel)
	$TabContainer/Population/VBoxContainer/PopOverviewLbl.text = "Your people are [health] and [happiness]. There are " + str(Global.provincePopulation) + " people, broken down into: " + str(Global.malePopulation) + " men, " + str(Global.femalePopulation) + " women, and " + str(Global.childrenPopulation) + " children."


func DisplayAlerts():
	if (Global.resourceAlert == true):
		$GameDialog.visible = true
		$GameDialog.title = str(Global.gameDialogTitle)
		$GameDialog.dialog_text = str(Global.gameDialogText)
		Global.resourceAlert = false
		
#Buttons------------------------------------------------
func _on_timber_camp_btn_pressed():
	Global.BuildTimberCamp()
	$TabContainer/Buildings/VBoxContainer/TimberCampBtn/TimberCampLbl.text = ": " + str(Global.timberCamp)

func _on_button_pressed():
	SaveResource.saveGame()

func _on_load_game_btn_pressed():
	SaveResource.loadGame()

func _on_version_btn_pressed():
	$VersionDialog.visible = true

func _on_flint_camp_btn_pressed():
	Global.BuildFlintCamp()
	$TabContainer/Buildings/VBoxContainer/FlintCampBtn/FlintCampLbl.text = ": " + str(Global.flintCamp)

func _on_stone_camp_btn_pressed():
	Global.BuildStoneCamp()
	$TabContainer/Buildings/VBoxContainer/StoneCampBtn/StoneCampLbl.text = ": " + str(Global.stoneCamp)

func _on_primitive_well_btn_pressed():
	Global.BuildPrimitiveWell()
	$TabContainer/Buildings/VBoxContainer/PrimitiveWellBtn/PrimitiveWellLbl.text = ": " + str(Global.primitiveWell)


func _on_hunters_camp_btn_pressed():
	Global.BuildHuntersCamp()
	$TabContainer/Buildings/VBoxContainer/HuntersCampBtn/HuntersCampLbl.text = ": " + str(Global.huntersCamp)
