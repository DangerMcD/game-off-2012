package
{
	import flash.display.MovieClip;
	
	public class DataManager
	{
		private var main:Main;
		public function DataManager(m:Main)
		{
			main = m;
		}
		
		public function loadTestObj() : MovieClip
		{
			trace("Object Made");
			var obj:TestObj = new TestObj();
			
			obj.x = 300;
			obj.y = 300;
			
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			return obj;
		}
		
		public function loadHitObj() : MovieClip
		{
			trace("Object Made");
			var obj:HitObj = new HitObj();
			
			obj.x = 250;
			obj.y = 250;
			
			obj.attachMouseHighlight();
			obj.attachMouseSelection(main.game.player);
			return obj;
		}
		
		public function loadBlockObj() : MovieClip
		{
			trace("Object Made");
			var obj:BlockObj = new BlockObj();
			
			obj.x = 400;
			obj.y = 400;
			
			return obj;
		}
	}
}