package core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class Game extends Sprite
	{
		private var _screens:Array;
		//private var _mask:Sprite;
		private var _inputState:InputState;
		private var _previousInputState:InputState;
		
		public function Game()
		{
			_screens = new Array();
			_inputState = new InputState();
			_previousInputState = new InputState();
			if (stage != null)
			{
				prepare();
			}
			else
			{
				trace("KeepInTouchEngine: WARNING! Cannot prepare input, make sure to call prepare() after game is added to stage.");
			}
		
		}
		
		public function prepare():void
		{
			trace("KeepInTouchEngine: Preparing input state...");
			_inputState.clear();
			_previousInputState.clear();
			
			trace("KeepInTouchEngine: Adding event handlers...");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, doKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, doKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, doMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, doMouseUp);
			addEventListener(Event.ENTER_FRAME, doFrame);
			
			trace("KeepInTouchEngine: Adding mask...");
			//_mask = new Sprite();
			//_mask.graphics.clear();
			//_mask.graphics.beginFill(0x000000);
			//_mask.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			//_mask.graphics.endFill();
			//addChild(_mask);
			//mask = _mask;
			
			trace("KeepInTouchEngine: Preparations complete!");
		}
		
		public function get activeScreen():GameScreen
		{
			if (_screens.length > 0)
				return _screens[_screens.length - 1];
			else
				return null;
		}
		
		public function get inputState():InputState
		{
			return _inputState;
		}
		
		public function get screens():Array 
		{
			return _screens;
		}
		
		public function closeActiveScreen():void
		{
			if (activeScreen != null)
			{
				trace("KeepInTouchEngine: Closing active screen...");
				deactivateScreen();
				if (activeScreen.parent != null)
					activeScreen.parent.removeChild(activeScreen);
				_screens.splice(_screens.length - 1, 1);
				activateScreen();
			}
			else
			{
				trace("KeepInTouchEngine: WARNING! Attemping to close screen when there were no screens!");
			}
		}
		
		private function deactivateScreen():void
		{
			if (activeScreen != null)
			{
				trace("KeepInTouchEngine: Deactivating screen", activeScreen);
				activeScreen.active = false;
				activeScreen.dispatchEvent(new Event(GameScreen.DEACTIVATE));
			}
			else
			{
				trace("KeepInTouchEngine: WARNING! Attemping to deactivate screen when there were no screens!");
			}
		}
		
		private function activateScreen():void
		{
			if (activeScreen != null)
			{
				trace("KeepInTouchEngine: Activating screen", activeScreen);
				activeScreen.active = true;
				activeScreen.game = this;
				activeScreen.dispatchEvent(new Event(GameScreen.ACTIVATE));
				
				var index:int = numChildren - 1;
				
				if (activeScreen.parent == null)
				{
					addChildAt(activeScreen, index + 1);
				}
				else if (activeScreen.parent == this)
				{
					setChildIndex(activeScreen, index);
				}
				else
				{
					activeScreen.parent.removeChild(activeScreen);
					addChildAt(activeScreen, index + 1);
				}
			}
			else
			{
				trace("KeepInTouchEngine: WARNING! Attemping to deactivate screen when there were no screens!");
			}
		}
		
		public function removeScreen(screen:GameScreen):void
		{
			trace("KeepInTouchEngine: Removing screen", screen);
			if (screen == activeScreen)
			{
				closeActiveScreen();
			}
			else
			{
				var l:int = _screens.length;
				for (var i:int = 0; i < l; i++)
				{
					if (_screens[i] == screen)
					{
						_screens.splice(i, 1);
						break;
					}
				}
				if (screen != null)
					screen.parent.removeChild(activeScreen);
			}
		}
		
		public function addScreen(screen:GameScreen):void
		{
			trace("KeepInTouchEngine: Adding screen", screen);
			if (_screens.length > 0)
				deactivateScreen();
			
			_screens.push(screen);
			trace("KeepInTouchEngine: Number of active screens:", _screens.length);
			activateScreen();
		}
		
		private function doKeyDown(e:KeyboardEvent = null):void
		{
			switch (e.keyCode)
			{
				case Keyboard.UP: 
					_inputState.up = true;
					break;
				case Keyboard.DOWN: 
					_inputState.down = true;
					break;
				case Keyboard.LEFT: 
					_inputState.left = true;
					break;
				case Keyboard.RIGHT: 
					_inputState.right = true;
					break;
				case Keyboard.SPACE: 
					_inputState.space = true;
					break;
				case Keyboard.CONTROL: 
					_inputState.control = true;
					break;
				case Keyboard.ENTER: 
					_inputState.enter = true;
					break;
				case Keyboard.ESCAPE: 
					_inputState.escape = true;
					break;
				case Keyboard.SHIFT: 
					_inputState.shift = true;
					break;
			}
		}
		
		private function doKeyUp(e:KeyboardEvent = null):void
		{
			switch (e.keyCode)
			{
				case Keyboard.UP: 
					_inputState.up = false;
					break;
				case Keyboard.DOWN: 
					_inputState.down = false;
					break;
				case Keyboard.LEFT: 
					_inputState.left = false;
					break;
				case Keyboard.RIGHT: 
					_inputState.right = false;
					break;
				case Keyboard.SPACE: 
					_inputState.space = false;
					break;
				case Keyboard.CONTROL: 
					_inputState.control = false;
					break;
				case Keyboard.ENTER: 
					_inputState.enter = false;
					break;
				case Keyboard.ESCAPE: 
					_inputState.escape = false;
					break;
				case Keyboard.SHIFT: 
					_inputState.shift = false;
					break;
			}
		
		}
		
		private function doMouseDown(e:MouseEvent = null):void
		{
			_inputState.mouseButton = true;
		}
		
		private function doMouseUp(e:MouseEvent = null):void
		{
			_inputState.mouseButton = false;
		}
		
		protected final function doFrame(e:Event = null):void
		{
			if (activeScreen != null)
			{
				activeScreen.doFrame(_inputState, _previousInputState);
			}
			_previousInputState.copy(_inputState);
		}
	
	}
}