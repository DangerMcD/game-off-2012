package
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.filters.*;
	
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
		public var captureZone:Capture;
		
		//Timer for level time
		public var timer:Number;
		
		//Level numbers, just for level navigation
		public var level:int;
		
		public var tasks:int;
		public var tasksComplete:int;
		
		//Quick find for Door
		public var door:Door = null;
		
		//Text Fields
		var formatTxt:TextFormat = new TextFormat();
		var timeTxt:TextField = new TextField();
		
		public function Game(m:Main)
		{
			main = m;
			physics = new PhysicsManager(this);
			
			worldObjects = new Array();
			player = new Player(this);
			
			//Timer stuff
			timer = 0;
			
			//Start with level 1
			level = 1;
			
			//Text Stuff
			formatTxt.size = 22;
			formatTxt.font = "Trebuchet MS"
			timeTxt.x = 665;
			timeTxt.y = 10;
			timeTxt.width = 200;
			timeTxt.textColor = 0x000000;
			timeTxt.defaultTextFormat = formatTxt;
			timeTxt.selectable = false;
			
			//Create highlight effect on text
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xb5ffff;
			glow.alpha = 1;
			glow.blurX = 1.5;
			glow.blurY = 1.5;
			glow.strength = 100;
			glow.quality = BitmapFilterQuality.HIGH;
			timeTxt.filters = [glow];
			
			main.txt1.filters = [glow];
			main.txt2.filters = [glow];
			main.txt3.filters = [glow];
			
			main.addChild(timeTxt);
			
			trace("Game Created");
		}
		
		//Level state settings
		public function levelStart()
		{
			timer = 0;
			tasksComplete = 0
		}
		
		public function levelCompleted()
		{
			level += 1;
			main.dataM.loadLevel(level);
		}
		
		public function levelRestart()
		{
			main.dataM.loadLevel(level);
			levelStart();
		}
		
		//set the capture zone
		public function addCaptureZone(capture:MovieClip)
		{
			captureZone = Capture(capture);
			main.addChild(capture);
		}
		
		//set the capture zone
		public function addDoor(d:MovieClip)
		{
			door = Door(d);
			addObject(d);
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
			
			if(captureZone != null)
			{
				main.removeChild(captureZone);
				captureZone = null;
			}
			door = null;
			//trace("Objects: " + worldObjects.length);
		}
		
		public function checkCapture(task:Task)
		{
			if(!task.captured)
			{
				if(physics.testAABB(task, captureZone))
				{
					task.captured = true;
					task.currentDirection = 0;
					task.clearUsers();
					tasksComplete += 1;
					removeObject(task);
					checkCompletion();
				}
			}
		}
		
		public function checkCompletion()
		{
			if(isComplete())
			{
				door.gotoAndStop(2);
			}
		}
		
		public function isComplete():Boolean
		{
			return tasks == tasksComplete;
		}
		
		//Game Loop
		public function Update(dt:Number)
		{
			timer+=dt;
			timeTxt.text = "Time: " + convertTime();
			physics.findAttachments(worldObjects);
			player.UpdateInput(main.input);
			for(var i:int = 0; i < worldObjects.length; i++)
			{
				worldObjects[i].Update(dt);
				physics.moveBySpeed(worldObjects[i] as PhysObject, dt);
			}
		}
		
		private function convertTime() :String
		{
			var minutes:int = 0;
			var seconds:int = 0;

			seconds = int(timer);
			minutes = seconds / 60;
			seconds = seconds % 60;

			var sR:String = ""+seconds;
			
			if(seconds < 10)
				sR = "0" + sR;
			
			return "" + minutes + ":" + sR;
		}
	}
}