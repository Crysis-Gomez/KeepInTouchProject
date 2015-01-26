package events.core 
{
	import core.world.GameWorld;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	public class GameEventAnnouncement extends Sprite
	{
		private var eventType:int;
		private var playScreen:GameWorld;
		private var _play:Function;
		private var timerGraphics:GameEventTimer;
		private var speed:int = 1000;
		
		public function GameEventAnnouncement(eventType:int, playScreen:GameWorld, play:Function) 
		{
			this._play = play;
			this.playScreen = playScreen;
			this.eventType = eventType;
			x = 1920 / 2
			y = 1080 / 2;
		}
		
		public function start():void 
		{
			var timer:Timer;
			draw();
			if (AppData.gameSpeed == "slow") {
				timer = new Timer(speed/60, 60*4);
			} else {
				timer = new Timer(speed/60, 60*2);
			}
			
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, updateTimer);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		public function draw():void 
		{
			timerGraphics = new GameEventTimer();
			addChild(timerGraphics);
			playScreen.addChild(this);
		}
		
		public function updateTimer(e:TimerEvent):void 
		{
			timerGraphics.update(((e.target as Timer).currentCount / (e.target as Timer).repeatCount) * 100);
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			playScreen.removeChild(this);
			_play();
		}
		
	}

}