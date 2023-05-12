extends Node

var rng = RandomNumberGenerator.new()

#----SAVING AND LOADING GAME-----------------------------------------------------------

#---TIME STUFF----------------------------------------
var monthCheck = 0
var currentDay = 85
var year = 0
var currentSeason
var stringSeason

#----Population Stuff-------------------------------
var malePopulation = 10
var femalePopulation = 10
var childrenPopulation = 0
var provincePopulation
var populationGrowthRate = 0.008
var culture
var newPop = 0
var newBaby
#---Food Stuff---------------------------------------
var foodConsumption = 1
var foragedFood = 0

#----Resources Stuff---------------------------------
var water = 200
var timber = 50
var stone = 50
var flint = 50
var thatch = 200
var wildBerries = 200
var wildMeat = 200
#---Building Stuff----------------------------------
var timberCamp = 0
#----Hunger Functions-------------------------------
func AutoForage():
	rng.randomize()
	timber += rng.randf_range(0,1)
	stone += rng.randf_range(0,2)
	flint += rng.randf_range(0,1)
	water += rng.randf_range(5,10) + femalePopulation
	wildBerries += rng.randf_range(10,20) + femalePopulation
	wildMeat += rng.randf_range(5,10) + malePopulation

func ForagerFoodConsumption():
	wildBerries -= provincePopulation
	wildMeat -= provincePopulation
	water -= provincePopulation * 2
	foragedFood = wildBerries + wildMeat
	
#----Population Functions----------------------------
func PopulationGrowth():
	provincePopulation = malePopulation + femalePopulation + childrenPopulation
	if(malePopulation >= 1) and (femalePopulation >= 1):
		newPop += populationGrowthRate * (femalePopulation / 4)
		print("New Pops: " + str(newPop))
		if (newPop >= 1):
			MakeABaby()

func MakeABaby():
	rng.randomize()
	newBaby = rng.randf_range(1,3)
	if(floor(newBaby) == 1):
		malePopulation += 1
		newPop = 0
	elif(floor(newBaby) == 2):
		femalePopulation += 1
		newPop = 0
#----Day Functions-----------------------------------
func EndDay():
	if (currentDay <= 365):
		currentDay += 1
	elif (currentDay > 365):
		currentDay = 0
		year += 1

func CheckSeason():
	if (currentDay >= 85 and currentDay <= 172):
		currentSeason = 2 #Spring
		stringSeason = "Spring"
	elif (currentDay >= 173 and currentDay <= 220):
		currentSeason = 3 #Summer
		stringSeason = "Summer"
	elif(currentDay >= 221 and currentDay <= 315):
		currentSeason = 4 #Fall
		stringSeason = "Fall"
	else:
		currentSeason = 1 #Winter
		stringSeason = "Winter"


#--------Building Functions----------------------------------------
func BuildTimberCamp():
	if (timber >= 10) and (stone >= 10):
		timber -= 10
		stone -= 10
		timberCamp += 1
	else:
		print("Not enough resources")
