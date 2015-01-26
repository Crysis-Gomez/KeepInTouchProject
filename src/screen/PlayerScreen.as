package screen
{
	import core.GameScreen;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author
	 */
	public class PlayerScreen extends GameScreen
	{
		private var startButton:Sprite;
		private var backButton:Sprite;
		private var backButton2:Sprite;
		private var glowFilter:GlowFilter;
		
		public function PlayerScreen()
		{
			AppData.amountOfPlayer = 4;
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 1920, 1080);
			graphics.endFill();
			
			glowFilter = new GlowFilter(0xFF8000,0.6, 20, 20);
			
			var playerText1:TextField = Util.createTextfield("Select amount of players",1920, 100, 72, 0xFFFFFF);
			playerText1.x = 0;
			playerText1.y = (1080 / 2) + 300;
			
			playerText1 = Util.multiColorText(playerText1);
			addChild(playerText1);
			
			var playerText2:TextField = Util.createTextfield("Select amount of players", 1920, 100, 72, 0xFFFFFF);
			playerText2.x = 1920;
			playerText2.y = (1080 / 2) -300;
			playerText2.rotation = 180;
			
			playerText2 = Util.multiColorText(playerText2);
			addChild(playerText2);
			
			var button4Player1:Sprite = Util.createButton("4", 100, 100, 0xFF8000);
			var button4Player2:Sprite = Util.createButton("4", 100, 100, 0xFF8000);
			
			var button6Player1:Sprite = Util.createButton("6", 100, 100, 0x400080);
			var button6Player2:Sprite = Util.createButton("6", 100, 100, 0x400080);
			
			button4Player1.x = 200
			button4Player1.y = 1080 / 2;
			addChild(button4Player1);
			
			button6Player1.x = 400
			button6Player1.y = 1080 / 2;
			addChild(button6Player1);
			
			button4Player2.x = 1920 - 200;
			button4Player2.y = 1080 / 2;
			button4Player2.rotation = 180;
			addChild(button4Player2);
			
			button6Player2.x = 1920 - 400
			button6Player2.y = 1080 / 2;
			button6Player2.rotation = 180;
			addChild(button6Player2);
			
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
			
			
			backButton = Util.createButton("Back", 150, 60, 0xFFFFFF);
			
			backButton.x = 1920 - 90;
			backButton.y = 1080 - 60;
			
			
			backButton2 = Util.createButton("Back", 150, 60, 0xFFFFFF);
			backButton2.x = 90;
			backButton2.y = 60;
			backButton2.rotation = 180;
			
			
			startButton.addEventListener(AppData.CLICKEVENTTYPE, onTouch, false, 0, true);
			backButton.addEventListener(AppData.CLICKEVENTTYPE, onBack, false, 0, true);
			backButton2.addEventListener(AppData.CLICKEVENTTYPE, onBack, false, 0, true);
			
			addChild(startButton);
			addChild(backButton);
			addChild(backButton2);

			var start1:TextField = Util.createTextfield("Select", 200, 100, 64, 0xFFFFFF);
			start1.x = -100;
			start1.y = 10;
			
			var start2:TextField = Util.createTextfield("Select", 200, 100, 64, 0xFFFFFF);
			start2.rotation = 180;
			start2.x = 100;
			start2.y = -10
			
			startButton.addChild(start1);
			startButton.addChild(start2);
			
			button4Player1.filters = [glowFilter];
			button4Player2.filters = [glowFilter];
			
			button4Player1.addEventListener(AppData.CLICKEVENTTYPE, function():void
				{
					glowFilter = new GlowFilter(0xFF8000,0.6, 20, 20);
					button4Player1.filters = [glowFilter];
					button4Player2.filters = [glowFilter];
					button6Player1.filters = null;
					button6Player2.filters = null;
					
					AppData.amountOfPlayer = 4;
				}, false, 0, true);
			button4Player2.addEventListener(AppData.CLICKEVENTTYPE, function():void
				{
					glowFilter = new GlowFilter(0xFF8000,0.6, 20, 20);
					button4Player1.filters = [glowFilter];
					button4Player2.filters = [glowFilter];
					button6Player1.filters = null;
					button6Player2.filters = null;
					
					AppData.amountOfPlayer = 4;
				}, false, 0, true);
			button6Player1.addEventListener(AppData.CLICKEVENTTYPE, function():void
				{
					glowFilter = new GlowFilter(0x400080,0.6, 20, 20);
					button6Player1.filters = [glowFilter];
					button6Player2.filters = [glowFilter];
					button4Player1.filters = null;
					button4Player2.filters = null;
					AppData.amountOfPlayer = 6;
					
				}, false, 0, true);
			button6Player2.addEventListener(AppData.CLICKEVENTTYPE, function():void
				{
					glowFilter = new GlowFilter(0x400080,0.6, 20, 20);
					button6Player1.filters = [glowFilter];
					button6Player2.filters = [glowFilter];
					button4Player1.filters = null;
					button4Player2.filters = null;
					AppData.amountOfPlayer = 6;
				}, false, 0, true);
		
		}
		
		private function onBack(e:Event):void 
		{
			
			this.close();
			game.addScreen(new StartScreen());
		}
		
		private function onTouch(e:Event):void
		{
			//TODO: Next screen;
			
			this.close();
			game.addScreen(new SpeedScreen());
		
			
		}
	
	}

}