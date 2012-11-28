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
		
		public function loadTestObj() : MovieClip
		{
			trace("Object Made");
			var obj:TestObj = new TestObj();
			
			obj.x = 300;
			obj.y = 100;
			
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			return obj;
		}
		
		public function loadHitObj() : MovieClip
		{
			trace("Object Made");
			var obj:HitObj = new HitObj();
			
			obj.x = 250;
			obj.y = 150;
			
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			return obj;
		}
		
		public function loadBlockObj() : MovieClip
		{
			trace("Object Made");
			var obj:BlockObj = new BlockObj();
			
			obj.x = 400;
			obj.y = 300;
			
			return obj;
		}
		
		public function loadPhysObj() : MovieClip
		{
			trace("Object Made");
			var obj:PhysObj = new PhysObj();
			
			obj.x = 100;
			obj.y = 100;
						
			return obj;
		}
		
		public function loadTestFloor() : MovieClip
		{
			trace("Floor Made");
			var obj:TestFloor = new TestFloor();
			
			obj.x = 400;
			obj.y = 400;
			
			return obj;
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
		
		public function loadUser(xPos:Number, yPos:Number, scale:Number=1):MovieClip
		{
			var obj:User = new User();
			
			obj.x = xPos;
			obj.y = yPos;
			
			obj.scaleX = scale;
			obj.scaleY = scale;
			
			obj.hardMove(1, 0);
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
						
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
	}
}