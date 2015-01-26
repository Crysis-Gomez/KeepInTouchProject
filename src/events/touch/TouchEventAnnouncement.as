package events.touch 
{
	import core.world.GameWorld;
	import events.core.GameEventAnnouncement;
	import flash.events.TimerEvent;
	import objects.PlayerIcon;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TouchEventAnnouncement extends GameEventAnnouncement 
	{
		private var icon1:PlayerIcon;
		private var tokenHeight:Number = 50;
		private var distanceTravelled:Number = 0;
		
		public function TouchEventAnnouncement(eventType:int, playScreen:GameWorld, play:Function) 
		{
			super(eventType, playScreen, play);
			
		}
		
		override public function draw():void 
		{
			super.draw();
			icon1 = new PlayerIcon(0xFF0000, 50, 0);
			icon1.draw(tokenHeight);
			addChild(icon1);
		} 
		
		override public function updateTimer(e:TimerEvent):void 
		{
			super.updateTimer(e);
			var speed:Number = (50 / e.target.repeatCount) * 4;
			if (distanceTravelled > 50) return;
			tokenHeight -= speed;
			icon1.draw(tokenHeight);
			distanceTravelled += speed;
			
		}
		
	}

}