package
{
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	
	//Player class to store player references, selections, and motivations
	public class Player
	{
		private var currentSelection : Array;
		public var game:Game;
		
		//Helper variables for single press
		private var ACTION:Boolean = false;
		private var CLONE:Boolean = false;
		private var COMBINE:Boolean = false;
		
		public function Player(g:Game)
		{
			game = g;
			currentSelection = new Array();
		}
		
		//Add to selection of objects
		public function addSelection(obj:PhysObject)
		{
			if(obj == null)
				return;
			obj.removeMouseHighlight();
			obj.removeMouseSelection(this);
			currentSelection.push(obj);
			
			if(currentSelection[0] is User)
			{
				var user:User = User(obj);
				if(user.master != null && user.master != user)
					user.master.addPoofGlow();
			}
			//trace("Selection: " + currentSelection.length);
		}
		
		//Remove from selection of objects
		public function removeSelection(obj:PhysObject)
		{
			if(obj == null)
				return;
			obj.attachMouseHighlight();
			obj.attachMouseSelection(this);
			obj.removeGlow();
			var i:int = currentSelection.indexOf(obj);
			if(i != -1)
				currentSelection.splice(i, 1);
		}
		
		//Clear all selections
		public function clearSelection()
		{
			while(currentSelection.length != 0)
			{
				var obj:GameObject = GameObject(currentSelection.pop());
				obj.attachMouseHighlight();
				obj.attachMouseSelection(this);
				obj.removeGlow();
			}
		}		
		
		public function compareObjSelection(e:MouseEvent)
		{
			//trace("PRESS ON OBJ");
			clearSelection();
		}
		
		public function compareStageSelection(e:MouseEvent)
		{
			if(e.eventPhase!=EventPhase.BUBBLING_PHASE)
			{
				//trace("PRESS ON STAGE");
				clearSelection();
			}
		}
		
		public function mouseSelection(e:MouseEvent)
		{
			trace("SELECTED: " + e.currentTarget);
			clearSelection();
			addSelection(e.currentTarget as PhysObject);
		}
		
		private function cloneUser(user:User)
		{
			//Root check for initial User
			if(user.master == null)
			{
				user.master = user;
				//user.master.splits -= 1;
			}
			
			if(user != user.master)
				return;
			
			var newUser:User = User(game.main.dataM.loadUser(user.x, user.y, 1.0));
						
			//Add master
			newUser.master = user.master;
			newUser.assignScale();
			
			//user.cloneMaster();
			user.assignScale();
			
			user.x -= newUser.width;
			newUser.x += newUser.width;
			
			//Force collision
			newUser.hardMove(1, 0);
			user.hardMove(1,0);
			
			game.addObject(newUser);
			
			trace("Total Splits: " + (user.master.maxSplits - user.master.splits));
		}
		
		private function combineUser(user:User)
		{
			//Get target for jump
			if(user.master == null || user.master == user)
			{
				trace("NO TARGET, GAME IS BROKE AS SHIT");
				return;
			}

			var master:User = User(user.master);			
			master.combineMaster(user);
			
			//Set selection data
			master.hardMove(1,0);
			addSelection(master);
			master.addGlow(null);
			
			trace("Split: " + (master.splits) + ", " + master.maxSplits);
			
			//Remove original
			game.removeObject(user);
		}
		
		//Get input
		//Tedious as hell, use some inheritance if time permits
		public function UpdateInput(input:InputManager)
		{
			if(currentSelection.length == 0)
				return;
			
			//Basic Handling
			if(input.keyDown(InputManager.W))
			{
				if(currentSelection[0] is User)
				{
					var user:User = User(currentSelection[0]);
					if(!user.isAttached())
						user.jump(-500);
				}
			}
			
			if(input.keyDown(InputManager.A))
			{
				if(currentSelection[0] is User)
				{
					user = User(currentSelection[0]);
					if(!user.isAttached())
						user.addMove(-350, 0);
				}
				else if(currentSelection[0] is Task)
				{
					var task:Task = Task(currentSelection[0]);
					task.currentDirection = -1;
				}
			}
			
			if(input.keyDown(InputManager.S))
			{				
				if(currentSelection[0] is User)
				{
					user = User(currentSelection[0]);
					if(!user.isAttached())
					{
						//user.scaleX += 0.01;
						//user.scaleY += 0.01;
					}
				}
				else if(currentSelection[0] is Task)
				{
					task = Task(currentSelection[0]);
					task.currentDirection = 0;
					game.checkCapture(task);
				}
			}
			
			if(input.keyDown(InputManager.D))
			{				
				if(currentSelection[0] is User)
				{
					user = User(currentSelection[0]);
					if(!user.isAttached())
					{
						user.addMove(350, 0);
					}
				}
				else if(currentSelection[0] is Task)
				{
					task = Task(currentSelection[0]);
					task.currentDirection = 1;
				}
			}
			
			if(input.keyDown(InputManager.Q))
			{
				if(currentSelection[0] is User)
				{
					user = User(currentSelection[0]);
					if(!COMBINE)
					{
						COMBINE = true;
						if(!user.isAttached() && user.combine())
							combineUser(user);
					}
				}
			}
			
			if(input.keyDown(InputManager.E))
			{
				if(currentSelection[0] is User)
				{
					user = User(currentSelection[0]);
					if(!CLONE)
					{
						CLONE = true;
						if(!user.isAttached() && user.cloneMe())
							cloneUser(user);
					}
				}
			}
			
			if(input.keyDown(InputManager.SPACE))
			{
				if(!ACTION)
				{
					ACTION = true;
					currentSelection[0].action(this);
				}
			}
			
			//Cycling for single press
			if(!input.keyDown(InputManager.Q))
			{
				COMBINE = false;
			}
			if(!input.keyDown(InputManager.E))
			{
				CLONE = false;
			}
			if(!input.keyDown(InputManager.SPACE))
			{
				ACTION = false;
			}
		}
	}
}