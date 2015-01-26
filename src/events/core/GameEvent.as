package events.core
{
	import core.world.GameWorld;
	import objects.PlayerArea;
	import screen.PlayScreen;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameEvent 
	{
		public var playScreen:PlayScreen;
		
		public static const TOUCH_EVENT:int = 0;
		public static const MOVE_EVENT:int = 1;
		public static const RELEASE_EVENT:int = 2;
		public static const HOLD_EVENT:int = 3;
		public static const SWITCH_EVENT:int = 4;
		public static const HOLDOFF_EVENT:int = 5;
		public static const BALL_EVENT:int = 6
		static public const AMOUNTOFEVENTS:int = 4;
		
		public var eventType:int;
		
		public var timeCounter:Number = 0;
		public var timeFinished:Number = 300;
		public var timer:GameEventTimer;
		
		public function GameEvent(playScreen:PlayScreen) 
		{
			this.playScreen = playScreen;
			
		}
		
		public function play():void
		{
			//Should be overwritten
		}
		
		public function announce():void
		{
			//Should be overwritten
		}
		
		public function update(playerArea:PlayerArea):void 
		{
			//should be overwritten
		}
		
		public function checkIfEveryOneFinished():Boolean
		{
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				if (!aPlayerArea.eventDone)
				{
					return false;
				}
				
			}
			return true;
		}
	}

}