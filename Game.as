package
{
	import flash.display.MovieClip;
	
	public class Game
	{
		//Needs 
		
		//Game Objects
		//Physics
		//Input
		//Player
		
		private var main:Main;
		private var worldObjects: Array;
		public var player:Player;
		
		public function Game(m:Main)
		{
			main = m;
			
			worldObjects = new Array();
			player = new Player();
			
			trace("Game Created");
		}
		
		//Add Object to World
		public function addObject(obj:MovieClip)
		{
			worldObjects.push(obj);
			main.addChild(obj);
						
			trace("Objects: " + worldObjects.length);
		}
		
		//Remove Object From World
		public function removeObject(obj:MovieClip)
		{
			var i:int = worldObjects.indexOf(obj);
			worldObjects.splice(i, 1);
			player.removeSelection(GameObject(obj));
			main.removeChild(obj);
			trace("Objects: " + worldObjects.length);
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
			trace("Objects: " + worldObjects.length);
		}
		
		public function Update(dt:Number)
		{
		}
	}
}