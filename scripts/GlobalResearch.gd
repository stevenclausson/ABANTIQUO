extends Node

var rng = RandomNumberGenerator.new()

var research = 0
var baseResearchRate = 0.01
var researchRateBonus = 0
var newResearch = false

var gameDialogTitle = ""
var gameDialogText = ""
var gameDialogBonusText = ""


#Early Neolithic Ideas---------------------------
var hunterGathererIdea = 1
var ancestralRitesIdea = 0
var allowDolmen = false

var tribalismIdea = 0
var foragingIdea = 0

var leadershipIdea = 0
var allowLeader = false

var sedentaryIdea = 0
#---Early Neolithic Inventions-----------
var knappingInvention
var knapping = false
var knappingBonus = 0
var spearInvention
var spearing = false
var toolmakingInvention
var toolMaking = false

#Stone Age Ideas--------------------------
var loggingIdea = 0
var slaveryIdea = 0
#Copper Age Ideas------------------------

func CheckHordeIdeas():
	if (research >= 10) and (Global.provincePopulation >= 20) and (foragingIdea == 0):
		ForagingBonus()
		newResearch = true
	if (research >= 20) and (Global.provincePopulation >= 20) and (ancestralRitesIdea == 0):
		AncestralRites()
		newResearch = true
	if (research >= 150) and (Global.provincePopulation >= 50):
		research -= 100
		SpawnLeadership()
	if(research >= 450) and (Global.dolem >= 1) and (Global.provincePopulation >= 120):
		research -= 150
		SpawnSedentaryism()

func CheckNeolithicIdeas():
	pass

#-----------------INVENTIONS-------------------------

func InventionChecker():
	rng.randomize()
	var getInvention = rng.randi_range(0,100)
	print(getInvention)
	if(getInvention == 1) and (knapping == false):
		knapping == true
		KnappingInvention()

func KnappingInvention():
	knappingBonus += 5
	gameDialogTitle = "New Invention!"
	gameDialogText = "Striking stone tools against a hard surface has yielded surprising results!"
	gameDialogBonusText = "- Bonus to foraging output.\n- Bonus to hunting ouput."

func CheckNeolithicInventions():
	KnappingInvention()


func ForagingBonus():
	newResearch = false
	foragingIdea = 1
	Global.foragingBonus += 5
	gameDialogTitle = "New Research!"
	gameDialogText = "With your people's excellent foraging experience, you've learned new and faster ways to find the ripest of picks..."
	gameDialogBonusText = "- Bonus to foraging output."

func SpawnLeadership():
	Global.maxDominionLevel += 25
	allowLeader = true

func AncestralRites():
	newResearch = false
	ancestralRitesIdea = 1
	allowDolmen = true
	gameDialogTitle = "New Research!"
	gameDialogText = "Your people have pondered under the immense, beautiful night sky. They have wondered about life and what becomes of themselves after death..."
	gameDialogBonusText = "- Can Build Dolmen"

func SpawnSedentaryism():
	sedentaryIdea == 1
	CheckStoneAgeIdeas()

func CheckStoneAgeIdeas():
	if (research >= 1000) and (Global.provincePopulation >= 500) and (Global.timberCamp >= 10):
		TimberLogging()

func TimberLogging():
	loggingIdea == 1
	#Global.timberGatherRate += 2 + 
