extends Node

var rng = RandomNumberGenerator.new()

#----Game Text-----------------------------------------------------------
var resourceAlert = false
var gameDialogTitle = ""
var gameDialogText = ""
var gameDialogBonusText = ""

var sickTrait
var sickTraitText = "You are terribly sick."
var humbleTrait
var humbleTraitText = "Humble as they come."

#---CULTURE STUFF-------------------------------------
var culture
var cultureText = "" # Don't need to save
var cultureBonus1 = 0
var cultureBonus2 = 0
var cultureBonus3 = 0

#---TIME STUFF----------------------------------------
var monthCheck = 0
var currentDay = 85
var year = 0
var currentSeason # Don't need to save
var seasonBonus = 0
var seasonMalus
var stringSeason # Don't need to save

#----Population Stuff-------------------------------
var malePopulation = 10
var femalePopulation = 10
var childrenPopulation = 0
var provincePopulation # Don't need to save
var populationGrowthRate = 0.006
var civilizedLevel = ""
var newPop = 0 # Don't need to save
var newBaby # Don't need to save
var hunterGathererPops = 0
var tribalPops = 0
var slavePops = 0
var noblePops = 0
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
var thatchGatherRate = 0

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
#-----Government Stuff--------------------------------
var tribalism = false
var moneyName = ""
#---Leader Stuff------------------------------------
var rulerName = ""
var rulerInt = 0
var rulerStr = 0
var rulerCha = 0
var rulerHealth = 100
var rulerTrait1 = 0
var rulerTrait2 = 0
var rulerTrait3 = 0
var rulerTrait4 = 0
var rulerTrait5 = 0
var rulerTreasury = 0
#----Hunger Functions-------------------------------
func AutoForage():
	rng.randomize()
	timber += rng.randf_range(0,1)
	stone += rng.randf_range(0,2)
	flint += rng.randf_range(0,1)
	water += rng.randf_range(20,40) + (femalePopulation + waterGatherRate) + cultureBonus3
	wildBerries += (rng.randf_range(10,20) + (femalePopulation + foragingBonus)) * seasonBonus
	wildMeat += rng.randf_range(8,15) + malePopulation + huntingBonus + GlobalResearch.knappingBonus * seasonBonus

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
		malePopulation -= rng.randi_range(0,2)
		femalePopulation -= rng.randi_range(0,2)

func SeasonalBonuses():
	if(currentSeason == 1):
		seasonBonus = 0
	elif(currentSeason == 2):
		seasonBonus = 1.2
	elif(currentSeason == 3):
		seasonBonus = 2
	elif(currentSeason == 4):
		seasonBonus = 1.6

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
		var cultureBonus1 = 0.002 #Population growth
		var cultureBonus2 = 50 #City Defense
		var cultureBonus3 = 5 #Rice output
	elif(culture == 1):
		cultureText = "Yarmukian"
		var cultureBonus1 = 8 #Pottery
		var cultureBonus2 = 2 #Administration
		var cultureBonus3 = 5 #Water Output
	elif (culture == 2):
		cultureText = "Faiyum"
		var cultureBonus1 = 10 #Grain Output
		var cultureBonus2 = 2 #Weaving
		var cultureBonus3 = 5 #Foraging
	elif (culture == 3):
		cultureText = "Vinca"
		var cultureBonus1 = 8 # Wheat
		var cultureBonus2 = 0.002 # Pop Growth
		var cultureBonus3 = 5 #Barley Production
		
func SocialStatusSpread():
	if (GlobalResearch.hunterGathererIdea == 1):
		hunterGathererPops = malePopulation + femalePopulation + childrenPopulation
	if (tribalism == true):
		tribalPops = malePopulation + femalePopulation + childrenPopulation
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
	if(provincePopulation >= 25) and (dolmen <= (provincePopulation * 0.05)):
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
