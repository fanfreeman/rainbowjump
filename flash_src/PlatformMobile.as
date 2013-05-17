package  {
	public class PlatformMobile extends PlatformNormal {
		
		private static const BackAndForth = true;
		public static const MaxPosChange:Number = 200; // max movement in one direction
		public static const PosChangeSpeed = 0.15; // speed of movement
		
		public var fixedX:int;
		public var movingRight:Boolean = true;
		
		public function PlatformMobile() {
			super();
			this.fixedX = this.mx;
		}
		
		public function updatePosition(timeDiff:Number) {
			if (BackAndForth) {
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
			} else {
				this.setX(this.mx + PosChangeSpeed * timeDiff);
			}
		}
		
		public override function setX(newX:Number) {
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
	}
}
