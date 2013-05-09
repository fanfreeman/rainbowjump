package  {
	
	public class CloudMobile extends Cloud {

		public static const Width:uint = 150;
		public static const PosChangeSpeed = 0.3; // speed of movement
		public var movingRight:Boolean;
		
		public function CloudMobile() {
			super();
			
			if (Math.random() * 100 > 49) {
				this.movingRight = true;
			} else {
				this.movingRight = false;
			}
		}
		
		public function updatePosition(timeDiff:Number) {
			if (this.movingRight) {
				if (this.mx > RainbowGameObject.StageWidth / 2 + Width / 2) {
					this.setX(-RainbowGameObject.StageWidth / 2 - Width / 2);
				} else {
					this.setX(this.mx + PosChangeSpeed * timeDiff);
				}
			} else { // moving left
				if (this.mx < -RainbowGameObject.StageWidth / 2 - Width / 2) {
					this.setX(RainbowGameObject.StageWidth / 2 + Width / 2);
				} else {
					this.setX(this.mx - PosChangeSpeed * timeDiff);
				}
			}
		}
	}
}
