package core.menu 
{
	import core.GameScreen;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameMenu extends GameScreen
	{
		private var _menuItems:Array;
		private var _selectedItem:GameMenuItem;
		
		public var inputMode:String;
		
		public static const INPUT_BOTH:String = "both";
		public static const INPUT_KEYBOARD:String = "keyboard";
		public static const INPUT_MOUSE:String = "mouse";
		
		public var menuX:int;
		public var menuY:int;
		
		public var menuSpaceX:int;
		public var menuSpaceY:int;
		
		protected var title:TextField;
		
		public function GameMenu() 
		{
			//drawBackGround();
			menuX = 250;
			menuY = 100;
			menuSpaceX = 10;
			menuSpaceY = 10;
			_menuItems = new Array();
			inputMode = INPUT_BOTH;
			title = new TextField();
			title.multiline = false;
			title.selectable = false;
			title.mouseEnabled = false;
			title.defaultTextFormat = new TextFormat("Arial", 40, 0xffff00, true);
			title.width = 800;
			title.height = 80;
			addChild(title);
			
		}
		
		private function drawBackGround():void
		{
			graphics.beginFill(0x00000,0);
			graphics.drawRect(0, 0, 1920, 1080);
			graphics.endFill();
		}
		
		public function addGameMenuItem(gameMenuItem:GameMenuItem):void {
			gameMenuItem.gameMenu = this;
			_menuItems.push(gameMenuItem);
			gameMenuItem.x = menuX;
			gameMenuItem.y = menuY;
			menuY += gameMenuItem.itemHeight + menuSpaceY;
			addChild(gameMenuItem);
			gameMenuItem.setInputMode(inputMode);
			gameMenuItem.itemIndex = _menuItems.length - 1;
			if (inputMode == INPUT_BOTH || inputMode == INPUT_KEYBOARD && _menuItems.length==1) {
				selectedItem = _menuItems[0];
			}
			gameMenuItem.draw();
		}
		
		override protected function keyEnterPressed():void 
		{
			if (inputMode == INPUT_BOTH || inputMode == INPUT_KEYBOARD) {
				if (selectedItem != null && selectedItem.action != null) selectedItem.action();
			}
		}
		
		override protected function keySpacePressed():void 
		{
			if (inputMode == INPUT_BOTH || inputMode == INPUT_KEYBOARD) {
				if (selectedItem != null && selectedItem.action != null) selectedItem.action();
			}
		}
		
		override protected function keyDownPressed():void 
		{
			if (_menuItems.length == 0) return;
			if (inputMode == INPUT_BOTH || inputMode == INPUT_KEYBOARD) {
				if (_selectedItem == null) {
					selectedItem = _menuItems[0];
				} else {
					if (selectedItem.itemIndex < _menuItems.length - 1) {
						selectedItem = _menuItems[selectedItem.itemIndex + 1];
					} else {
						selectedItem = _menuItems[0];
					}
				}
				
			}
		}
		
		override protected function keyUpPressed():void 
		{
			if (_menuItems.length == 0) return;
			if (inputMode == INPUT_BOTH || inputMode == INPUT_KEYBOARD) {
				if (_selectedItem == null) {
					selectedItem = _menuItems[_menuItems.length-1];
				} else {
					if (selectedItem.itemIndex > 0) {
						selectedItem = _menuItems[selectedItem.itemIndex - 1];
					} else {
						selectedItem = _menuItems[_menuItems.length-1];
					}
				}
				
			}
		}
		
		public function get selectedItem():GameMenuItem { return _selectedItem; }
		
		public function set selectedItem(value:GameMenuItem):void 
		{
			if (_selectedItem != null) _selectedItem.selected = false;
			_selectedItem = value;
			if (_selectedItem != null) _selectedItem.selected = true;
		}
		
	}

}