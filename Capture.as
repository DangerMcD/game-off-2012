package
{
	import flash.display.MovieClip;
	//Basic capture class for capture zone
	public class Capture extends MovieClip
	{
		var total:int = 0;
		var current:int = 0;
		
		public function Capture()
		{
		}
		
		//add to total
		public function addTotal(i:int)
		{
			total += i;
		}
		
		//add to current
		public function addCapture(i:int)
		{
			current += i;
		}
		
		//If it is completed
		public function isCompleted():Boolean
		{
			return current == total;
		}
	}
}