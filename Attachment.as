package
{
	import flash.display.MovieClip;
	//Simple attachment class to store attachment data for Task
	public class Attachment extends MovieClip
	{
		public var occupant:User = null;
		
		public function Attachment(xPos:int = 0, yPos:int = 0)
		{
			this.x = xPos;
			this.y = yPos;
			occupant = null;
		}
		
		public function attach(user:User)
		{
			occupant = user;
		}
		
		public function remove()
		{
			occupant = null;
		}
		
		public function isOccupied():Boolean
		{
			return occupant != null;
		}
	}
}