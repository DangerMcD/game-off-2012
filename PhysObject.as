package
{
	import flash.geom.Rectangle;
	import flash.display.*;
	//PhysObjects are gameobjects that move
	public class PhysObject extends GameObject
	{
		var speed:Number;
		var velX:Number;
		var velY:Number;
		
		var sleeping:Boolean;
		
		public function PhysObject()
		{
			speed = 350;
			velX = 0;
			velY = 0;
			sleeping = true;
		}
		
		//Overrides movement
		public function hardMove(vX:Number, vY:Number)
		{
			velX = vX;
			velY = vY;
			sleeping = false;
		}
		
		//Additive movement
		public function addMove(vX:Number, vY:Number)
		{
			velX += vX;
			if(velX > speed)
				velX = speed;
			if(velX < -speed)
				velX = -speed;
			
			velY += vY;
			sleeping = false;
		}
		
		//Quality of Life Jump function
		public function jump(vY:Number)
		{
			//Not perfect solution, possibility of 0 at peak of jump
			if(velY == 0)
			{
				velY += vY;
				sleeping = false;
			}
		}
		
		public function action()
		{
			//overridable function for when action key is pressed
			trace("Physics ACTION");
		}
	}
}