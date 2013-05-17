package  {
	import flash.display.*;
	
	public class GameObject extends MovieClip {
		// custom location
		public var mx:Number;
		public var my:Number;

		public function setX(newX:Number) {			
			this.mx = newX;
			this.x = RainbowGameObject.StageWidth / 2 + newX;
		}
		
		public function setY(newY:Number) {
			this.my = newY;
			this.y = RainbowGameObject.StageHeight / 2 - newY;
		}
	}
}
