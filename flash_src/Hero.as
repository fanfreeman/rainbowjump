package  {
	import flash.display.*;
	
	public dynamic class Hero extends MovieClip {
		var mx:int;
		var my:int;

		public function Hero() {
			this.mx = 0;
			this.my = 0;
		}

		public function setX(newX:int) {
			// enable left and right border warp
			if (newX < -1 * RainbowGameObject.StageWidth / 2) {
				newX += RainbowGameObject.StageWidth;
			}
			else if (newX >= RainbowGameObject.StageWidth / 2) {
				newX -= RainbowGameObject.StageWidth;
			}
			
			this.mx = newX;
			this.x = RainbowGameObject.StageWidth / 2 + newX;
		}
		
		public function setY(newY:int) {
			this.my = newY;
			this.y = RainbowGameObject.StageHeight / 2 - newY;
		}
	}
}
