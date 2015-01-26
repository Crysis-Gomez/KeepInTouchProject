package events.core
{
	import core.Game;
	import core.world.GameWorld;
	import events.hold.HoldEvent;
	import events.move.MoveEvent;
	import events.release.ReleaseEvent;
	import events.touch.TouchEvent;
	import flash.desktop.NativeApplication;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author Jerry
	 * @author Jerry
	 */
	public class EventManager
	{
		public var gameWorld:GameWorld;
		static private var instance:EventManager;
		
		private var _playScreen:PlayScreen;
		private var roundCounter:int = 0;
		private var eventsToPickFrom:Array = [GameEvent.RELEASE_EVENT, GameEvent.HOLD_EVENT, GameEvent.MOVE_EVENT];
		public var speed:String = "slow";
		
		public function EventManager(caller:Function = null)
		{
			if (caller != EventManager.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (EventManager.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
		}
		
		public function playEvent():void
		{
			roundCounter++;
			///this should be a random event  maybe? so the player doesnt know which event comes next
			
			var eventType:int = eventsToPickFrom[Math.round(Math.random() * (eventsToPickFrom.length - 1))];
			trace(eventType);
			if (eventType == GameEvent.RELEASE_EVENT) {
				eventsToPickFrom = [GameEvent.TOUCH_EVENT]
			}
			
			if (eventType ==  GameEvent.TOUCH_EVENT) {
				eventsToPickFrom = [GameEvent.RELEASE_EVENT, GameEvent.HOLD_EVENT, GameEvent.MOVE_EVENT]
			}
			
			switch(eventType)
			{
				case GameEvent.TOUCH_EVENT:
					var touch:TouchEvent = new TouchEvent(_playScreen);
					touch.announce();
					break;
				case GameEvent.MOVE_EVENT: 
					var move:MoveEvent = new MoveEvent(_playScreen);
					move.announce();
					break;
				case GameEvent.RELEASE_EVENT:
					var release:ReleaseEvent = new ReleaseEvent(_playScreen);
					release.announce();
					break;
				case GameEvent.HOLD_EVENT:
					var hold:HoldEvent = new HoldEvent(_playScreen);
					hold.announce();
					break;
				default: 
			}
		}
		
		static public function getInstance():EventManager
		{
			if (instance == null)
				instance = new EventManager(arguments.callee);
			return instance;
		}
		
		public function get playScreen():PlayScreen
		{
			return _playScreen;
		}
		
		public function set playScreen(value:PlayScreen):void
		{
			_playScreen = value;
		}
	
	}

}