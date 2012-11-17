package
{
	import flash.events.MouseEvent;
	import flash.events.EventPhase;
	
	//Player class to store player references, selections, and motivations
	public class Player
	{
		private var currentSelection : Array;
		
		public function Player()
		{
			currentSelection = new Array();
		}
		
		//Add to selection of objects
		public function addSelection(obj:GameObject)
		{
			obj.removeMouseHighlight();
			obj.removeMouseSelection(this);
			currentSelection.push(obj);
			trace("Selection: " + currentSelection.length);
		}
		
		//Remove from selection of objects
		public function removeSelection(obj:GameObject)
		{
			obj.attachMouseHighlight();
			obj.attachMouseSelection(this);
			obj.removeGlow();
			var i:int = currentSelection.indexOf(obj);
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
			trace("PRESS ON OBJ");
			clearSelection();
		}
		
		public function compareStageSelection(e:MouseEvent)
		{
			if(e.eventPhase!=EventPhase.BUBBLING_PHASE)
			{
				trace("PRESS ON STAGE");
				clearSelection();
			}
		}
		
		public function mouseSelection(e:MouseEvent)
		{
			trace("SELECTED: " + e.currentTarget);
			clearSelection();
			addSelection(GameObject(e.currentTarget));
		}
	}
}