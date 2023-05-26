extends Node

var research = 0
var baseResearchRate = 0.01
var researchRateBonus = 0
var newResearch = false

var gameDialogTitle = ""
var gameDialogText = ""



#Early Neolithic Ideas---------------------------
var ancestralRites = 0
var allowDolmen = false

var tribalism = 0
var foraging = 0
var leadership = 0
var sedentaryIdea = 0
#Stone Age Ideas--------------------------
var loggingIdea = 0
#Copper Age Ideas------------------------

func CheckHordeIdeas():
	if (research >= 10) and (Global.provincePopulation >= 20) and (foraging == 0):
		ForagingBonus()
		newResearch = true
	if (research >= 20) and (Global.provincePopulation >= 20) and (ancestralRites == 0):
		AncestralRites()
		newResearch = true
	if (research >= 150) and (Global.provincePopulation >= 50):
		research -= 100
		SpawnLeadership()
	if(research >= 450) and (Global.dolem >= 1) and (Global.provincePopulation >= 120):
		research -= 150
		SpawnSedentaryism()
		
func ForagingBonus():
	print("ForagingBonus foraging is " + str(foraging))
	newResearch = false
	foraging = 1
	Global.foragingBonus += 5
	gameDialogTitle = "New Research!"
	gameDialogText = "With your people's excellent foraging experience, you've learned new and faster ways to find the ripest of picks..."

func SpawnLeadership():
	Global.maxDominionLevel += 25

func AncestralRites():
	newResearch = false
	ancestralRites = 1
	allowDolmen = true
	gameDialogTitle = "New Research!"
	gameDialogText = "Your people have pondered under the immense, beautiful night sky. They have wondered about life and what becomes of themselves after death..."

func SpawnSedentaryism():
	sedentaryIdea == 1
	CheckStoneAgeIdeas()

func CheckStoneAgeIdeas():
	if (research >= 1000) and (Global.provincePopulation >= 500) and (Global.timberCamp >= 10):
		TimberLogging()

func TimberLogging():
	loggingIdea == 1
	#Global.timberGatherRate += 2 + 
