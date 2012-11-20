package
{
	public class User extends PhysObject
	{
		public static var GREY:uint = 0;		
		public var color:uint = GREY;
		
		//Cloning stuff
		public var size:uint;
		public var maxSize:uint;
		public var master:User = null;
		public var partner:User = null;
		
		public function User()
		{
			size = maxSize = 4;
		}
		
		//Clone/Split logic
		//Returns true if successful cloning
		public function cloneMe() : Boolean
		{
			size -= 1;
			
			if(size < 1)
			{
				size = 1;
				trace("Can't clone: " + size);
				return false;
			}
			trace("Cloning: " + size);
			return true;
		}
		
		//Combine to master
		//Returns true if successful combine
		public function combine() : Boolean
		{
			size += 1;
			
			if(size > maxSize || (partner == null && master == null))
			{
				size = maxSize
				trace("Nothing to combine: " + size);
				return false;
			}
			trace("Combining: " + size);
			return true;
		}
		
		override public function action()
		{
			//Overriding action key
			trace("USER ACTION");
		}
		
	}
}