package
{
	import flash.display.MovieClip;
	import flash.filters.*;
	import flash.events.MouseEvent;
	//Super Class for all Game Objects
	//Contains helpers to manipulate Game Objects
	public class GameObject extends MovieClip
	{
		public function GameObject()
		{
		}
		
		//Attachment to make objects glow on mouse over
		public function attachMouseHighlight()
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, addHighlight);
			this.addEventListener(MouseEvent.MOUSE_OUT, removeHighlight);
		}
		
		public function removeMouseHighlight()
		{
			//trace("REMOVE HIGHLIGHT");
			this.removeEventListener(MouseEvent.MOUSE_OVER, addHighlight);
			this.removeEventListener(MouseEvent.MOUSE_OUT, removeHighlight);
		}
		
		//Attachment to make object selectable on mouse click
		public function attachMouseSelection(player:Player)
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, addGlow);
			this.addEventListener(MouseEvent.MOUSE_DOWN, player.mouseSelection);
		}
		
		public function removeMouseSelection(player:Player)
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, addGlow);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, player.mouseSelection);
		}
		
		//Highlight logic
		private function addHighlight(e:MouseEvent)
		{
			//IDEA: make static from game, reference it to check if glowing and which type of glow
			var glow:GlowFilter = new GlowFilter();
			
			glow.color = 0xFFCC32;
			glow.alpha = 1;
			glow.blurX = 40;
			glow.blurY = 40;
			glow.quality = BitmapFilterQuality.MEDIUM;
			
			this.filters = [glow];
		}
		
		private function removeHighlight(e:MouseEvent)
		{
			this.filters = [];
		}
		
		//Glow Logic
		public function addGlow(e:MouseEvent)
		{
			var glow:GlowFilter = new GlowFilter();
			
			glow.color = 0x00CC33;
			glow.alpha = 1;
			glow.blurX = 40;
			glow.blurY = 40;
			glow.quality = BitmapFilterQuality.MEDIUM;
			
			this.filters = [glow];
		}
		
		public function removeGlow()
		{
			this.filters = [];
		}
		
		public function addPoofGlow()
		{
			var glow:GlowFilter = new GlowFilter();
			
			glow.color = 0xCC3399;
			glow.alpha = 1;
			glow.blurX = 40;
			glow.blurY = 40;
			glow.quality = BitmapFilterQuality.MEDIUM;
			
			this.filters = [glow];
		}
		
		public function Update(dt:Number)
		{
		}
	}
}