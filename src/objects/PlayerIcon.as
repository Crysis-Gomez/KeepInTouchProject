package objects
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerIcon extends Sprite
	{
		private var color:uint;
		private var size:Number;
		private var tokenOffset:Number = 0;
		private var tokenPos:Number = 0;
		private var tokenUp:Boolean = true;
		private var animates:Boolean = false;
		
		public function PlayerIcon(playerColor:uint, iconSize:Number, tokenMaxOffset:Number = 0)
		{
			color = playerColor;
			size = iconSize;
			
			if (tokenMaxOffset > 0)
			{
				tokenOffset = tokenMaxOffset;
				animates = true;
			}
		}
		
		public function draw(tokenPos:Number = 0):void
		{
			graphics.clear()
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
			this.tokenPos = tokenPos;
			if (animates)
			{
				if (tokenUp)
				{
					tokenPos += 2;
				}
				else
				{
					tokenPos -= 2;
				}
				if (tokenPos >= tokenOffset)
				{
					tokenUp = false;
				}
				if (tokenPos <= 0)
				{
					tokenUp = true;
				}
			}
			drawToken(0, 0, tokenPos);
		}
		
		private function drawToken(xPos:Number, yPos:Number, tokenPos:Number = 0):void
		{
			var offset:Number = -tokenPos;
			var rectWidth:Number = size * (1 / 2);
			var rectHeight:Number = -size * 1.8
			
			if (offset < 0)
			{
				graphics.beginFill(0x000000, 1/(tokenPos/10))
				graphics.drawCircle(xPos, yPos, rectWidth / 2 + offset / 10)
				graphics.endFill();
			}
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(xPos - rectWidth / 2, yPos + offset, rectWidth, rectHeight);
			graphics.endFill();
			
			graphics.lineStyle(2);
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(xPos, yPos + rectHeight + offset, rectWidth / 2);
			graphics.endFill();
			graphics.lineStyle(0, 0, 0);
			
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(xPos, yPos + offset, rectWidth / 2);
			graphics.endFill();
		}
	
	}

}