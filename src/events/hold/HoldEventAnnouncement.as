package events.hold 
{
	import core.world.GameWorld;
	import events.core.GameEventAnnouncement;
	import flash.events.TimerEvent;
	import objects.PlayerIcon;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HoldEventAnnouncement extends GameEventAnnouncement 
	{
		private var icon1:PlayerIcon;
		
		public function HoldEventAnnouncement(eventType:int, playScreen:GameWorld, play:Function) 
		{
			super(eventType, playScreen, play);
			
		}
		
		override public function draw():void 
		{
			super.draw();
			icon1 = new PlayerIcon(0xFF0000, 50, 0);
			icon1.draw();
			addChild(icon1);
		} 
		
		override public function updateTimer(e:TimerEvent):void 
		{
			super.updateTimer(e);
			
		}
		
	}

}