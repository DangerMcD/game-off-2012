package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	
	public class Main extends MovieClip
	{
		public var game: Game;
		private var dataM: DataManager;
		private var input: InputManager;
		
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
			
			game.addObject(dataM.loadTestObj());
			game.addObject(dataM.loadBlockObj());
			
			lastTime = 0;
			curTime = 0;
			dt = 0;
			fps = 0;
			
			//Attach Listeners
			addEventListener(Event.ENTER_FRAME, Update);
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, game.player.compareMouseSelection);
			//this.addEventListener(MouseEvent.CLICK, game.player.compareMouseSelection);
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
					game.removeObject(MovieClip(this.getChildAt(0)));
					break;
				//A
				case 65:
					game.clearWorld();
					break;
				//S
				case 83:
					game.addObject(dataM.loadTestObj());
					break;
				//D
				case 68:
					game.addObject(dataM.loadHitObj());
					break;
				//Q
				case 81:
					game.addObject(dataM.loadBlockObj());
					break;
				//E
				case 69:
					break;
				//SPACE
				case 32:
					game.player.clearSelection();
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