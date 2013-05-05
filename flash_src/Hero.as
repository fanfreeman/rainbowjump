package  {
	import flash.display.*;
	
	public dynamic class Hero extends MovieClip {
		var mx:int;
		var my:int;
		var stageWidth:uint;
		var stageHeight:uint;

		public function Hero(width:uint, height:uint) {
			this.stageWidth = width;
			this.stageHeight = height;
			this.mx = 0;
			this.my = 0;
		}

		public function setX(newX:int) {
			if (newX < -1 * stageWidth / 2) {
				newX += stageWidth;
			}
			else if (newX >= stageWidth / 2) {
				newX -= stageWidth;
			}
			
			this.mx = newX;
			this.x = stageWidth / 2 + newX;
		}
		
		public function setY(newY:int) {
			this.my = newY;
			this.y = stageHeight / 2 - newY;
		}
	}
	
}
