extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var myIndex

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("Looping through TileMap")
	for x in range(38):
		for y in range(38):
			#print(x)
			#print(y)
			myIndex = get_node("TileMap").get_cell(x,y)
			#print(myIndex)
			if (myIndex == 1):
				print("life detected on " + "("+String(x)+","+String(y)+")")
			#print("("+String(x)+","+String(y)+") = "+ String(myIndex))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
