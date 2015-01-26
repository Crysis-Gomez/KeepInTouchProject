package core.world 
{
	import core.GameScreen;
	import core.InputState;
	import core.IUpdateable;
	import core.world.objects.GameObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameWorld extends GameScreen
	{
		public var _gameObjects:Array;

		private var _screenWidth:int;
		private var _screenHeight:int;
		

		
		public var paused:Boolean;
		private var _initiated:Boolean;
		private var _activated:Boolean;
		
		public function GameWorld() 
		{
			_initiated = false;
			paused = false;
			_gameObjects = new Array();
		}
		
		public function initiate(screenWidth:int, screenHeight:int):void {
			if (_initiated) return;
			_initiated = true;
			
			_screenWidth = screenWidth;
			_screenHeight = screenHeight
		}
		
		public function addGameObject(aGameObject:GameObject):void {
			
			_gameObjects.push(aGameObject);
			addChild(aGameObject);
			aGameObject.gameWorld = this;
		}
		
		public function removeGameObject(aGameObject:GameObject):void {
			var i:int = 0;
			while (i < _gameObjects.length) {
				if (_gameObjects[i] == aGameObject) {
					removeChild(aGameObject);
					_gameObjects.splice(i, 1);
				}
				i++;
			}
		}
		
		public function get screenWidth():int {
			return _screenWidth;
		}
		
		public function get screenHeight():int {
			return _screenHeight;
		}
		
		public function clear():void {
			trace("KeepInTouchEngine: Clearing game world", this);
			while (numChildren > 0) removeChildAt(0);
			_gameObjects = new Array();
		}

		
		
		override public final function doFrame(inputState:InputState, previousInputState:InputState):void {
			super.doFrame(inputState, previousInputState);
			
			if (!paused) {
				var i:int = 0;
				while (i < _gameObjects.length) {
					//if (_gameObjects[i] is PlayerObject) {
						//(_gameObjects[i] as PlayerObject).handleInput(inputState, previousInputState);
					//}
					if (_gameObjects[i] is IUpdateable) {
						(_gameObjects[i] as IUpdateable).update();
					}
					if ((_gameObjects[i] as GameObject).destroyed ) {
						removeChild(_gameObjects[i]);
						_gameObjects.splice(i, 1);
					} else {
						i++;
					}
				}
			}
			update();
		}
		
		public function update():void {
			
		}
		
		public function countObjects(aClass:Class):int {
			var result:int = 0;
			for (var i:int = 0; i < _gameObjects.length; i++) {
				if (_gameObjects[i] is aClass) result++;
			}
			return result;
		}
		
		public function getObject(aClass:Class, index:int = 0, exclude:GameObject = null):GameObject {
			for (var i:int = 0; i < _gameObjects.length; i++) {
				if (_gameObjects[i]!=exclude && _gameObjects[i] is aClass) {
					if (index == 0) return (_gameObjects[i] as GameObject);
					index--;
				}
			}
			return null;
		}
		
		public function getObjectAt(x:Number, y:Number, index:int = 0, exclude:GameObject = null):GameObject {
			for (var i:int = 0; i < _gameObjects.length; i++) {
				if (_gameObjects[i]!=exclude && (_gameObjects[i] as GameObject).pointInObject(x, y)) {
					if (index == 0) return (_gameObjects[i] as GameObject);
					index--;
				}
			}
			return null;
		}
		
		public function getNearestObject(aClass:Class, x:Number, y:Number, exclude:GameObject = null):GameObject {
			var minDistance:Number = 999999;
			var distance:Number;
			var dx:Number = 0;
			var dy:Number = 0;
			var result:GameObject = null;
			for (var i:int = 0; i < _gameObjects.length; i++) {
				if (_gameObjects[i] != exclude && _gameObjects[i] is aClass) {
					dx = (_gameObjects[i] as Sprite).x - x;
					dy = (_gameObjects[i] as Sprite).y - y;
					distance = Math.sqrt((dx * dx) + (dy * dy));
					if (distance < minDistance) {
						minDistance = distance;
						result = (_gameObjects[i] as GameObject);
					}
				}
			}
			return result;
		}
	}
	
}