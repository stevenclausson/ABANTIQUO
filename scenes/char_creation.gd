extends Control


var message0 = "An Asian culture, considered to have the earliest moat and walled settlements. Choosing Daxi will grant the following bonuses: 
	+ Population
	+ City Defense(walls)
	+ Rice Output"
var message1 = "A Fertile Crescent culture known for it's extensive clay art, sophisticated street planning, and pottery. Choosing Yarmukian culture will grant the following bonuses:
	++ Pottery
	+ Administration
	+ Water Output"

var message2 = "Faiyum was a very old culture of immigrants and colonists in modern day Egypt. Choosing them will grant you:
	+ Grain Ouput
	+ Weaving
	+ Foraging Ouput"

var message3 = "Vinca were an extensive European culture noted for it's settlement sizes and rapid population growth for the area. Choosing Vinca will grant you: 
	++ Wheat Production
	+ Population Growth
	+ Barley Production"


func _on_option_button_item_selected(index):
	if (index == 0):
		$CanvasLayer/OptionButton/MessageLbl.text = message0
		Global.culture = 0
	elif(index == 1):
		Global.culture = 1
		$CanvasLayer/OptionButton/MessageLbl.text = message1
	elif(index == 2):
		Global.culture = 2
		$CanvasLayer/OptionButton/MessageLbl.text = message2
	elif(index == 3):
		Global.culture = 3
		$CanvasLayer/OptionButton/MessageLbl.text = message3


func _on_game_btn_pressed():
	pass # Replace with function body.


func _on_start_game_btn_pressed():
	Global.CheckCulture()
	Global.adultMalePopulation = 10
	Global.adultFemalePopulation = 10
	Global.maleChildrenPopulation = 2
	Global.femaleChildrenPopulation = 1
	get_tree().change_scene_to_file("res://scenes/PROVINCEGUI.tscn")
