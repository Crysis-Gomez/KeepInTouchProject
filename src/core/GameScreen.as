package core 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameScreen extends Sprite
	{
		public var game:Game;
		public var active:Boolean;
		
		public static var ACTIVATE:String = "activate";		
		public static var DEACTIVATE:String = "deactivate";
		
		public function GameScreen() 
		{
			
		}
		
		public function close():void {
			if (active) game.closeActiveScreen();
			else game.removeScreen(this);
		}
		
		
		
		public function doFrame(inputState:InputState, previousInputState:InputState):void {
			//set the mouse position
			inputState.mouseX = 0;
			inputState.mouseY = 0;
			
			
			//handle input
			if (inputState.space && !previousInputState.space) keySpacePressed();
			if (inputState.enter && !previousInputState.enter) keyEnterPressed();
			if (inputState.escape && !previousInputState.escape) keyEscapePressed();
			if (inputState.up && !previousInputState.up) keyUpPressed();
			if (inputState.down && !previousInputState.down) keyDownPressed();
			if (inputState.left && !previousInputState.left) keyLeftPressed();
			if (inputState.right && !previousInputState.right) keyRightPressed();
			if (inputState.mouseButton && !previousInputState.mouseButton) mouseButtonPressed();
			
		}
		
		protected function keySpacePressed():void {
			//this function should be overriden in descendent classes
		}
		
		protected function keyEnterPressed():void {
			//this function should be overriden in descendent classes
		}
		
		protected function keyEscapePressed():void {
			//this function should be overriden in descendent classes
		}			
		
		protected function keyUpPressed():void {
			//this function should be overriden in descendent classes
		}			
		
		protected function keyDownPressed():void {
			//this function should be overriden in descendent classes
		}			
		
		protected function keyLeftPressed():void {
			//this function should be overriden in descendent classes
		}			
		
		protected function keyRightPressed():void {
			//this function should be overriden in descendent classes
		}			
		
		protected function mouseButtonPressed():void {
			//this function should be overriden in descendent classes
		}			
	}

}