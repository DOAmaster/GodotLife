extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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

# 1 = life   |   4 = dead
# Called when the node enters the scene tree for the first time.
func _ready():
	xRange = 100
	yRange = 100
	running = true
	while(running):
		yield(get_tree().create_timer(.5), "timeout")
		processGeneration()
	pass # Replace with function body.

func processGeneration():
	for x in range(xRange):
		for y in range(yRange):
			currentVector = Vector2(x,y)
			myIndex = get_node("TileMap").get_cell(x,y)
			#print(myIndex)
			#if (myIndex == 1):
			neighborsAlive = 0
			#print("life detected on " + "("+String(x)+","+String(y)+")")
			neighbor1 = get_node("TileMap").get_cell(x-1,y-1)
			neighbor2 = get_node("TileMap").get_cell(x,y-1)
			neighbor3 = get_node("TileMap").get_cell(x+1,y-1)
			neighbor4 = get_node("TileMap").get_cell(x-1,y)
			neighbor5 = get_node("TileMap").get_cell(x+1,y)
			neighbor6 = get_node("TileMap").get_cell(x-1,y+1)
			neighbor7 = get_node("TileMap").get_cell(x,y+1)
			neighbor8 = get_node("TileMap").get_cell(x+1,y+1)
			if(neighbor1 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor2 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor3 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor4 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor5 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor6 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor7 == 1): neighborsAlive = neighborsAlive + 1
			if(neighbor8 == 1): neighborsAlive = neighborsAlive + 1
			#Any live cell with fewer than two live neighbours dies, as if by underpopulation.
			if(neighborsAlive < 2):
				get_node("TileMap").set_cellv(currentVector,4)
			#Any live cell with two or three live neighbours lives on to the next generation.
			if(neighborsAlive == 2 || neighborsAlive == 3):
				get_node("TileMap").set_cellv(currentVector,1)
			#Any live cell with more than three live neighbours dies, as if by overpopulation.
			if(neighborsAlive > 3):
				get_node("TileMap").set_cellv(currentVector,4)
			#Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
			if(neighborsAlive == 3):
				get_node("TileMap").set_cellv(currentVector,1)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	yield(get_tree().create_timer(.1), "timeout")
#	processGeneration()
#	pass
