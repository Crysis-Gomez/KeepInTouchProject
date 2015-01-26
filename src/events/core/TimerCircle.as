package events.core
{
	import flash.display.BlendMode;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TimerCircle extends Sprite
	{
		private var degree:Number;
		private var circleR:Number;
		private var innerR:Number;
		private var shFill:Sprite;
		private var shFill2:Sprite;
		
		public function TimerCircle()
		{
			
			degree = 0; // Initial angle
			
			
			circleR = 300; // Circle radius (in pixels)
			innerR = circleR - 20;
			
			var overlayCircle:Sprite = new Sprite();
			overlayCircle.graphics.beginFill(0x000000);
			overlayCircle.graphics.drawCircle(0, 0, innerR);
			overlayCircle.graphics.endFill();
			
			shFill = new Sprite();
			shFill.graphics.lineStyle(1, 0xFFFFFF);
			shFill.graphics.moveTo(0, 0);
			shFill.graphics.lineTo(circleR, 0);
			shFill.x = 0;
			shFill.y = 0;
			
			shFill.blendMode = BlendMode.LAYER;
			overlayCircle.blendMode = BlendMode.ERASE;
			
			addChild(shFill);
			
			shFill.addChild(overlayCircle);
		
		}
		
		public function updatePicture(t:Number):void
		{
			var radianAngle:Number = t * Math.PI / 180.0;
			var i:int;
			
			shFill.graphics.clear();
			
			//shFill.graphics.lineStyle(1, 0x00000);
			
			shFill.graphics.moveTo(0, 0);
			
			shFill.graphics.beginFill(0xFFFFFF);
			
			// The loop draws tiny lines between points on the circle one separated from each other by one degree.
			for (i = 0; i <= t; i++)
			{
				shFill.graphics.lineTo(circleR * Math.cos(i * Math.PI / 180), -circleR * Math.sin(i * Math.PI / 180));
			}
			//The final lineTo outside of the loop takes the "pen" back to its starting point.
			shFill.graphics.lineTo(0, 0);
			//Since the drawing is between beginFill and endFill, we get the filled shape.
			shFill.graphics.endFill();
			//-------------------------------------------------------------------------------------------------------------------
			//shFill2.graphics.clear();
			//
			//shFill2.graphics.lineStyle(1, 0x000000);
			//
			//shFill2.graphics.moveTo(0, 0);
			//
			//shFill2.graphics.beginFill(0xFF0000);
			//
			// The loop draws tiny lines between points on the circle one separated from each other by one degree.
			//for (i = 0; i <= t; i++)
			//{
				//shFill2.graphics.lineTo(innerR * Math.cos(i * Math.PI / 180), -innerR * Math.sin(i * Math.PI / 180));
				//
			//}
			//The final lineTo outside of the loop takes the "pen" back to its starting point.
			//shFill2.graphics.lineTo(0, 0);
			//Since the drawing is between beginFill and endFill, we get the filled shape.
			//shFill2.graphics.endFill();
		}
	}

}