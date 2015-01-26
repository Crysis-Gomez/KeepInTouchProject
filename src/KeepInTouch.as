package 
{
	import core.Game;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import screen.PlayScreen;
	import screen.StartScreen;
	import screen.WinningScreen;
	
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class KeepInTouch extends Game 
	{
		
		public function KeepInTouch():void 
		{
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.align = StageAlign.TOP_LEFT;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			//addScreen(new PlayScreen(AppData.amountOfPlayer, AppData.gameSpeed));
			addScreen(new StartScreen());		
			
			//Mouse.hide();
			
		}
		
	}
	
}