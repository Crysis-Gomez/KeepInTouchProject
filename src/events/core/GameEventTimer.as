package events.core 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author ...
	 */
	public class GameEventTimer extends Sprite
	{
		private var circle:TimerCircle;
		private var circle2:TimerCircle;
		private var circleRotation:Number = 180;
		
		public function GameEventTimer() 
		{
			circle = new TimerCircle();
			circle.updatePicture(circleRotation);
			
			circle.x = 0;
			circle.y = 0;
			circle.rotation = circleRotation / 2;
			this.addChild(circle);
			
			circle2 = new TimerCircle();
			circle2.updatePicture(circleRotation);
			
			circle2.x = 0;
			circle2.y = 0;
			circle2.rotation = 180 + circleRotation / 2;
			this.addChild(circle2);
		}
		
		public function update(progress:Number):void 
		{
			circleRotation = 180 - progress * (180 / 100);
				
				
			circle.updatePicture(circleRotation);
			circle2.updatePicture(circleRotation);
			
			circle.rotation = Math.round(circleRotation / 2);
			circle2.rotation = Math.round(180 + circleRotation / 2);
		}
		
	}

}