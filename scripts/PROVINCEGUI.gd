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
	DisplayData()

func DisplayData():
	$TopPanel/DayLbl.text = "Day: " + str(Global.currentDay)
	$TopPanel/YearLbl.text = "Year: " + str(Global.year)
	$TopPanel/SeasonLbl.text = str(Global.stringSeason)
	$TabContainer/Resources/HSplitContainer/VBoxContainer/TimberLbl.text = "Timber: " + str(floor(Global.timber))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/FlintLbl.text = "Flint :" + str(floor(Global.flint))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/StoneLbl.text = "Stone: " + str(floor(Global.stone))
	$TabContainer/Resources/HSplitContainer/VBoxContainer/ThatchLbl.text = "Thatch: " + str(floor(Global.thatch))
	$TabContainer/Buildings/VBoxContainer/TimberCampBtn/TimberCampLbl.text = ": " + str(Global.timberCamp)
	$TabContainer/Resources/HSplitContainer/VBoxContainer2/WildBerriesLbl.text = "Wild Berries: " + str(floor(Global.wildBerries))
	$TabContainer/Resources/HSplitContainer/VBoxContainer2/WildMeatLbl.text = "Wild Meat: " + str(floor(Global.wildMeat))
	$InfoPanel/VBoxContainer/Label.text = "The [trait] people of " + str(Global.culture) + " are led by a [leadertrait] [title] named [playername]. The " + str(Global.provincePopulation) + " people that live here are [health] and [happiness]."



func _on_timber_camp_btn_pressed():
	Global.BuildTimberCamp()
	$TabContainer/Buildings/VBoxContainer/TimberCampBtn/TimberCampLbl.text = ": " + str(Global.timberCamp)


func _on_button_pressed():
	SaveResource.saveGame()


func _on_load_game_btn_pressed():
	SaveResource.loadGame()
