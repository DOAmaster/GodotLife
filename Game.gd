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
# 1 = life   |   4 = dead
# Called when the node enters the scene tree for the first time.
func _ready():
	xRange = 100
	yRange = 100
	setupCount = 3
	running = true
	rng.randomize()
	fateList = PoolVector2Array()
	fateDie = PoolVector2Array()
	#clearBoard()
	#setupBoard()
	
	while(running):
		processGeneration()
		processBoard()
		yield(get_tree().create_timer(.5), "timeout")
	pass # Replace with function body.

func processBoard():
	for entry in fateList:
		#print(entry)
		get_node("TileMap").set_cellv(entry,1)
	for entry in fateDie:
		#print(entry)
		get_node("TileMap").set_cellv(entry,4)
	fateList.resize(0)
	fateDie.resize(0)
	pass

func setupBoard():
	setupIndex = 0
	clearBoard()
	while(setupIndex < setupCount):
		for x in range(xRange):
			for y in range(yRange):
				currentVector = Vector2(x,y)
				var my_random_number = rng.randi_range(1, 10)
				if(my_random_number == 1):
					get_node("TileMap").set_cellv(currentVector,1)
					setupIndex = setupIndex + 1
					break
				else:
					get_node("TileMap").set_cellv(currentVector,4)
	pass

func clearBoard():
	print("Clearing Board")
	for x in range(xRange):
		for y in range(yRange):
			currentVector = Vector2(x,y)
			get_node("TileMap").set_cellv(currentVector,4)

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
					fateList.append(currentVector)
				else:
					fate = true
					fateDie.append(currentVector)
			else:
				if(neighborsAlive == 3):
					fate = true
					fateList.append(currentVector)
				#else:
					#fate = false
					#fateDie.append(currentVector)
	pass

func _on_Stop_pressed():
	pass # Replace with function body.


func _on_Start_pressed():
	pass # Replace with function body.


func _on_Clear_pressed():
	clearBoard()
	pass # Replace with function body.


func _on_Reset_pressed():
	setupBoard()
	pass # Replace with function body.
