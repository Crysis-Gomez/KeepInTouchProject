package events.switch 
{
	import core.world.GameWorld;
	import events.core.GameEventAnnouncement;
	import flash.events.TimerEvent;
	import objects.PlayerIcon;
	
	/**
	 * ...
	 * @author 
	 */
	public class SwitchEventAnnouncement extends GameEventAnnouncement 
	{
		private var icon1:PlayerIcon;
		private var icon2:PlayerIcon;
		private var icon3:PlayerIcon;
		private var icon4:PlayerIcon;
		
		public function SwitchEventAnnouncement(eventType:int, playScreen:GameWorld, play:Function) 
		{
			super(eventType, playScreen, play);
			
		}
		
		override public function draw():void 
		{
			super.draw();
			icon1 = new PlayerIcon(0xFF0000, 50, 0);
			icon2 = new PlayerIcon(0xFF8000, 50, 0);
			icon3 = new PlayerIcon(0x00FF00, 50, 0);
			icon4 = new PlayerIcon(0xFFFF00, 50, 0);
			
			icon1.draw();
			icon2.draw();
			icon3.draw();
			icon4.draw();
			
			icon1.x = -100;
			icon1.y = -100;
			
			icon2.x = 100;
			icon2.y = -100;
			
			icon3.x = 100;
			icon3.y = 100;
			
			icon4.x = -100;
			icon4.y = 100;
			
			addChild(icon1);
			addChild(icon2);
			addChild(icon3);
			addChild(icon4);
		}
		
		override public function updateTimer(e:TimerEvent):void 
		{
			super.updateTimer(e);
			if (e.target.currentCount >= e.target.repeatCount/3) {
				icon
			}
		}
		
	}

}