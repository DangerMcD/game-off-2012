﻿package
{
	import flash.display.MovieClip;
	
	public class Game
	{
		//Needs 
		
		//Game Objects
		//Physics
		//Input
		//Player
		
		public var main:Main;
		private var physics:PhysicsManager;
		
		public var worldObjects: Array;
		public var player:Player;
		
		public function Game(m:Main)
		{
			main = m;
			physics = new PhysicsManager(this);
			
			worldObjects = new Array();
			player = new Player(this);
			
			trace("Game Created");
		}
		
		//Add Object to World
		public function addObject(obj:MovieClip)
		{
			worldObjects.push(obj);
			main.addChild(obj);
						
			//trace("Objects: " + worldObjects.length);
		}
		
		//Remove Object From World
		public function removeObject(obj:MovieClip)
		{
			var i:int = worldObjects.indexOf(obj);
			if(i != -1)
				worldObjects.splice(i, 1);
			player.removeSelection(obj as PhysObject);
			main.removeChild(obj);
			//trace("Objects: " + worldObjects.length);
		}
		
		//Just Get Rid of Everything
		public function clearWorld()
		{
			while(worldObjects.length != 0)
			{
				var obj:MovieClip = worldObjects.pop();
				main.removeChild(obj);
			}
			player.clearSelection();
			//trace("Objects: " + worldObjects.length);
		}
		
		//Game Loop
		public function Update(dt:Number)
		{
			player.UpdateInput(main.input);
			for(var i:int = 0; i < worldObjects.length; i++)
			{
				physics.moveBySpeed(worldObjects[i] as PhysObject, dt);
			}
		}
	}
}