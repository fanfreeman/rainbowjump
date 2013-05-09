package  {
	public class RainbowMobile extends Rainbow {
		
		public static const MaxPosChange:Number = 200; // max movement in one direction
		public static const PosChangeSpeed = 0.3; // speed of movement
		
		public var fixedX:int;
		public var movingRight:Boolean = true;
		
		public function RainbowMobile() {
			super();
			this.fixedX = this.mx;
		}
		
		public function updatePosition(timeDiff:Number) {
			if (this.movingRight) {
				if (this.mx < this.fixedX + MaxPosChange) {
					this.setX(this.mx + PosChangeSpeed * timeDiff);
				} else {
					this.movingRight = false;
				}
			} else { // moving left
				if (this.mx > this.fixedX - MaxPosChange) {
					this.setX(this.mx - PosChangeSpeed * timeDiff);
				} else {
					this.movingRight = true;
				}
			}
		}
	}
}
