package
{
	import flash.display.MovieClip;
	public class User extends PhysObject
	{
		public static const GREY:uint = 0;		
		public var color:uint = GREY;
		
		//Cloning stuff
		public var size:uint;
		public var maxSize:uint;
		public var targets:Array = new Array();
		
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
			
			if(size > maxSize)
			{
				size = maxSize
				trace("Nothing to combine: " + size);
				return false;
			}
			trace("Combining: " + size);
			return true;
		}
		
		//Adds a poof target
		public function addTarget(user:User)
		{
			if(targets.indexOf(user) == -1)
				targets.push(user);
				
			trace("TARGETS: " + targets.length);
		}
		
		//Remove a target
		public function removeTarget(user:User)
		{
			var i:int = targets.indexOf(user);
			if(i != -1)
				targets.splice(i, 1);
		}
		
		//Get the latest target
		public function getTarget() : User
		{
			if(targets.length != 0)
				return targets[targets.length - 1];
			return null;
		}
		
		//Join the targets
		public function joinTargets(user:User)
		{
			targets = targets.concat(user.targets);
		}
		
		override public function action()
		{
			//Overriding action key
			trace("USER ACTION");
		}
		
	}
}