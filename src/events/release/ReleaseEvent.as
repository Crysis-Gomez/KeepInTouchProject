package events.release
{
	import events.core.EventManager;
	import events.core.GameEvent;
	import events.core.GameEventTimer;
	import objects.PlayerArea;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author
	 */
	public class ReleaseEvent extends GameEvent
	{
		private var checkedDone:Boolean;
		
		public function ReleaseEvent(playScreen:PlayScreen)
		{
			super(playScreen);
			eventType = RELEASE_EVENT;
			
			if (AppData.gameSpeed == "slow") {
				timeFinished = 300;
			} else {
				timeFinished = 150;
			}
		}
		
		override public function announce():void
		{
			super.announce();
			var announce:ReleaseEventAnnouncement = new ReleaseEventAnnouncement(eventType, playScreen, play);
			announce.start();
		}
		
		override public function update(playerArea:PlayerArea):void
		{
			if (timeCounter == 0 && !playerArea.hasTouchPoint)
			{
				
				playerArea.eventFailed = true;
			}
			
			super.update(playerArea);
			if (playerArea.playerID == playScreen.playerAreas.length - 1)
				timeCounter++;
			
			var progress:Number = (timeCounter / timeFinished) * 100;
			timer.update(progress);
			if (!playerArea.eventDone)
			{
				if (timeCounter >= timeFinished)
				{
					playerArea.eventDone = true;
				}
				else
				{
					if (playerArea.previousHasTouchPoint && !playerArea.hasTouchPoint && !playerArea.eventFailed)
					{
						playerArea.eventDone = true;
						playerArea.eventPassed = true;
					}
				}
			}
			else
			{
				if (checkIfEveryOneFinished() && !checkedDone)
				{
					resolveEvent();
					checkedDone = true;
				}
			}
		}
		
		private function resolveEvent():void
		{
			trace("----" + eventType + "----");
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				if (aPlayerArea.eventPassed)
				{
					aPlayerArea.eventPassed = true;
					aPlayerArea.scoreCounter += 1;
				}
				else
				{
					aPlayerArea.eventFailed = true;
					aPlayerArea.scoreCounter += -1;
				}
				
			}
			if (playScreen.contains(timer))
			{
				playScreen.removeChild(timer);
			}
			Util.wait(readyForNewEvent, 1000);
			
			trace("-----------------------");
		}
		
		private function readyForNewEvent():void
		{
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				aPlayerArea.removeEvent();
			}
			EventManager.getInstance().playEvent();
		}
		
		override public function play():void
		{
			super.play();
			timer = new GameEventTimer();
			timer.x = 1920 * 0.5;
			timer.y = 1080 * 0.5;
			playScreen.addChild(timer);
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				aPlayerArea.setEvent(this, null);
			}
		}
	}

}