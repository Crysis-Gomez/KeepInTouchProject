package core.menu 
{
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameMenuItem extends Sprite
	{
		public var itemBackgroundColor:uint = 0x000000;
		public var itemTextColor:uint = 0xeeeeee;
		public var itemSelectedBackgroundColor:uint = 0xffffff;
		public var itemSelectedTextColor:uint = 0x000000;
		public var itemWidth:int = 300;
		public var itemHeight:int = 50;
	
		public var gameMenu:GameMenu;
		
		public var textField:TextField;
		
		private var _selected:Boolean = false;
		
		public var action:Function;
		public var itemIndex:int = -1;
		
		public function GameMenuItem(text:String, action:Function) 
		{
			this.action = action;
			textField = new TextField();
			textField.width = itemWidth-10;
			textField.height = itemHeight-10;
			textField.defaultTextFormat = new TextFormat("Arial", 20, itemTextColor);
			textField.multiline = false;
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.text = text;
			textField.x = (itemWidth - textField.textWidth) * 0.5;
			textField.y = (itemHeight - textField.textHeight) * 0.5;
			textField.width = textField.textWidth+10;
			textField.height = textField.textHeight+10;
			addChild(textField);
			mouseChildren = false;
			draw();
		}
		
		
		public function destroy():void 
		{
			gameMenu.removeChild(this);
		}
		
		public function draw():void {
			graphics.clear();
			if (selected) {
				textField.textColor = itemSelectedTextColor;
				graphics.beginFill(itemSelectedBackgroundColor);
			} else {
				textField.textColor = itemTextColor;
				graphics.beginFill(itemBackgroundColor);
			}
			graphics.drawRect(0, 0, itemWidth, itemHeight);
			graphics.endFill();
			
		}
		
		public function setInputMode(inputMode:String):void {
			if (inputMode == GameMenu.INPUT_BOTH || inputMode == GameMenu.INPUT_MOUSE) {
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				addEventListener(MouseEvent.CLICK, onClick);
				buttonMode = true;
			} else {
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				removeEventListener(MouseEvent.CLICK, onClick);
				buttonMode = false;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			gameMenu.selectedItem = this;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			gameMenu.selectedItem = null;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (action != null) action();
		}
		
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			draw();
		}
		
		
		
	}

}