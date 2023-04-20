extends Node

#---TIME STUFF----------------------------------------
var monthCheck = 0
var currentDay = 0
var year = 0
var currentSeason
var stringSeason


#----Day Functions-----------------------------------

	


func EndDay():
	if (currentDay <= 365):
		currentDay += 1
	elif (currentDay > 365):
		currentDay = 0
		year += 1
	print(currentDay)
	
func CheckSeason():
	if (currentDay >= 85 and currentDay <= 172):
		currentSeason = 2 #Spring
		stringSeason = "Spring"
	elif (currentDay >= 173 and currentDay <= 220):
		currentSeason = 3 #Summer
	elif(currentDay >= 221 and currentDay <= 315):
		currentSeason = 4 #Fall
	else:
		currentSeason = 1 #Winter
		stringSeason = "Winter"
		print(currentSeason)


