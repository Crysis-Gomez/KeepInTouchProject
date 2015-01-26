package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Util
	{
		[Embed(source="ARDELANEY_1.TTF",fontName="keepintouch",mimeType="application/x-font",fontWeight="normal",fontStyle="normal",advancedAntiAliasing="true",embedAsCFF="false")]
		static public const KEEPINTOUCHFONT:Class;
		static private var colorArray:Array = [0x00FF00, 0xFF0000, 0xFFFF00, 0x0000FF, 0x8000FF, 0xFF8000];
		
		public function Util()
		{
		
		}
		
		static public function random(min:Number, max:Number):Number
		{
			return min + Math.random() * (max - min);
		}
		
		static public function wait(afterWait:Function, waitTime:Number):void
		{
			var timer:Timer = new Timer(waitTime, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function():void
				{
					afterWait();
				//trace("does this fail");
				}, false, 0, true);
		}
		
		static public function multiColorText(field:TextField):TextField
		{
			var colorIndex:int = -1;
			for (var i:int = 0; i < field.text.length; i++)
			{
				colorIndex++;
				if (colorIndex > colorArray.length - 1)
					colorIndex = 0;
				
				var textFormat:TextFormat = field.getTextFormat(i);
				textFormat.align = TextFormatAlign.CENTER;
				textFormat.font = "keepintouch"
				//textFormat.size = 72;
				textFormat.color = colorArray[colorIndex];
				field.embedFonts = true;
				field.setTextFormat(textFormat, i);
				
			}
			
			return field;
		}
		
		static public function createTextfield(text:String, width:Number, height:Number, textSize:Number, color:uint):TextField
		{
			var textField:TextField = new TextField();
			var textFormat:TextFormat = new TextFormat("keepintouch", textSize, color);
			textFormat.align = TextFormatAlign.CENTER;
			textField.defaultTextFormat = textFormat;
			//textField.setTextFormat(textFormat);
			
			textField.text = text;
			textField.width = width;
			textField.height = height;
			textField.textColor = color;
			textField.selectable = false;
			textField.embedFonts = true;
			textField.mouseEnabled = false;

			return textField;
		
		}
		
		public static function convertTextFieldToBitmap(textField : TextField) : Bitmap
		{
			var bitmapData : BitmapData = new BitmapData(textField.width,textField.height, true, 0*00000000);
			bitmapData.draw(textField);
			var bitmap : Bitmap = new Bitmap(bitmapData);
			bitmap.smoothing = true;
			return bitmap;
		}
		
		static public function createButton(text:String, width:Number, height:Number, color:uint):Sprite 
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(4, color);
			sprite.graphics.beginFill(0x000000);
			sprite.graphics.drawRoundRect( -width / 2, -height / 2, width, height, 20, 20);
			sprite.graphics.endFill();
	
	
			var buttonText:TextField = createTextfield(text, width, height, height, color);
			var bitmap:Bitmap = convertTextFieldToBitmap(buttonText);
			bitmap.x = -width / 2;
			bitmap.y  = -3.5 * height / 6;
			sprite.addChild(bitmap);
			
			
			
			return sprite;
		}
		
		static public function generateCheckeredPattern():BitmapData
		{
			var checkeredSprite:Sprite = new Sprite();
			
			// Box colour 1
			var even:uint = 0x000000;
			
			// Box colour 2
			var odd:uint = 0xFFFFFF;
			
			// Box size
			var size:int = 10;
			
			// number of boxes horizontally
			var nH:int = 140;
			
			// number of boxes vertically
			var nV:int = 140;
			
			// vars to be used in the loops
			var clr:uint;
			var i:uint;
			var j:uint;
			
			// loop vertical
			for (i = 0; i < nV; ++i)
			{
				// Flip values of Even and Odd colours using Bitwise operations
				even ^= odd;
				odd ^= even;
				even ^= odd;
				
				// loop horizontal
				for (j = 0; j < nH; ++j)
				{
					//bitwise modulus
					//check if column is odd or even, then set colour
					clr = j & 1 ? even : odd;
					
					// draw box with previously set colour
					checkeredSprite.graphics.beginFill(clr, 1);
					checkeredSprite.graphics.drawRect(Number(j * size), Number(i * size), size, size);
					checkeredSprite.graphics.endFill();
				}
			}
			
			var b:BitmapData = new BitmapData(140, 140, true, 0x0);
			b.draw(checkeredSprite);
			
			return b;
		}
	
	}

}