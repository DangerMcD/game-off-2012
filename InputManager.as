package
{
	//Input class to interpret asynchronous as well as smooth movement
	public class InputManager
	{
		//NO ENUMS IN AS3, THIS IS WHY I DRINK
		public static const W:uint = 87;
		public static const A:uint = 65;
		public static const S:uint = 83;
		public static const D:uint = 68;
		public static const Q:uint = 81;
		public static const E:uint = 69;
		public static const R:uint = 82;
		public static const SPACE:uint = 32;
		
		private var keyW:Boolean;
		private var keyA:Boolean;
		private var keyS:Boolean;
		private var keyD:Boolean;
		private var keyQ:Boolean;
		private var keyE:Boolean;
		private var keyR:Boolean;
		private var keySPACE:Boolean;
						
		public function InputManager()
		{
			keyW = keyA = keyS = keyD = keyQ = keyE = keySPACE = false;
		}
		
		public function keyDown(key:uint):Boolean
		{
			switch(key)
			{
				case W:
					return keyW;
				case A:
					return keyA;
				case S:
					return keyS;
				case D:
					return keyD;
				case Q:
					return keyQ;
				case E:
					return keyE;
				case R:
					return keyR;
				case SPACE:
					return keySPACE;
				default:
					return false;
			}
		}
		
		//FALSE IF UP, TRUE IF DOWN
		public function Press(code:int)
		{
			switch(code)
			{
				case W:
					keyW = true;
					break;
				case A:
					keyA = true;
					break;
				case S:
					keyS = true;
					break;
				case D:
					keyD = true;
					break;
				case Q:
					keyQ = true;
					break;
				case E:
					keyE = true;
					break;
				case R:
					keyR = true;
					break;
				case SPACE:
					keySPACE = true;
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
				case W:
					keyW = false;
					break;
				case A:
					keyA = false;
					break;
				case S:
					keyS = false;
					break;
				case D:
					keyD = false;
					break;
				case Q:
					keyQ = false;
					break;
				case E:
					keyE = false;
					break;
				case R:
					keyR = false;
					break;
				case SPACE:
					keySPACE = false;
					break;
				default:
					break;
			}
		}
	}
}