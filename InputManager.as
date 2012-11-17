package
{
	//Probably don't need it, we'll see
	public class InputManager
	{
		//NO ENUMS IN AS3, THIS IS WHY I DRINK
		var W:Boolean;
		var A:Boolean;
		var S:Boolean;
		var D:Boolean;
		var Q:Boolean;
		var E:Boolean;
		var SPACE:Boolean;
				
		public function InputManager()
		{
			W = A = S = D = Q = E = SPACE = false;
		}
		
		//FALSE IF UP, TRUE IF DOWN
		public function Press(code:int)
		{
			switch(code)
			{
				//W
				case 87:
					W = true;
					break;
				//A
				case 65:
					A = true;
					break;
				//S
				case 83:
					S = true;
					break;
				//D
				case 68:
					D = true;
					break;
				//Q
				case 81:
					Q = true;
					break;
				//E
				case 69:
					E = true;
					break;
				//SPACE
				case 32:
					SPACE = true;
					break;
				default:
					break;
			}
		}
		
		//FALSE IF UP, TRUE IF DOWN
		public function Release(code:int)
		{
			switch(code)
			{
				//W
				case 87:
					W = false;
					break;
				//A
				case 65:
					A = false;
					break;
				//S
				case 83:
					S = false;
					break;
				//D
				case 68:
					D = false;
					break;
				//Q
				case 81:
					Q = false;
					break;
				//E
				case 69:
					E = false;
					break;
				//SPACE
				case 32:
					SPACE = false;
					break;
				default:
					break;
			}
		}
	}
}