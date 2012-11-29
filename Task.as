package
{
	//Tasks for Users
	public class Task extends PhysObject
	{
		//Users and Attachments
		private var users:Array;
		private var attachments:Array;
		
		//Direction of movement. 0 is stationary, 1 is right, -1 is left
		public var currentDirection:int = 0;
		
		public var captured:Boolean = false;
		
		public function Task()
		{
			users = new Array();
			attachments = new Array();
			speed = 0;
		}
		
		//Update loop to keep continuous movement
		override public function Update(dt:Number)
		{
			if(currentDirection != 0)
			{
				hardMoveX(currentDirection * speed);
				for(var i:int = 0; i < users.length; i++)
				{
					users[i].hardMoveX(currentDirection * speed);
				}
			}
		}
		
		//Attach User to Task
		public function attachUser(user:User) : Boolean
		{
			if(!captured && giveAttachment(user))
			{
				users.push(user);
				speed += 25;
				return true;
			}
			
			return false;
		}
		
		//Create an attachment
		public function addAttachment(attachment:Attachment)
		{
			attachments.push(attachment);
			//this.addChild(attachment);
		}
		
		//Remove the User
		public function removeUser(user:User)
		{
			for(var i:int = 0; i < attachments.length; i++)
			{
				if(attachments[i].occupant == user)
					attachments[i].remove();
			}
			
			i = users.indexOf(user);
			if(i != -1)
				users.splice(i, 1);
				
			speed -= 25;
		}
		
		//Remove all users
		public function clearUsers()
		{
			for(var i:int = 0; i < users.length; i++)
			{
				users[i].attached = null;
				removeUser(users[i]);
			}
		}
		
		//check for an attachment opportunity
		private function giveAttachment(user:User) :Boolean
		{
			for(var i:int = 0; i < attachments.length; i++)
			{
				if(attachments[i].isOccupied())
					continue;
				attachments[i].attach(user);
				return true;
			}
			
			return false;
		}
		
		override public function action(player:Player)
		{
			//Overriding action key
			trace("TASK ACTION");
			currentDirection = 0;
			
			player.game.checkCapture(this);
		}
	}
}