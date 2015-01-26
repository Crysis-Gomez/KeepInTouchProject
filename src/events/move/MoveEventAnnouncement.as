package events.move
{
	import events.core.GameEventAnnouncement;
	import flash.events.TimerEvent;
	import objects.PlayerIcon;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MoveEventAnnouncement extends GameEventAnnouncement
	{	
		private var icon1:PlayerIcon
		private var icon2:PlayerIcon;
		private var icon3:PlayerIcon;
		private var icon4:PlayerIcon;;
		private var distanceTravelled:Number = 0;
		
		public function MoveEventAnnouncement(eventType:int, playScreen:PlayScreen, play:Function)
		{
			super(eventType, playScreen, play);
		}
		
		override public function draw():void
		{
			
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
			super.draw();
		}
		
		override public function updateTimer(e:TimerEvent):void
		{
			super.updateTimer(e);
			
			var speed:Number = (200 / e.target.repeatCount)*1.5;
			if (distanceTravelled > 200) return;
			icon1.x += speed;
			icon2.y += speed;
			icon3.x -= speed;
			icon4.y -= speed;
			distanceTravelled += speed;
		}
	
	}

}