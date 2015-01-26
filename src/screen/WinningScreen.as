package screen 
{
	import core.GameScreen;
	import flash.desktop.NativeApplication;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.engine.BreakOpportunity;
	import flash.text.TextField;
	import objects.PlayerArea;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class WinningScreen extends GameScreen 
	{
		private var start:Sprite;
		private var start2:Sprite;
		private var quit:Sprite;
		private	var quit2:Sprite;
		private var first:TextField;
		private var second:TextField;
		private var third:TextField;
		private var first2:TextField;
		private var second2:TextField;
		private var third2:TextField;
		private var score:Shape;
		private var size:Number = 150;
		private var offset:Number	= 25;
		
		
		public function WinningScreen(player1:PlayerArea, player2:PlayerArea, player3:PlayerArea) 
		{
			super();
			
			first = Util.createTextfield("Winner", 300, 100, 50, AppData.PLAYERCOLORS[player1.playerID]);
			second = Util.createTextfield("Second", 300, 100, 50, AppData.PLAYERCOLORS[player2.playerID]);
			third = Util.createTextfield("Third", 300, 100, 50, AppData.PLAYERCOLORS[player3.playerID]);
			first2 = Util.createTextfield("Winner", 300, 100, 50, AppData.PLAYERCOLORS[player1.playerID]);
			second2 = Util.createTextfield("Second", 300, 100, 50, AppData.PLAYERCOLORS[player2.playerID]);
			third2 = Util.createTextfield("Third", 300, 100, 50, AppData.PLAYERCOLORS[player3.playerID]);
			
			first.x = 1920 / 2 - first.width*0.5;
			first.y = 1080 / 2+250;
			addChild(first);
			
			score = new Shape();
			addChild(score);
			
			second.x = 1920 / 2 - second.width*0.5 - 700;
			second.y = 1080 / 2+250;
			addChild(second);
			
			third.x = 1920 / 2 - third.width*0.5 + 700;
			third.y = 1080 / 2+250;
			addChild(third);

			first2.x = 1920 / 2 + first2.width*0.5;
			first2.y = 1080 / 2-250;
			addChild(first2);
			first2.rotation = 180;
			
			second2.x = 1920 / 2 + second2.width*0.5 - 700;
			second2.y = 1080 / 2-250;
			addChild(second2);
			second2.rotation = 180;
			
			third2.x = 1920 / 2 + third2.width*0.5 + 700;
			third2.y = 1080 / 2-250;
			addChild(third2);
			third2.rotation = 180;
					
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 1920, 1080);
			graphics.endFill();
			
			
			score.graphics.clear();

			for (var i:int = 0; i < player1.scoreCounter; ++i) {
				score.graphics.beginFill(AppData.PLAYERCOLORS[player1.playerID], 1 - (i*0.05));
				score.graphics.drawCircle(1920 / 2, 1080 / 2, size + offset + (i-1) * 5);
				score.graphics.drawCircle(1920 / 2, 1080 / 2, size + offset + i * 5  );
				score.graphics.endFill();
			}
			
			for (var l:int = 0; l < player2.scoreCounter; ++l) {
				score.graphics.beginFill(AppData.PLAYERCOLORS[player2.playerID], 1 - (l*0.05));
				score.graphics.drawCircle(1920 / 2 - 700, 1080 / 2, size + offset + (l-1) * 5);
				score.graphics.drawCircle(1920 / 2 - 700, 1080 / 2, size + offset + l * 5  );
				score.graphics.endFill();
			}
			
			for (var z:int = 0; z < player3.scoreCounter; ++z) {
				score.graphics.beginFill(AppData.PLAYERCOLORS[player3.playerID], 1 - (z*0.05));
				score.graphics.drawCircle(1920 / 2 +700, 1080 / 2, size + offset + (z-1) * 5);
				score.graphics.drawCircle(1920 / 2 +700, 1080 / 2, size + offset + z * 5  );
				score.graphics.endFill();
			}
			
			
			graphics.beginFill(AppData.PLAYERCOLORS[player1.playerID]);
			graphics.drawCircle(1920 / 2, 1080 / 2, 160);
			graphics.endFill();
			
			graphics.beginFill(AppData.PLAYERCOLORS[player2.playerID]);
			graphics.drawCircle(1920 / 2 - 700, 1080 / 2, 140);
			graphics.endFill();
			
			graphics.beginFill(AppData.PLAYERCOLORS[player3.playerID]);
			graphics.drawCircle(1920 / 2 +700, 1080 / 2, 110);
			graphics.endFill();
			
			start = Util.createButton("New game", 400, 80, 0xFFFFFF);
			addChild(start);
			
			quit = Util.createButton("Quit game", 400, 80, 0xFFFFFF);
			addChild(quit);
			quit.addEventListener(AppData.CLICKEVENTTYPE, onQuit);
			quit.x = 1920 / 2 + 300;
			quit.y = 1080 - 100;
			
			
			quit2 = Util.createButton("Quit game", 400, 80, 0xFFFFFF);
			addChild(quit2);
			quit2.addEventListener(AppData.CLICKEVENTTYPE, onQuit);
			quit2.x = 1920 / 2 - 300;
			quit2.y = 0 + 100;
			quit2.rotation = 180;
			
			start.x = 1920 / 2-300;
			start.y = 1080 - 100;
			start.addEventListener(AppData.CLICKEVENTTYPE, onStart);
			start2 = Util.createButton("New game", 400, 80, 0xFFFFFF);
			addChild(start2);
			start2.x = 1920 / 2+300;
			start2.y = 0 + 100;
			start2.rotation = 180;
			start2.addEventListener(AppData.CLICKEVENTTYPE, onStart);
			
		}
		
		private function onQuit(e:Event):void 
		{
			 NativeApplication.nativeApplication.exit();
		}
		
		private function onStart(e:Event):void 
		{
			close();
			game.addScreen(new StartScreen());
		}
		

	}

}