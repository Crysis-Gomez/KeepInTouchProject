package objects
{
	import core.InputState;
	import core.IUpdateable;
	import core.world.objects.GameObject;
	import events.core.GameEvent;
	import events.move.MoveEvent;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class PlayerArea extends GameObject implements IUpdateable
	{
		public var eventDone:Boolean;
		public var playerID:int;
		public var higlight:Boolean;
		public var direction:Vector3D;
		public var moveSpeed:int = 4;
		public var collisionCoolDown:Number;
		public var eventPassed:Boolean;
		private var _eventFailed:Boolean;
		private var increasePulse:Boolean;
		private var touchPoint:Vector3D;
		private var _size:Number = 150;
		private var offset:Number	= 25;
		private var maxOffset:Number = 25;
		private var minOffset:Number = 0;
		private var pulseDecreaseSpeed:Number = 0.5;
		private var pulseIncreaseSpeed:Number = 0.5;
		private var _hasTouchPoint:Boolean;
		
		
		
		private var _event:GameEvent;
		private var _eventPropertie:*;
		private var _previousHasTouchPoint:Boolean;
		private var score:Shape;
		private var checkeredPattern:BitmapData;
		public var scoreCounter:int = 0;
		
		
			
		public function PlayerArea(playScreen:PlayScreen, playerID:int, position:Point)
		{
			this.playerID = playerID;
			checkeredPattern = Util.generateCheckeredPattern();
			
			score = new Shape();
			score.x = x;
			score.y = y;
			initiate(playScreen, position.x, position.y);
			_gameWorld.addChild(score);
			createListeners();
			
			draw();
			if (AppData.gameSpeed == "slow") {
				moveSpeed = 4;
			} else {
				moveSpeed = 8;
			}
		}
		
		private function createListeners():void
		{
			this.addEventListener(TouchEvent.TOUCH_MOVE, onMove, false, 1, true);
			this.addEventListener(TouchEvent.TOUCH_OUT, onOut, false, 0, true);
			this.addEventListener(TouchEvent.TOUCH_OVER, onOver, false, 0, true);
		}
		
		private function onOver(e:TouchEvent):void
		{
			if (touchPoint == null)
			{
				touchPoint = new Vector3D(e.localX, e.localY, e.touchPointID);
				_hasTouchPoint = true;
			}
		
		}
		
		private function onOut(e:TouchEvent):void
		{
			if (touchPoint != null)
			{
				if (touchPoint.z == e.touchPointID)
				{
					touchPoint = null;
					_hasTouchPoint = false;
				}
				
			}
		}
		
		private function onMove(e:TouchEvent):void
		{
			if (touchPoint != null)
			{
				if (touchPoint.z == e.touchPointID)
				{
					touchPoint.x = e.localX;
					touchPoint.y = e.localY;
				}
			}
			else
			{
				touchPoint = new Vector3D(e.localX, e.localY, e.touchPointID);
				_hasTouchPoint = true;
			}
		}
		
		override public function draw():void
		{
			super.draw();
			
			graphics.clear();
			if (higlight) graphics.lineStyle(4,0xFFFFFF);
			graphics.beginFill(AppData.PLAYERCOLORS[playerID], 1);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
			
			graphics.lineStyle(3, 0x000000);
			if (eventFailed) {
				graphics.beginFill(0xFF0000);
			} else if ( eventPassed) {
				graphics.beginFill(0x00FF00);
			} else {
				graphics.beginFill(0xFFFFFF);
			}
			graphics.drawCircle(0, 0, 70);
			graphics.drawCircle(0, 0, 80);
			graphics.endFill();
			graphics.lineStyle(); 
			if (scoreCounter + 1 == AppData.maxScore) { 
				graphics.beginBitmapFill(checkeredPattern);
				graphics.drawCircle(0, 0, 70);
				graphics.endFill();
			}
			
			score.x = x;
			score.y = y;
			
			score.graphics.clear();
			for (var i:int = 0; i < scoreCounter; ++i) {
				score.graphics.beginFill(AppData.PLAYERCOLORS[playerID], 1 - (i*0.05));
				score.graphics.drawCircle(0, 0, size + offset + (i-1) * 5);
				score.graphics.drawCircle(0, 0, size + offset + i * 5  );
				score.graphics.endFill();
			}
			
			
			
			//
			//graphics.beginFill(AppData.PLAYERCOLORS[playerID], 0.6);
			//graphics.drawCircle(0, 0, size + offset+10);
			//graphics.drawCircle(0, 0, size + offset + 20);
			//graphics.endFill();
			//
			//graphics.beginFill(AppData.PLAYERCOLORS[playerID], 0.4);
			//graphics.drawCircle(0, 0, size + offset+20);
			//graphics.drawCircle(0, 0, size + offset + 30);
			//graphics.endFill();
			
			if (hasTouchPoint) {
				graphics.lineStyle(2, 0xFFFFFF);
				graphics.drawCircle(touchPoint.x, touchPoint.y, 25);
			}
			
		}
		
		/* INTERFACE core.IUpdateable */
		
		public function update():void
		{
			if (scoreCounter < 0)
				scoreCounter = 0;
			doPulsing();
			draw();
			higlight = false;
			
			if (event != null) {
				event.update(this);
			}
			_previousHasTouchPoint = _hasTouchPoint;
		}
		
		public function setEvent(event:GameEvent, eventPropertie:*):void 
		{
			this._eventPropertie = eventPropertie;
			this._event = event;
			
		}
		
		public function removeEvent():void 
		{
			_event = null;
			_eventPropertie = null;
			eventDone = false;
			eventFailed = false;
			eventPassed = false;
		}
		
		private function doPulsing():void 
		{
			if (increasePulse) {
				offset += pulseIncreaseSpeed;
			} else {
				offset -= pulseDecreaseSpeed;
			}
			
			if (offset >= maxOffset) {
				increasePulse = false;
			} else if (offset <= minOffset) {
				increasePulse = true;
			}
		}
		
		public function get event():GameEvent 
		{
			return _event;
		}
		
		public function get eventPropertie():* 
		{
			return _eventPropertie;
		}
		
		public function get hasTouchPoint():Boolean 
		{
			return _hasTouchPoint;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function get previousHasTouchPoint():Boolean 
		{
			return _previousHasTouchPoint;
		}
		
		public function get eventFailed():Boolean 
		{
			return _eventFailed;
		}
		
		public function set eventFailed(value:Boolean):void 
		{
			_eventFailed = value;
		}
	}
}