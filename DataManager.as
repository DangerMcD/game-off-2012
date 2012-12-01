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
					level3(main.game);
					break;
				case 4:
					level4(main.game);
					break;
				case 5:
					level5(main.game);
					break;
				case 6:
					level6(main.game);
					break;
				case 7:
					level7(main.game);
					break;
				case 8:
					level8(main.game);
					break;
				case 9:
					level9(main.game);
					break;
				case 10:
					level10(main.game);
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
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "Click on a User to select";
			game.main.txt2.text = "Use A and D to Move";
			game.main.txt2.y = 150;
			game.main.txt3.text = "Use SPACE to enter doors";
			game.main.txt3.y = 200;
			
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
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "";
			game.main.txt2.text = "Use W to Jump";
			game.main.txt2.x = 250;
			game.main.txt3.text = "";
			
			game.addDoor(loadDoor(650, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadPlatform(400, 275, 100, 150));
			game.addObject(loadUser(100, 100));
			
			game.checkCompletion();
			game.tasks = 0;
		}
		
		private function level3(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "Press SPACE next to Tasks to assign a User to them";
			game.main.txt2.text = "Task";
			game.main.txt2.x = 225;
			game.main.txt2.y = 200;
			game.main.txt3.text = "Move it here and press SPACE to open the door";
			game.main.txt3.y = 100;
			
			game.addCaptureZone(loadCaptureZone(650, 275, 250, 150));
			//game.addObject(dataM.loadPlatform(400, 275, 100, 150));
			game.addDoor(loadDoor(100, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadTask(400, 0));
			game.addObject(loadUser(100, 100));
			//game.addObject(loadUser(600, 0));
			
			game.tasks = 1;
		}
		
		private function level4(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "You can assign more than one user to a task to make it go faster";
			game.main.txt2.text = "";
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(650, 140, 200, 125));
			game.addDoor(loadDoor(100, 300));
			game.addObject(loadPlatform(500, 275, 575, 150));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadTask(400, 0));
			game.addObject(loadUser(100, 100));
			game.addObject(loadUser(150, 100));
			
			game.tasks = 1;
		}
		
		private function level5(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "Press S to stop moving and R to reset";
			game.main.txt2.text = "";
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(645, 100, 150, 100));
			game.addDoor(loadDoor(100, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadPlatform(385, 256, 425, 50));
			game.addObject(loadPlatform(500, 169, 440, 50));
			game.addObject(loadTask(300, 0, .5));
			game.addObject(loadUser(100, 100));
			//game.addObject(loadUser(600, 0));
			
			game.tasks = 1;
		}
		
		private function level6(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "Press E to clone a User";
			game.main.txt2.text = "Press Q to combine clones";
			game.main.txt2.y = 150;
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(650, 320, 125, 75));
			game.addDoor(loadDoor(100, 300));
			game.addObject(loadPlatform(400, 400, 800, 100));
			game.addObject(loadPlatform(500, 240, 550, 50));
			game.addObject(loadTask(200, 0, 0.5));
			game.addObject(loadUser(100, 100, User.SIZE_2));
			
			game.tasks = 1;
		}
		
		private function level7(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "";
			game.main.txt2.text = "";
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(650, 350, 150, 100));
			game.addDoor(loadDoor(100, 350));
			game.addObject(loadPlatform(400, 425, 800, 50));
			game.addObject(loadPlatform(400, 125, 550, 50));
			game.addObject(loadPlatform(50, 250, 50, 50));
			game.addObject(loadTask(175, 0, .5));
			game.addObject(loadTask(225, 250, .5));
			game.addObject(loadUser(125, 250, User.SIZE_2));
			
			game.tasks = 2;
		}
		
		private function level8(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "";
			game.main.txt2.y = 40;
			game.main.txt2.text = "You can clone a User until it is the same size as its clones";
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(650, 350, 150, 100));
			game.addDoor(loadDoor(100, 350));
			game.addObject(loadPlatform(400, 425, 800, 50));
			game.addObject(loadPlatform(150, 150, 300, 50));
			game.addObject(loadPlatform(650, 150, 300, 50));
			game.addObject(loadPlatform(500, 275, 600, 50));
			game.addObject(loadTask(50, 0, .5));
			game.addObject(loadTask(750, 0, .5));
			game.addObject(loadTask(225, 200, .5));
			game.addObject(loadUser(125, 250, User.SIZE_3));
			
			game.tasks = 3;
		}
		
		private function level9(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "";
			game.main.txt2.text = "";
			game.main.txt3.text = "";
			
			game.addCaptureZone(loadCaptureZone(650, 350, 150, 100));
			game.addDoor(loadDoor(100, 350));
			game.addObject(loadPlatform(400, 425, 800, 50));
			game.addObject(loadPlatform(225, 100, 300, 25));
			game.addObject(loadPlatform(650, 100, 300, 25));
			game.addObject(loadPlatform(500, 200, 600, 25));
			game.addObject(loadPlatform(66, 200, 125, 25));
			game.addObject(loadPlatform(250, 300, 300, 25));
			game.addObject(loadTask(150, 0, .4));
			game.addObject(loadTask(225, 0, .4));
			game.addObject(loadTask(300, 0, .4));
			game.addObject(loadTask(575, 0, .4));
			game.addObject(loadTask(675, 0, .4));
			game.addObject(loadUser(650, 275, User.SIZE_4));
			
			game.tasks = 5;
		}
		
		private function level10(game:Game)
		{
			//Wall Boundaries
			game.addObject(loadPlatform(-25, 225, 50, 900));
			game.addObject(loadPlatform(825, 225, 50, 900));
			
			//Tutorial stuff
			game.main.txt1.text = "That's all I had time to do!";
			game.main.txt1.x = 225;
			game.main.txt1.y = 100;
			game.main.txt2.text = "It was fun, thanks for playing!";
			game.main.txt2.x = 225;
			game.main.txt2.y = 175;
			game.main.txt3.text = "Created by Pat 'Danger' McDermott";
			game.main.txt3.x = 225;
			game.main.txt3.y = 300;
		
			game.tasks = 0;
		}
	}
}