package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	
	public class Main extends MovieClip
	{
		public var game: Game;
		public var dataM: DataManager;
		public var input: InputManager;
		
		private var lastTime: Number;
		private var curTime: Number;
		private var dt: Number;
		private var fps: int;
		
		public function Main()
		{
			trace("Main Created");
			Init();
		}
		
		//Init the game
		private function Init()
		{
			//Create Game
			game = new Game(this);
			
			dataM = new DataManager(this);
			input = new InputManager();
			
			dataM.loadLevel(game.level);			
			
			lastTime = 0;
			curTime = 0;
			dt = 0;
			fps = 0;
			
			//Attach Listeners
			addEventListener(Event.ENTER_FRAME, Update);
			
			//Create Main Priority for ANY mouse click
			stage.addEventListener(MouseEvent.MOUSE_DOWN, game.player.compareObjSelection, true, 100);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, game.player.compareStageSelection);
			
			//Keyboard Listener
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
		}
		
		//Updates the Game Loop, converts information into usable data for game
		private function Update(e:Event)
		{
			//Find dt
			curTime = getTimer( );
			dt = (curTime - lastTime)/1000;
			lastTime = curTime;
			
			fps = 1.0 / dt;
			
			game.Update(dt);
		}
		
		//Check Key Up Actions
		private function KeyUp(e:KeyboardEvent)
		{
			input.Release(e.keyCode);
			//Can override codes here
		}
		
		//Check Key Down Actions
		private function KeyDown(e:KeyboardEvent)
		{			
			input.Press(e.keyCode);
			//Can override codes here			
			switch(e.keyCode)
			{
				//W
				case 87:
					break;
				//A
				case 65:
					break;
				//S
				case 83:
					break;
				//D
				case 68:
					break;
				//Q
				case 81:
					break;
				//E
				case 69:
					break;
				//SPACE
				case 32:
					break;
				default:
					break;
			}
		}
		
		private function Destroy()
		{
			//Just in case destroy everything if something blows up
			game.clearWorld();
		}
	}
}