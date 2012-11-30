package
{
	import flash.display.MovieClip;
	import flash.display.LineScaleMode;
	
	public class DataManager
	{
		private var main:Main;
		private var thickness:Number = 5;
		
		public function DataManager(m:Main)
		{
			main = m;
		}
		
		public function loadPlatform(xPos:Number, yPos:Number, w:Number, h:Number):MovieClip
		{
			var obj:Platform = new Platform();
			
			obj.x = xPos;
			obj.y = yPos;
			
			//Scaling without stroke (strokes should be visual)
			var xScale:Number = w / obj.getRect(obj).width;
			var yScale:Number = h / obj.getRect(obj).height;
						
			obj.scaleX = xScale;
			obj.scaleY = yScale;
			
			return obj;
		}
		
		public function loadUser(xPos:Number, yPos:Number, size:Number=1, scale:Number=1):MovieClip
		{
			var obj:User = new User();
			
			obj.x = xPos;
			obj.y = yPos;
			
			obj.scaleX = scale;
			obj.scaleY = scale;
			
			obj.hardMove(1, 0);
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			
			obj.setSplits(size);
			
			return obj;
		}
		
		public function loadTask(xPos:Number, yPos:Number, scale:Number = 1):MovieClip
		{
			var obj:Task = new Task();
			
			obj.x = xPos;
			obj.y = yPos;
			
			obj.scaleX = scale;
			obj.scaleY = scale;
			
			obj.hardMove(1, 0);
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			
			obj.addAttachment(new Attachment(50));
			obj.addAttachment(new Attachment(-50));
			
			return obj;
		}
		
		public function loadCaptureZone(xPos:Number, yPos:Number, w:Number, h:Number):MovieClip
		{
			var obj:Capture = new Capture();
			
			obj.x = xPos;
			obj.y = yPos;
			
			//Scaling without stroke (strokes should be visual)
			var xScale:Number = w / obj.getRect(obj).width;
			var yScale:Number = h / obj.getRect(obj).height;
						
			obj.scaleX = xScale;
			obj.scaleY = yScale;
			
			return obj;
		}
		
		public function loadDoor(xPos:Number, yPos:Number)
		{
			var obj:Door = new Door();
			
			obj.x = xPos;
			obj.y = yPos;
			
			return obj;
		}
		
		//Loads a level
		public function loadLevel(level:int)
		{
			main.game.clearWorld();
			switch(level)
			{
				case 1:
					level1(main.game);
					break;
				case 2:
					level2(main.game);
					break;
				case 3:
					break;
				case 4:
					break;
				case 5:
					break;
				default:
					break;
			}
			main.game.levelStart();
		}
		
		//Hardcoded Levels for prototype
		private function level1(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 450));
			game.addObject(loadPlatform(825, 225, 50, 450));
			
			game.addDoor(loadDoor(650, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			//game.addObject(loadTask(400, 0));
			game.addObject(loadUser(100, 100));
			
			game.checkCompletion();
			game.tasks = 0;
		}
		
		//Hardcoded Levels for prototype
		private function level2(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 450));
			game.addObject(loadPlatform(825, 225, 50, 450));
			
			game.addCaptureZone(loadCaptureZone(650, 275, 250, 150));
			//game.addObject(dataM.loadPlatform(400, 275, 100, 150));
			game.addDoor(loadDoor(100, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadTask(400, 0));
			game.addObject(loadUser(100, 100));
			game.addObject(loadUser(600, 0));
			
			game.tasks = 1;
		}
	}
}