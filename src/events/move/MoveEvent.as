package events.move
{
	import core.world.GameWorld;
	import events.core.EventManager;
	import events.core.GameEvent;
	import events.core.GameEventAnnouncement;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import objects.PlayerArea;
	import screen.PlayScreen;
	
	/**
	 * ...
	 * @author Jerry
	 */
	public class MoveEvent extends GameEvent
	{
		
		private var positionArray:Array = new Array();
		
		private var alltargets:Array = new Array();
		private var checkedDone:Boolean;
		
		public function MoveEvent(playScreen:PlayScreen)
		{
			super(playScreen);
			setPositions();
			eventType = MOVE_EVENT;
			if (AppData.gameSpeed == "slow") {
				timeFinished = 300;
			} else {
				timeFinished = 150;
			}
		}
		
		public function setPositions():void
		{
			playScreen.playerAreas.sortOn(["playerID"], [Array.NUMERIC]);
			
			for (var i:int = 0; i < playScreen.playerAreas.length; i++)
			{
				var area:PlayerArea = playScreen.playerAreas[i];
				positionArray.push(new Vector3D(area.x, area.y));
			}
		}
		
		public function setRandomPositions():void
		{
			//Todo:FUCK THIS SHIT 
			//for (var i:int = 0; i < playScreen.playerAreas.length; i++)
			//{
			//var playerArea:PlayerArea = playScreen.playerAreas[i];
			//getRandomPosition(playerArea);
			//}
			var direction:int = Math.round(Math.random()); // -1 CCW 1 CW
			if (direction == 0)
				direction = -1;
			
			var length:int = Math.round(Util.random(1, 4));
			
			for (var i:int = 0; i < playScreen.playerAreas.length; i++)
			{
				var playerArea:PlayerArea = playScreen.playerAreas[i];
				getPosition(playerArea, direction, length);
			}
		
		}
		
		private function getPosition(playerArea:PlayerArea, direction:int, length:int):void
		{
			var position:Vector3D = new Vector3D(playerArea.x, playerArea.y);
			for (var i:int = 0; i < positionArray.length; ++i)
			{
				if (position.x == positionArray[i].x && position.y == positionArray[i].y)
				{
					var index:int = i;
					var targets:Array = new Array();
					for (var j:int = 0; j < length; ++j)
					{
						index += direction * 1;
						if (index < 0)
							index = positionArray.length - 1;
						if (index > positionArray.length - 1)
							index = 0;
							
						targets.push(positionArray[index]);
					}
					var subtargets:Array = new Array();
					for (var k:int = 0; k < targets.length; ++k) {
						if (k-1 < 0) {
							subtargets.push(calculateSubTargets(new Vector3D(playerArea.x, playerArea.y), targets[k]));
						} else {
							subtargets.push(calculateSubTargets(targets[(k - 1)], targets[k]));;
						}
					}
					targets = new Array();
					for (var l:int = 0; l < subtargets.length; ++l) {
						for (var m:int = 0; m < subtargets[l].length; ++m) {
							targets.push(subtargets[l][m]);
						}
					}
					playerArea.setEvent(this, targets);
					return;
				}
			}
		}
		
		public function getRandomPosition(playerArea:PlayerArea):void
		{
			//Deprecated
			//var count:int = Math.random() * positionArray.length;
			//
			//var target:Vector3D = positionArray[count];
			//
			//if (target.x == playerArea.x && target.y == playerArea.y)
			//{
				//if (positionArray.length <= 1)
				//{
					//positionArray.splice(count, 1);
				//}
				//else
				//{
					//getRandomPosition(playerArea);
					//return;
				//}
			//}
			//else
			//{
				//positionArray.splice(count, 1);
			//}
			//playerArea.setEvent(this, calculateSubTargets(playerArea, target));
		}
		
		private function calculateSubTargets(start:Vector3D, target:Vector3D):Array
		{
			var distance:Vector3D = target.subtract(start);
			
			distance.scaleBy(0.5);
			
			var target1:Vector3D = distance.clone();
			var target2:Vector3D = distance.clone();
			
			
			
			target2.scaleBy(2);
			
			target1 = start.add(target1);
			target2 = start.add(target2);
			
			randomizeTarget(target1, distance.length/2);
			//randomizeTarget(target2, distance.length);
			
			return [ target1,target2];
		}
		
		private function randomizeTarget(target:Vector3D, offset:Number):void
		{
			var offsetsX:Array = [Util.random(3 * (offset / 4), offset), -Util.random(3 * (offset / 4), offset)];
			var offsetX:Number = offsetsX[(Math.round(Math.random()))]
			
			target.x += offsetX;
			if (target.x < 0)
			{
				target.x = 0 + Util.random(3 * (offset / 4), offset);
			}
			else if (target.x > 1920)
			{
				target.x = 1920 - Util.random(3 * (offset / 4), offset);
			}
			
			var offsetsY:Array = [Util.random(3 * (offset / 4), offset), -Util.random(3 * (offset / 4), offset)];
			;
			var offsetY:Number = offsetsY[(Math.round(Math.random()))]
			
			target.y += offsetY;
			if (target.y < 0)
			{
				target.y = 0 + Util.random(3 * (offset / 4), offset);
			}
			else if (target.y > 1080)
			{
				target.y = 1080 - Util.random(3 * (offset / 4), offset);
			}
		}
		
		override public function play():void
		{
			super.play();
			setRandomPositions();
		}
		
		override public function update(playerArea:PlayerArea):void
		{
			super.update(playerArea);
			if (!playerArea.eventDone)
			{
				doMovement(playerArea);
				if (!playerArea.hasTouchPoint)
				{
					playerArea.eventFailed = true;
				}
			}
			else
			{
				if (checkIfEveryOneFinished() && !checkedDone)
				{
					resolveEvent();
					checkedDone = true;
				}
			}
		
		}
		
		private function doMovement(playerArea:PlayerArea):void
		{
			var playerAreaPosition:Vector3D = new Vector3D(playerArea.x, playerArea.y)
			var target:Vector3D = playerArea.eventPropertie[0]
			var diff:Vector3D = target.subtract(playerAreaPosition);
			var dist:Number = diff.length;
			
			if (dist <= playerArea.moveSpeed) // if we will go past when we move just put it in place.
			{
				playerArea.x = target.x;
				playerArea.y = target.y;
				(playerArea.eventPropertie as Array).shift();
				if ((playerArea.eventPropertie as Array).length == 0)
				{
					playerArea.eventDone = true;
				}
			}
			else // If we are not there yet. Keep moving.
			{
				diff.normalize();
				if (playerArea.collisionCoolDown > 0)
				{
					playerArea.collisionCoolDown--;
					playerArea.x += (playerArea.direction.x * playerArea.moveSpeed);
					playerArea.y += (playerArea.direction.y * playerArea.moveSpeed);
				}
				else
				{
					playerArea.direction = diff;
					playerArea.x += playerArea.direction.x * playerArea.moveSpeed;
					playerArea.y += playerArea.direction.y * playerArea.moveSpeed;
				}
				
				if (playerArea.x < 0)
				{
					playerArea.x = 0;
				}
				else if (playerArea.x > 1920)
				{
					playerArea.x = 1920;
				}
				
				if (playerArea.y < 0)
				{
					playerArea.y = 0;
				}
				else if (playerArea.y > 1080)
				{
					playerArea.y = 1080;
				}
				
			}
		}
		
		private function resolveEvent():void
		{
			trace("----" + eventType + "----");
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				if (aPlayerArea.eventFailed)
				{
					aPlayerArea.eventFailed = true;
					aPlayerArea.scoreCounter += -1;
				}
				else
				{
					aPlayerArea.eventPassed = true;
					aPlayerArea.scoreCounter += 1;
				}
				
				
			}
			Util.wait(readyForNewEvent, 1000);
			trace("-----------------------");
		}
		
		private function readyForNewEvent():void 
		{
			trace("removing and starting new event");
			for each (var aPlayerArea:PlayerArea in playScreen.playerAreas)
			{
				aPlayerArea.removeEvent();
			}
			EventManager.getInstance().playEvent();
		}
		
		
		override public function announce():void 
		{
			super.announce();
			var moveEventAnnouncement:MoveEventAnnouncement = new MoveEventAnnouncement(eventType, playScreen, play);
			moveEventAnnouncement.start();
		}
	
	}

}