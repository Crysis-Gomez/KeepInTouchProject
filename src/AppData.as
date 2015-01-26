package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class AppData 
	{
		static public const PLAYERCOLORS:Array = [0xFF8000, 0xFFFF00, 0x008000, 0x0000FF, 0x0080FF, 0x8000FF];

		
		//static public const CLICKEVENTTYPE:String = TouchEvent.TOUCH_BEGIN;
		static public const CLICKEVENTTYPE:String = MouseEvent.CLICK;
		
		static public var maxScore:int = 5;
		static public var amountOfPlayer:int = 4;
		static public var gameSpeed:String = "slow"
		
		public function AppData() 
		{
			
		}
		
		
		
	}

}