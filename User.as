﻿package 
{
	import flash.display.MovieClip;
	public class User extends PhysObject
	{
		public static const SIZE_4:uint=8;
		public static const SIZE_3:uint=4;
		public static const SIZE_2:uint=2;
		public static const SIZE_1:uint=1;

		public static const GREY:uint=0;
		public var color:uint=GREY;

		//Cloning stuff
		public var splits:uint;
		public var maxSplits:uint;
		public var master:User;

		public var attached:GameObject=null;
		public var possibleAttach:GameObject=null;

		public function User()
		{
			//size = maxSize = 4;
			splits=maxSplits=SIZE_3;
		}
		
		public function setSplits(size:int)
		{
			splits=maxSplits=size;
		}
		
		//Clone/Split logic
		//Returns true if successful cloning
		public function cloneMe():Boolean
		{
			//size -= 1;

			splits-=1;
			if (splits<1)
			{
				splits=1;
				return false;
			}

			//trace("Cloning: " + size);
			return true;
		}

		//Combine to master
		//Returns true if successful combine
		public function combine():Boolean
		{
			//size+=1;
			if (master==this)
			{
				//size = maxSize;
				trace("Nothing to combine: ");
				return false;
			}
			return true;
		}

		public function cloneMaster()
		{
			splits-=1;

			if (splits<0)
			{
				splits=0;
			}
		}

		//Combine to master
		public function combineMaster(user:User)
		{
			if (user==this)
			{
				return;
			}

			splits+=1;

			if (splits>maxSplits)
			{
				splits=maxSplits;
			}

			assignScale();

			//assignSize();
		}

		//Assign a scale
		public function assignScale()
		{
			var newScale:Number=0;
			if (master==this)
			{
				newScale = (splits + maxSplits) / (maxSplits * 2);
				trace((splits / maxSplits) + ", " + newScale);
			}
			else
			{
				newScale = (SIZE_1 + maxSplits) / (maxSplits * 2);

			}
			this.scaleX=newScale;
			this.scaleY=newScale;
		}

		public function isAttached():Boolean
		{
			return attached != null;
		}

		private function canAttach():Boolean
		{
			return possibleAttach != null;
		}
		
		override public function removeGlow()
		{
			this.filters = [];
			if(master != null)
				master.filters = [];
		}
		
		override public function action(player:Player)
		{
			//Overriding action key
			trace("USER ACTION");
			if (canAttach()&& !isAttached())
			{
				if (possibleAttach is Task)
				{
					if (Task(possibleAttach).attachUser(this))
					{
						this.stopMove();
						attached=possibleAttach;
						player.removeSelection(this);
						player.addSelection(PhysObject(attached));
						attached.addGlow(null);
						trace("attached");
					}
				}
				else if(possibleAttach is Door && player.game.isComplete())
				{
					player.game.levelCompleted();
				}
			}
			else if (isAttached())
			{
				if (attached is Task)
				{
					Task(attached).removeUser(this);
					trace("unattached");
				}
				attached=null;
			}
		}

	}
}