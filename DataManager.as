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