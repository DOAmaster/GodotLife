extends Node2D

var myIndex
var neighbor1
var neighbor2
var neighbor3
var neighbor4
var neighbor5
var neighbor6
var neighbor7
var neighbor8
var running
var neighborsAlive
var currentVector
var xRange
var yRange
var setupCount
var setupIndex
var rng = RandomNumberGenerator.new()
var fate
var fateList
var fateDie
var genCount
var isPaused
var rngStart
var isEdit
# 1 = life   |   4 = dead
# Called when the node enters the scene tree for the first time.
func _ready():
	genCount = 0
	xRange = 100
	yRange = 100
	setupCount = 3
	isPaused =false
	isEdit = false
	rng.randomize()
	fateList = PoolVector2Array()
	fateDie = PoolVector2Array()
	rngStart = rng.randi_range(1,3)
	blankBoard()
	match rngStart:
		1:presetBoard1()
		2:presetBoard2()
		3:presetBoard3()
	running = true
	while(running):
		if(!isPaused):
			processGeneration()
			processBoard()
			genCount = genCount + 1
			updateUI()
			yield(get_tree().create_timer(.5), "timeout")
		else:
			yield(get_tree().create_timer(.5), "timeout")
	pass # Replace with function body.

func updateUI():
	get_node("GenCount").text = String(genCount)

func processBoard():
	for entry in fateList:
		#print(entry)
		get_node("TileMap").set_cellv(entry,1)
	for entry in fateDie:
		#print(entry)
		get_node("TileMap").set_cellv(entry,4)
	fateList = []
	fateDie = []
	pass

var firstGenPulsar = [Vector2(13, 24), Vector2(14, 23), Vector2(14, 24), Vector2(14, 25), Vector2(15, 23), Vector2(15, 25), Vector2(16, 23), Vector2(16, 24), Vector2(16, 25), Vector2(17, 24)];
var gliderGun = [Vector2(5, 1),Vector2(5, 2),Vector2(6, 1),Vector2(6, 2),Vector2(5, 11),Vector2(6, 11),Vector2(7, 11),Vector2(4, 12),Vector2(8, 12),Vector2(3, 13),Vector2(9, 13),Vector2(3, 14),Vector2(9, 14),Vector2(6, 15),Vector2(4, 16),Vector2(8, 16),Vector2(7, 17),Vector2(6, 17),Vector2(5, 17),Vector2(6, 18),Vector2(3, 21),Vector2(4, 21),Vector2(5, 21),Vector2(3, 22),Vector2(4, 22),Vector2(5, 22),Vector2(2, 23),Vector2(6, 23),Vector2(1, 25),Vector2(2, 25),Vector2(6, 25),Vector2(7, 25),Vector2(3, 35),Vector2(4, 35),Vector2(3, 36),Vector2(4, 36)];
var pulsar = [Vector2(10, 21),Vector2(10, 22),Vector2(10, 26),Vector2(10, 27),Vector2(9, 21),Vector2(9, 27),Vector2(8, 21),Vector2(8, 27),Vector2(12, 17),Vector2(12, 18),Vector2(12, 19),Vector2(12, 22),Vector2(12, 23),Vector2(12, 25),Vector2(12, 26), Vector2(12, 29),Vector2(12, 30),Vector2(12, 31),Vector2(13, 19),Vector2(13, 21),Vector2(13, 23),Vector2(13, 25),Vector2(13, 27),Vector2(13, 29),Vector2(14, 21),Vector2(14, 22),Vector2(14, 26),Vector2(14, 27),Vector2(16, 21),Vector2(16, 22),Vector2(16, 26),Vector2(16, 27),Vector2(17, 19),Vector2(17, 21),Vector2(17, 23),Vector2(17, 25),Vector2(17, 27),Vector2(17, 29),Vector2(18, 17),Vector2(18, 18),Vector2(18, 19),Vector2(18, 22),Vector2(18, 23),Vector2(18, 25),Vector2(18, 26), Vector2(18, 29),Vector2(18, 30),Vector2(18, 31),Vector2(20, 21),Vector2(20, 22),Vector2(20, 26),Vector2(20, 27),Vector2(21, 21),Vector2(21, 27),Vector2(22, 21),Vector2(22, 27)];
func presetBoard1():
	isPaused = true
	setupIndex = 0
	fateList = firstGenPulsar
	processBoard()
	yield(get_tree().create_timer(.5), "timeout")
	isPaused = false
	pass

func presetBoard2():
	isPaused = true
	setupIndex = 0
	fateList = gliderGun
	processBoard()
	yield(get_tree().create_timer(.5), "timeout")
	isPaused = false
	pass

func presetBoard3():
	isPaused = true
	setupIndex = 0
	fateList = pulsar
	processBoard()
	yield(get_tree().create_timer(.5), "timeout")
	isPaused = false
	pass

func clearBoard():
	print("Clearing Board")
	isPaused = true
	genCount = 0
	updateUI()
	fateList = []
	fateDie = []
	for x in range(xRange):
		for y in range(yRange):
			fateDie.append(Vector2(x,y))
	processBoard()

func blankBoard():
	print("Init Board")
	isPaused = true
	genCount = 0
	updateUI()
	fateList = []
	fateDie = []
	for x in range(xRange):
		for y in range(yRange):
			fateDie.append(Vector2(x,y))
	processBoard()
	pass

func processGeneration():
	for x in range(xRange):
		for y in range(yRange):
			#fate = false
			currentVector = Vector2(x,y)
			#get_node("TileMap").set_cellv(currentVector,4)
			myIndex = get_node("TileMap").get_cell(x,y)
			neighborsAlive = 0
			neighbor1 = get_node("TileMap").get_cell(x-1,y-1)
			neighbor2 = get_node("TileMap").get_cell(x-1,y)
			neighbor3 = get_node("TileMap").get_cell(x-1,y+1)
			neighbor4 = get_node("TileMap").get_cell(x,y-1)
			neighbor5 = get_node("TileMap").get_cell(x,y+1)
			neighbor6 = get_node("TileMap").get_cell(x+1,y-1)
			neighbor7 = get_node("TileMap").get_cell(x+1,y)
			neighbor8 = get_node("TileMap").get_cell(x+1,y+1)
			if(neighbor1 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor2 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor3 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor4 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor5 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor6 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor7 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor8 == 1): neighborsAlive = neighborsAlive + 1
			if(myIndex == 1):
				if(neighborsAlive < 2 || neighborsAlive > 3):
					fate = false
					fateDie.append(currentVector)
				else:
					fate = true
					fateList.append(currentVector)
			else:
				if(neighborsAlive == 3):
					fate = true
					fateList.append(currentVector)
				#else:
					#fate = false
					#fateDie.append(currentVector)
	pass

func _on_Stop_pressed():
	isPaused = true
	isEdit = false
	pass # Replace with function body.


func _on_Start_pressed():
	isPaused = false
	isEdit = false
	pass # Replace with function body.


func _on_Clear_pressed():
	clearBoard()
	pass # Replace with function body.

func _on_Preset1_pressed():
	clearBoard()
	presetBoard1()
	isEdit = false
	pass # Replace with function body.

func _on_Preset2_pressed():
	clearBoard()
	presetBoard2()
	isEdit = false
	pass # Replace with function body.


func _on_Preset3_pressed():
	clearBoard()
	presetBoard3()
	isEdit = false
	pass # Replace with function body.

var clickVectorx
var clickVectory
var clickVector
var myClickIndex
var myWorldIndex
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if(isEdit):
				clickVectorx = event.position.x
				clickVectory = event.position.y
				clickVector = Vector2(clickVectorx,clickVectory)
				#print(clickVector)
				myIndex = get_node("TileMap").get_cellv(clickVector)
				myClickIndex = get_node("TileMap").world_to_map(event.position)
				#print(myIndex)
				var mouse_tile = get_node("TileMap").world_to_map(get_global_mouse_position())
				#print(mouse_tile)
				print(myClickIndex)
				myWorldIndex = get_node("TileMap").get_cellv(mouse_tile)
				print(myWorldIndex)
				if (myWorldIndex == 4):
					get_node("TileMap").set_cellv(mouse_tile,1)
				elif (myWorldIndex == 1):
					get_node("TileMap").set_cellv(mouse_tile,4)
				clickVector = Vector2()
				myClickIndex = Vector2()

func _on_Edit_pressed():
	isPaused = true
	isEdit = true
	pass # Replace with function body.
