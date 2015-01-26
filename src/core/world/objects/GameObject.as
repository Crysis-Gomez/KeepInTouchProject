package core.world.objects 
{
	import core.world.GameWorld;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Robby "HuntiXz" Braaksma
	 */
	public class GameObject extends Sprite
	{
		private var _halfWidth:int;
		private var _halfHeight:int;
		private var _boundingWidth:int;
		private var _boundingHeight:int;
		
		protected var _gameWorld:GameWorld;
		
		private var _destroyed:Boolean;

		public function GameObject() 
		{
			destroyed = false;
		}
		
		public function initiate(gameWorld:GameWorld, x:Number = 0, y:Number = 0, boundingWidth:int=-1, boundingHeight:int=-1):void {
			this.x = x;
			this.y = y;
			
			this.boundingWidth = boundingWidth;
			this.boundingHeight = boundingHeight;
			
			_gameWorld = gameWorld;
			_gameWorld.addGameObject(this);
			
			draw();
		}

		public function get halfWidth():Number {
			return _halfWidth;
		}

		public function get halfHeight():Number {
			return _halfHeight;
		}
		
		public function get boundingWidth():Number {
			return _boundingWidth;
		}

		public function set boundingWidth(value:Number):void {
			_boundingWidth = value;
			_halfWidth = value * 0.5;
		}
		
		public function get boundingHeight():Number {
			return _boundingHeight;
		}

		public function set boundingHeight(value:Number):void {
			_boundingHeight = value;
			_halfHeight = value * 0.5;
		}
		
		public function get gameWorld():GameWorld {
			return _gameWorld;
		}
		
		public function set gameWorld(v:GameWorld):void {
			_gameWorld = v;
		}
		
		public function draw():void {
			
		}
		
		public function get destroyed():Boolean {
			return _destroyed;
		}

		public function set destroyed(value:Boolean):void {
			_destroyed = value;
		}
		
		public function pointInObject(x:Number, y:Number):Boolean {
			return (x >= this.x - _halfWidth && x < this.x + _halfWidth && y >= this.y - _halfHeight && y < this.y + _halfHeight);
		}

		
	}
	
}