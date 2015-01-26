package screen
{
	import core.Game;
	import core.GameScreen;
	import core.menu.GameMenu;
	import core.menu.GameMenuItem;
	import core.world.GameWorld;
	import events.core.GameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class StartScreen extends GameWorld
	{
		private var startButton:Sprite;
		private var eventsToPickFrom:Array = [GameEvent.RELEASE_EVENT, GameEvent.HOLD_EVENT, GameEvent.MOVE_EVENT];
		
		public function StartScreen()
		{
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 1920, 1080);
			graphics.endFill();
			
			startButton = new Sprite();
			startButton.graphics.beginFill(0xFFFFFF);
			startButton.graphics.drawCircle(0, 0, 150)
			startButton.graphics.drawCircle(0, 0, 140);
			startButton.graphics.endFill();
			
			startButton.graphics.beginFill(0x000000);
			startButton.graphics.drawCircle(0, 0, 140);
			startButton.graphics.endFill();
			
			startButton.x = 1920 / 2;
			startButton.y = 1080 / 2;
			
			startButton.addEventListener(AppData.CLICKEVENTTYPE, onTouch);
			
			addChild(startButton);
			
			var start1:TextField = Util.createTextfield("START", 200, 100, 64, 0xFFFFFF);
			start1.x = -100;
			start1.y = 10;
			
			var start2:TextField = Util.createTextfield("START", 200, 100, 64, 0xFFFFFF);
			start2.rotation = 180;
			start2.x = 100;
			start2.y = -10
			
			var keepintouch1:TextField = Util.createTextfield("KEEP IN TOUCH", 800, 100, 90, 0xFFFFFF);
			keepintouch1.x = -400;
			keepintouch1.y = 250;
			
			var keepintouch2:TextField = Util.createTextfield("KEEP IN TOUCH", 800, 100, 90, 0xFFFFFF);
			keepintouch2.rotation = 180;
			keepintouch2.x = 400;
			keepintouch2.y = -250
			
			keepintouch1 = Util.multiColorText(keepintouch1);
			keepintouch2 = Util.multiColorText(keepintouch2);
			
			startButton.addChild(start1);
			startButton.addChild(start2);
			
			startButton.addChild(keepintouch1);
			startButton.addChild(keepintouch2);
			
			
		}
		
		private function onTouch(e:Event):void 
		{
			this.close();
			game.addScreen(new PlayerScreen());
			
		}
		
		override public function update():void 
		{
			super.update();
			var eventType:int = eventsToPickFrom[Math.round(Math.random() * (eventsToPickFrom.length - 1))];
			trace(eventType);
			//startButton.rotation += 0.2;
		}
	}

}