extends Node

var rng = RandomNumberGenerator.new()

#----Game Text-----------------------------------------------------------
var resourceAlert = false
var gameDialogTitle = ""
var gameDialogText = ""


#---TIME STUFF----------------------------------------
var monthCheck = 0
var currentDay = 85
var year = 0
var currentSeason # Don't need to save
var stringSeason # Don't need to save

#----Population Stuff-------------------------------
var malePopulation = 10
var femalePopulation = 10
var childrenPopulation = 0
var provincePopulation # Don't need to save
var populationGrowthRate = 0.006
var culture
var cultureText = "" # Don't need to save
var civilizedLevel = ""
var newPop = 0 # Don't need to save
var newBaby # Don't need to save
#---Food Stuff---------------------------------------
var foodConsumption = 1
var foragedFood = 0
var foragingBonus = 0
var isStarving = false
var starvingDays = 0
#----Resources Stuff---------------------------------
var water = 200
var waterGatherRate = 0

var timber = 50
var timberGatherRate = 0

var stone = 50
var stoneGatherRate = 0

var flint = 50
var flintGatherRate = 0

var thatch = 200
var wildBerries = 100
var wildMeat = 50
var huntingBonus = 0
#---Building Stuff----------------------------------
var timberCamp = 0
var flintCamp = 0
var stoneCamp = 0
var primitiveWell = 0
var huntersCamp = 0
var dolmen = 0
#-------Progress Level Values------------------------
var dominionLevel = 1
var maxDominionLevel = 10
#----Hunger Functions-------------------------------
func AutoForage():
	rng.randomize()
	timber += rng.randf_range(0,1)
	stone += rng.randf_range(0,2)
	flint += rng.randf_range(0,1)
	water += rng.randf_range(20,40) + (femalePopulation + waterGatherRate)
	wildBerries += rng.randf_range(10,20) + femalePopulation + foragingBonus
	wildMeat += rng.randf_range(8,15) + malePopulation + huntingBonus

func ForagerFoodConsumption():
	wildBerries -= provincePopulation
	wildMeat -= provincePopulation
	water -= provincePopulation * 2
	foragedFood = wildBerries + wildMeat
	if (wildBerries <= 1):
		wildBerries = 0
	if (wildMeat <= 1):
		wildMeat = 0
	if (water <= 1):
		water = 0

func StarvationCheck():
	if (foragedFood <= 1) or (water <= 1):
		isStarving = true
		starvingDays += 1
		IsStarving()
	else: 
		isStarving = false

func IsStarving():
	if (isStarving == true) and (starvingDays >= 3):
		rng.randomize()
		malePopulation -= rng.randf_range(0,2)
		femalePopulation -= rng.randf_range(0,2)


#----Population Functions----------------------------
func PopulationGrowth():
	provincePopulation = malePopulation + femalePopulation + childrenPopulation
	if(malePopulation >= 1) and (femalePopulation >= 1):
		newPop += (femalePopulation / 4) * populationGrowthRate
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

func CheckCulture():
	if (culture == 0):
		cultureText = "Daxi"
	elif(culture == 1):
		cultureText = "Yarmukian"
	elif (culture == 2):
		cultureText = "Faiyum"
	elif (culture == 3):
		cultureText = "Vinca"
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

func GatherResources():
	timber += timberGatherRate

#--------Building Functions----------------------------------------
func BuildTimberCamp():
	if (timber >= 20) and (stone >= 20) and (flint >= 40):
		timber -= 10
		stone -= 10
		timberCamp += 1
		dominionLevel += 1
		timberGatherRate += 1
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"
		

func BuildFlintCamp():
	if (timber >= 50) and (stone >= 40) and (flint >= 10):
		timber -= 50
		stone -= 40 
		flint -= 10 
		flintCamp += 1
		dominionLevel += 1
		flintGatherRate += 1
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"

func BuildStoneCamp():
	if (timber >= 50) and (stone >= 10) and (flint >= 50):
		timber -= 50
		stone -= 10 
		flint -= 50
		stoneCamp += 1
		dominionLevel += 1
		stoneGatherRate += 1
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"

func BuildPrimitiveWell():
	if (timber >= 50) and (stone >= 90) and (flint >= 10):
		timber -= 50
		stone -= 90 
		flint -= 10
		primitiveWell += 1
		dominionLevel += 1
		waterGatherRate += 50
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"

func BuildHuntersCamp():
	if (timber >= 90) and (stone >= 60) and (flint >= 90):
		timber -= 90
		stone -= 60
		flint -= 90
		huntersCamp += 1
		dominionLevel += 1
		huntingBonus += 2
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"

func BuildDolmen():
	if (timber >= 120) and (stone >= 240) and (flint >= 100):
		timber -= 100
		stone -= 240 
		flint -= 100
		dolmen += 1
		dominionLevel += 1
		GlobalResearch.research += 0.01
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"
