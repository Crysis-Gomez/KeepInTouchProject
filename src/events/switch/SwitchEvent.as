package events.switch 
{
	import events.core.GameEvent;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author 
	 */
	public class SwitchEvent extends GameEvent 
	{
		
		public function SwitchEvent(playScreen:PlayScreen) 
		{
			super(playScreen);
			SWITCH_EVENT
		}
		
		override public function announce():void 
		{
			super.announce();
			var announce:SwitchEventAnnouncement = new SwitchEventAnnouncement(eve
		}
		
	}

}