package core 
{
	public class InputState 
	{
		public var left:Boolean = false;
		public var right:Boolean = false;
		public var up:Boolean = false;
		public var down:Boolean = false;
		public var space:Boolean = false;
		public var enter:Boolean = false;
		public var escape:Boolean = false;
		public var control:Boolean = false;
		public var shift:Boolean = false;
		public var mouseButton:Boolean = false;
		public var mouseX:int = 0;
		public var mouseY:int = 0;
		
		public function InputState() 
		{
			
		}
		
		public function copy(aInputState:InputState):void {
			this.left = aInputState.left;
			this.right = aInputState.right;
			this.up = aInputState.up;
			this.down = aInputState.down;
			this.space = aInputState.space;
			this.enter = aInputState.enter;
			this.escape = aInputState.escape;
			this.control = aInputState.control;
			this.shift = aInputState.shift;
			this.mouseButton = aInputState.mouseButton;
			this.mouseX = aInputState.mouseX;
			this.mouseY = aInputState.mouseY;
		}
		
		public function clear():void {
			left= false;
			right = false;
			up = false;
			down = false;
			space = false;
			enter = false;
			escape = false;
			control = false;
			shift = false;
			mouseButton = false;
			mouseX = 0;
			mouseY = 0;
			
		}
		
	}
	
}