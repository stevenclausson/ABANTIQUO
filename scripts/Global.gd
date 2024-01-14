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
var lastDayOfMonth = 0
var year = 0
var currentSeason # Don't need to save
var AgricultureSeasonBonus = 0
var seasonMalus
var stringSeason # Don't need to save

#----Population Stuff-------------------------------
var malePopulation = 0
var femalePopulation = 0
var adultMalePopulation = 0
var adultFemalePopulation = 0
var maleChildrenPopulation = 0
var femaleChildrenPopulation = 0
var maleBabyPopulation = 0
var femaleBabyPopulation = 0
var babyPopulation = 0
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
var starvationPopup
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
var wildHides = 0
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
	timber += rng.randf_range(0,1) * (adultMalePopulation * 0.2)
	stone += rng.randf_range(0,2) * (adultMalePopulation * 0.2)
	flint += rng.randf_range(0,1) * (adultMalePopulation * 0.2)
	water += rng.randf_range(20,40) + (femalePopulation + waterGatherRate) + cultureBonus3
	wildBerries += (rng.randf_range(10,20) + (adultFemalePopulation + foragingBonus)) * AgricultureSeasonBonus
	wildMeat += rng.randf_range(8,15) * (adultMalePopulation * 0.2) + huntingBonus + GlobalResearch.knappingBonus * AgricultureSeasonBonus
	wildHides += rng.randf_range(3,9) * (adultMalePopulation * 0.2) + huntingBonus + GlobalResearch.knappingBonus

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

func PopulationClothed():
	wildHides -= (malePopulation + femalePopulation) * 0.02

func StarvationCheck():
	if (foragedFood <= 1) or (water <= 1):
		isStarving = true
		starvingDays += 1
		starvationPopup = true
		if (starvationPopup == true):
			resourceAlert = true
			gameDialogTitle = "STARVATION"
			gameDialogText = "The people are starving! We must do something fast!"
			starvationPopup = false
		IsStarving()
	else: 
		isStarving = false

func IsStarving():
	if (isStarving == true) and (starvingDays >= 3):
		rng.randomize()
		adultMalePopulation -= rng.randi_range(0,2)
		adultFemalePopulation -= rng.randi_range(0,2)
		femaleChildrenPopulation -= rng.randi_range(0,1)
		maleChildrenPopulation -= rng.randi_range(0,1)

func SeasonalBonuses():
	if(currentSeason == 1):
		AgricultureSeasonBonus = 0
	elif(currentSeason == 2):
		AgricultureSeasonBonus = 1.2
	elif(currentSeason == 3):
		AgricultureSeasonBonus = 2
	elif(currentSeason == 4):
		AgricultureSeasonBonus = 1.6

#----Population Functions----------------------------
func PopulationGrowth():
	provincePopulation = malePopulation + femalePopulation + femaleBabyPopulation
	malePopulation = maleChildrenPopulation + adultMalePopulation + maleBabyPopulation
	femalePopulation = femaleChildrenPopulation + adultFemalePopulation + femaleBabyPopulation
	if(adultMalePopulation >= 1) and (adultFemalePopulation >= 1):
		newPop += (adultFemalePopulation / 4) * populationGrowthRate
		print("New Pops: " + str(newPop))
		if (newPop >= 1):
			MakeABaby()

func MakeABaby():
	rng.randomize()
	newBaby = rng.randf_range(1,3)
	if(floor(newBaby) == 1):
		maleBabyPopulation += 1
		newPop = 0
	elif(floor(newBaby) == 2):
		femaleBabyPopulation += 1
		newPop = 0

func MakeAChild():
	rng.randomize()
	var newchild = rng.randf_range(1,8)
	if (newchild == 4):
		if (maleBabyPopulation > 4):
			maleBabyPopulation -= floor(maleBabyPopulation / 4)
			maleChildrenPopulation += floor(maleBabyPopulation / 4)
		else:
			maleBabyPopulation -= 1
			maleChildrenPopulation += 1
	elif (newchild == 8):
		if ( femaleBabyPopulation > 4):
			femaleBabyPopulation -= floor(femaleBabyPopulation / 4)
			femaleChildrenPopulation += floor(femaleBabyPopulation / 4)
		else:
			femaleBabyPopulation -= 1
			maleChildrenPopulation += 1

func BecomeAdult():
	rng.randomize()
	var newAdult = rng.randf_range(1,8)
	if (newAdult == 2):
		if (maleChildrenPopulation > 4):
			maleChildrenPopulation -= floor(maleChildrenPopulation / 4)
			adultMalePopulation += floor(maleChildrenPopulation / 4)
		else:
			maleChildrenPopulation -= 1
			adultMalePopulation += 1
	elif (newAdult == 3):
		if (femaleChildrenPopulation > 4):
			femaleChildrenPopulation -= floor(femaleChildrenPopulation / 4)
			adultFemalePopulation += floor(femaleChildrenPopulation / 4)
		else:
			femaleChildrenPopulation -= 1
			adultFemalePopulation += 1

func CheckCulture():
	if (culture == 0):
		cultureText = "Daxi"
		cultureBonus1 = 0.002 #Population growth
		cultureBonus2 = 50 #City Defense
		cultureBonus3 = 5 #Rice output
	elif(culture == 1):
		cultureText = "Yarmukian"
		cultureBonus1 = 8 #Pottery
		cultureBonus2 = 2 #Administration
		cultureBonus3 = 5 #Water Output
	elif (culture == 2):
		cultureText = "Faiyum"
		cultureBonus1 = 10 #Grain Output
		cultureBonus2 = 2 #Weaving
		cultureBonus3 = 5 #Foraging
	elif (culture == 3):
		cultureText = "Vinca"
		cultureBonus1 = 8 # Wheat
		cultureBonus2 = 0.002 # Pop Growth
		cultureBonus3 = 5 #Barley Production
	else:
		culture == 0
		cultureText = "Daxi"
		cultureBonus1 = 0.002 #Population growth
		cultureBonus2 = 50 #City Defense
		cultureBonus3 = 5 #Rice output

func SocialStatusSpread():
	if (GlobalResearch.hunterGathererIdea == 1):
		hunterGathererPops = malePopulation + femalePopulation
	if (tribalism == true):
		tribalPops = malePopulation + femalePopulation
#----Day Functions-----------------------------------
func EndDay():
	if (currentDay <= 365):
		currentDay += 1
	elif (currentDay > 365):
		currentDay = 0
		year += 1
	if (lastDayOfMonth <= 30):
		lastDayOfMonth += 1
	elif (lastDayOfMonth > 30):
		EndMonth()
		lastDayOfMonth = 0

func EndMonth():
	PopulationClothed()
	MakeAChild()
	BecomeAdult()
	print("End Month")

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
			timber -= 120
			stone -= 240 
			flint -= 100
			dolmen += 1
			dominionLevel += 1
			GlobalResearch.research += 0.01
	else:
		resourceAlert = true
		gameDialogTitle = "Not enough resources!"
		gameDialogText = "You do not have enough resources to complete this building!"
