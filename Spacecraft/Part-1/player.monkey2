Namespace spacecraft

'A player class which extends the GameObject class. this means that it wil inherit all of the functionality 
'contained in the GameObject class.
Class Player Extends GameObject
	
	'We will need to know which way the player is facing, so lets store that in a vec2f
	Field Facing:Vec2f = New Vec2f
	
	Method New(game:SpaceCraft)
		Super.New(game)
		
		'Add a control Component to the player
		AddComponent(New Controls("Controls", Self))
	End
	
End

'The player will need to be controlled, so we can use make a new Controlls class that extends Component
Class Controls Extends Component
	'Store a reference to the player
	Field Player:Player
	
	'Make our own New Method that lets us pass in the player that the component belongs to.
	Method New (name:String, player:Player)
		Super.New(name)
		Player = player
	End

	'Override the abstract Update method where we can put in the functionality that we need to control the player
	Method Update() Override
		'Get the mouse coordinates and convert them to world coordinates so we can figure out where the player
		'needs to be facing
		Local target:=Player.Game.ScreenToWorld(New Vec2f(Mouse.X, Mouse.Y))
		'Subtract the player coords from the mouse coords 
		Player.Facing = target - Player.XY
		'Normalize the Facing vector
		Player.Facing = Player.Facing.Normalize()
		'Use the facing vector calculate the angle of the player
		Player.Rotation = ATan2(Player.Facing.x, Player.Facing.y)
		
		'Out image doesn't naturally line up how we want so offset it a bit (3.14159rad is equal to 180 degrees)
		Player.Rotation = Player.Rotation + 3.14159
	End

End