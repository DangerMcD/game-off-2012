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
			if(user.partner != null)
				user.partner.addPoofGlow();
			else if(user.master != null)
				user.master.addPoofGlow();
			
			trace("Selection: " + currentSelection.length);
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
			
			//Check for root
			if(user.partner == null && user.master == null)
			{
				//You are your own best friend
				user.partner = user;
				user.master = user;
			}
			
			//If you came from the user, it is your root
			newUser.master = user;
			
			//Make split partner
			newUser.partner = user;
			user.partner = newUser;
			
			//Force collision
			newUser.hardMove(1, 0);
			user.hardMove(1,0);
			
			game.addObject(newUser);
		}
		
		private function combineUser(user:User)
		{
			var newScale:Number = user.size / user.maxSize;
			
			//The master branch is attached to this user, so don't kill him
			if(user.master == user)
			{
				user.x = user.partner.x;
				user.y = user.partner.y;
				user.scaleX = newScale;
				user.scaleY = newScale;
				user.hardMove(1,0);
				
				game.removeObject(user.partner);
			}
			else //The master branch is on your partner. Kill this user and go to partner
			{
				var master:User = user.partner;
				
				master.size = user.size;
				master.hardMove(1,0);
				master.scaleX = newScale;
				master.scaleY = newScale;
				addSelection(master);
				master.addGlow(null);
				master.partner = null;
				
				game.removeObject(user);
			}
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