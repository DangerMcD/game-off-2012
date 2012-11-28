package
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class PhysicsManager
	{
		private var game:Game;
		
		private var gravity:Number = 600;
		
		public function PhysicsManager(g:Game)
		{
			game = g;
		}
		
		//Basic HitTests with MovieClip
		public function testBoxPoint(obj:MovieClip, x:Number, y:Number):Boolean
		{
			return obj.hitTestPoint(x, y);
		}
		
		//Pixel Perfect Collision
		public function testObjPoint(obj:MovieClip, x:Number, y:Number):Boolean
		{
			return obj.hitTestPoint(x, y, true);
		}
		
		//Basic Obj Box collision
		public function testAABB(obj1:MovieClip, obj2:MovieClip):Boolean
		{
			return obj1.hitTestObject(obj2);
		}
		
		public function testInside(obj1:PhysObject, obj2:PhysObject):Boolean
		{
			return true;
		}
		
		//AABB Collision for moving objects
		//Obj1 is the Object that will be "fixed", the currently moving object
		//Returns true if a fix happened
		public function resolveAABB(obj1:PhysObject, obj2:MovieClip):Boolean
		{			
			var box1:Rectangle = obj1.getRect(obj1.stage);
			var box2:Rectangle = obj2.getRect(obj1.stage);
			
			var fixX:Number = 0;
			var fixY:Number = 0;
			
			//Really basic box checks, maybe clean up
			
			if(box1.left >= box2.left && box1.left <= box2.right)
				fixX = box1.left - box2.right; 
			else if(box1.right >= box2.left && box1.right <= box2.right)
				fixX = box1.right - box2.left;
			else if(box1.right >= box2.right && box1.left <= box2.left)
				fixX = 1000000;
			
			if(box1.top >= box2.top && box1.top <= box2.bottom)
				fixY = box1.top - box2.bottom; 
			else if(box1.bottom >= box2.top && box1.bottom <= box2.bottom)
				fixY = box1.bottom - box2.top;
			else if(box1.bottom >= box2.bottom && box1.top <= box2.top)
				fixY = 1000000;
		
			if(fixX != 0 && fixY != 0)
			{				
				if(Math.abs(fixX) < Math.abs(fixY))
				{
					obj1.x -= fixX;
					obj1.velX = 0;
				}
				else
				{
					obj1.y -= fixY;
					obj1.velY = 0;
				}
				
				return true;
			}
			
			return false;
		}
		
		//Account for Physics in Movement
		public function moveBySpeed(obj:PhysObject, dt:Number)
		{
			//Move along by number as dictated by DT
			//Test for collisions along path
			//Set to sleep if it collides
			//Could use dot product to test if object is headed towards other object
			if(obj == null || obj.sleeping)
				return;
				
			obj.velY += gravity * dt;
				
			obj.x += obj.velX * dt;
			//Reset to avoid floaty ass controls
			obj.velX = 0;
			obj.y += obj.velY * dt;
			
			//Crap detection
			for(var i:int = 0; i < game.worldObjects.length; i++)
			{
				if(game.worldObjects[i] == obj || game.worldObjects[i] is PhysObject)
					continue;
				
				if(resolveAABB(obj, game.worldObjects[i]))
				{
					if(obj.velX == 0 && obj.velY == 0)
					{
						//trace(obj + "SLEEPING");
						obj.sleeping = true;
					}
				}
			}
		}
		
		//Quick and dirty way for finding user attachments
		public function findAttachments(gameObjects:Array)
		{
			for(var i:int = 0; i < gameObjects.length; i++)
			{
				if(!(gameObjects[i] is User))
					continue;
				else
				{
					var user:User = gameObjects[i];
					user.possibleAttach = null;
					for(var j:int = 0; j < gameObjects.length; j++)
					{
						if(gameObjects[j] == user)
							continue;
						//Could try attachment instead
						if(gameObjects[j] is Task)
						{
							if(testAABB(user, gameObjects[j]))
							{
								user.possibleAttach = gameObjects[j];
							}
						}
						else
						{
							continue;
						}
					}
				}
			}
		}
	}
}