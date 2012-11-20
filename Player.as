package
{
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	
	//Player class to store player references, selections, and motivations
	public class Player
	{
		private var currentSelection : Array;
		private var game:Game;
		
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
			
			var user:User = User(obj);
			
			if(user.getTarget() != null)
				user.getTarget().addPoofGlow();
			
			trace("Selection: " + user.targets.length);
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
			var newScale:Number = user.size / user.maxSize;
			user.scaleX = newScale;
			user.scaleY = newScale;
			
			var newUser:User = User(game.main.dataM.loadUser(user.x, user.y, newScale));
			
			newUser.size = user.size;
			newUser.maxSize = user.maxSize;
			
			//Add to targets
			user.addTarget(newUser);
			newUser.addTarget(user);
			
			//Force collision
			newUser.hardMove(1, 0);
			user.hardMove(1,0);
			
			game.addObject(newUser);
		}
		
		private function combineUser(user:User)
		{
			var newScale:Number = user.size / user.maxSize;
			
			//Get target for jump
			if(user.getTarget == null)
			{
				trace("NO TARGET, GAME IS BROKE AS SHIT");
				return;
			}
			var master:User = User(user.getTarget());
			
			//Set selection data
			master.size = user.size;
			master.hardMove(1,0);
			master.scaleX = newScale;
			master.scaleY = newScale;
			addSelection(master);
			master.addGlow(null);
			
			//Set target data
			user.removeTarget(master);
			master.removeTarget(user);
			master.joinTargets(user);
			
			//Poll list of users
			
			
			//Remove original
			game.removeObject(user);
		}
		
		//Pass in game too. Good chance a new object will need to be created or destroyed.
		public function UpdateInput(input:InputManager)
		{
			if(currentSelection.length == 0)
				return;
			
			//Basic Handling
			if(input.keyDown(InputManager.W))
			{
				currentSelection[0].jump(-500);
			}
			
			if(input.keyDown(InputManager.A))
			{
				currentSelection[0].addMove(-350, 0);
			}
			
			if(input.keyDown(InputManager.S))
			{
				currentSelection[0].scaleX += 0.01;
				currentSelection[0].scaleY += 0.01;
			}
			
			if(input.keyDown(InputManager.D))
			{
				currentSelection[0].addMove(350, 0);
			}
			
			if(input.keyDown(InputManager.Q))
			{
				if(!COMBINE)
				{
					COMBINE = true;
					if(User(currentSelection[0]).combine())
						combineUser(currentSelection[0] as User);
				}
			}
			
			if(input.keyDown(InputManager.E))
			{
				if(!CLONE)
				{
					CLONE = true;
					if(User(currentSelection[0]).cloneMe())
						cloneUser(currentSelection[0] as User);
				}
			}
			
			if(input.keyDown(InputManager.SPACE))
			{
				if(!ACTION)
				{
					ACTION = true;
					currentSelection[0].action();
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