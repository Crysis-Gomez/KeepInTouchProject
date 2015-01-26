package screen
{
	import core.world.GameWorld;
	import events.core.EventManager;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.utils.Timer;
	import objects.PlayerArea;
	
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class PlayScreen extends GameWorld
	{
		private var _playerAreas:Array;
		private var started:Boolean;
		private var startText1:TextField;
		private var startText2:TextField;
		
		public function PlayScreen(totalplayers:int,speed:String)
		{
			super();
			initiate(1920, 1080);
			placeStartText();
			drawBackGround();
			
			loadPlayerAreas(totalplayers);
			
			//addChild(new Stats());
			EventManager.getInstance().playScreen = this;
			EventManager.getInstance().speed = speed;
		
		}
		
		private function placeStartText():void 
		{
			startText1 = Util.createTextfield("Get ready, place your token on an area", 1920, 100, 72, 0xFFFFFF);
			startText2 = Util.createTextfield("Get ready, place your token on an area", 1920, 100, 72, 0xFFFFFF);
			
			startText1 = Util.multiColorText(startText1);
			startText2 = Util.multiColorText(startText2);
			
			startText2.rotation = 180;
			
			startText2.x = 1920;
			
			startText1.y = 1080 / 2 + 300;
			startText2.y = 1080 / 2 - 300;
			
			addChild(startText1);
			addChild(startText2);
			
		}
	
		override public function initiate(screenWidth:int, screenHeight:int):void 
		{
			super.initiate(screenWidth, screenHeight);
		}
		
		private function drawBackGround():void
		{
			graphics.beginFill(0x0);
			graphics.drawRect(0, 0, 1920, 1080);
			graphics.endFill();
		}
		
		private function loadPlayerAreas(amountOfPlayers:int):void
		{
			_playerAreas = new Array();
			
			for (var i:int = 0; i < amountOfPlayers; ++i)
			{
				var playerArea:PlayerArea = new PlayerArea(this, i, getPosition(i, amountOfPlayers));
				playerAreas.push(playerArea);
				//playerArea.scoreCounter = 2 * i;
			}
		}
		
		
		public function checkWinningCondition():void 
		{
			for (var i:int = 0; i < _playerAreas.length; ++i)
			{
				var playerArea:PlayerArea = _playerAreas[i];
				if (playerArea.scoreCounter >= AppData.maxScore) {
					selectedWinners();
				}
			}
		}
		
		override public function update():void
		{
			var aPlayerArea:PlayerArea;
			super.update();
			if (!started) {
				
				/*for each(var aPlayerArea:PlayerArea in _playerAreas) {
					if (!aPlayerArea.previousHasTouchPoint && !aPlayerArea.hasTouchPoint) {
						return;
					}
				}*/
				started = true;
				if (this.contains(startText1)) removeChild(startText1);
				if (this.contains(startText2)) removeChild(startText2);
				EventManager.getInstance().playEvent();
			}
			checkWinningCondition();
			_playerAreas.sortOn(["scoreCounter"], [Array.NUMERIC]);
			
			var highlightScore:int =_playerAreas[_playerAreas.length-1].scoreCounter;
			if (highlightScore > 0) {
				for each(aPlayerArea in _playerAreas) {
					if (aPlayerArea.scoreCounter == highlightScore) {
						aPlayerArea.higlight = true;
				}
				}
			}
			
			//trace("----check collisions----")
			//for (var i:int = 0; i < _playerAreas.length; i++)
			//{
				//for (var j:int = i + 1; j < _playerAreas.length; j++)
				//{
					//if (i == j)
						//continue;
					//trace(i, j);
					//
					//var area1:PlayerArea = _playerAreas[i];
					//var area2:PlayerArea = _playerAreas[j];
					//
					//var dist:Vector3D = new Vector3D(area2.x - area1.x, area2.y - area1.y);
					//
					//if (dist.length < Math.sqrt((area1.size + area2.size) * (area1.size + area2.size)))
					//{
						//resolveCollision(area1, area2);
					//}
				//}
			//}
			//trace("------------------------");
		}
		
		private function resolveCollision(ball1:PlayerArea, ball2:PlayerArea):void
		{
			//var b1Position:Vector3D = new Vector3D(ball1.x, ball1.y);
			//var b2Position:Vector3D = new Vector3D(ball2.x, ball2.y);
			//
			//var p:Vector3D = ball1.direction.subtract(ball2.direction);
			//var n:Vector3D = b1Position.subtract(b2Position);
			//n.normalize();
			//var time:Number = p.dotProduct(n);
			//
			//n.scaleBy(time);
			//var newVector:Vector3D = n.clone();
			//
			//var perp:Vector3D = ball1.direction.subtract(newVector);
			//ball1.direction = perp;
			//ball2.direction = ball2.direction.add(newVector);
			//
			//ball1.direction.scaleBy((Math.random()+1));
			//ball2.direction.scaleBy((Math.random()+1));
			//
			//ball1.collisionCoolDown = 10 + Math.floor(Math.random() * 10);
			//ball2.collisionCoolDown = 10 + Math.floor(Math.random() * 10);
		}
		
		private function getPosition(playerID:int, amountOfPlayers:int):Point
		{
			if (amountOfPlayers == 4)
			{
				switch (playerID)
				{
					case 0: 
						return new Point(50, 50);
						break;
					case 1: 
						return new Point(1920 - 50, 50);
						break;
					case 2: 
						return new Point(1920 - 50, 1080 - 50);
						break;
					case 3: 
						return new Point(50, 1080 - 50);
						break;
				}
			}
			else if (amountOfPlayers == 6)
			{
				switch (playerID)
				{
					case 0: 
						return new Point(50, 50);
						break;
					case 1: 
						return new Point(1920 / 2, 0);
						break;
					case 2: 
						return new Point(1920 - 50, 50);
						break;
					case 3: 
						return new Point(1920 - 50, 1080 - 50);
						break;
					case 4: 
						return new Point(1920 / 2, 1080);
						break;
					case 5: 
						
						return new Point(50, 1080 - 50);
						break;
				}
			}
			return null;
		}
		
		
		public function selectedWinners():void 
		{
			
			close();
			game.addScreen(new WinningScreen(getMaxValue(),getMaxValue(), getMaxValue()));
		}
		
		public function getMaxValue():PlayerArea
		{
			var max:int = -1;
			var index:int = 0;
			for (var i:int = 0; i < _playerAreas.length; i++) 
			{
				var player:PlayerArea = _playerAreas[i];
				if (player.scoreCounter > max) {
					max = player.scoreCounter;
					index = i;
				}
			}
			
			 var player2:PlayerArea = _playerAreas[index];
			_playerAreas.splice(index, 1);
			//var count:int = player2.playerID;
			return  player2;
		}
		
		override protected function keySpacePressed():void
		{
			super.keySpacePressed();
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public function get playerAreas():Array
		{
			return _playerAreas;
		}
	
	}

}