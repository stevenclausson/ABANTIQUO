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
	DisplayData()

func DisplayData():
	$TopPanel/DayLbl.text = "Day: " + str(Global.currentDay)
	$TopPanel/YearLbl.text = "Year: " + str(Global.year)
	if(Global.currentSeason == 1):
		$TopPanel/SeasonLbl.text = "Winter"
	elif(Global.currentSeason == 2):
		$TopPanel/SeasonLbl.text = "Spring"
	elif(Global.currentSeason == 3):
		$TopPanel/SeasonLbl.text = "Summer"
	elif(Global.currentSeason == 4):
		$TopPanel/SeasonLbl.text = "Fall"
	print("DISPLAY WORKS")
