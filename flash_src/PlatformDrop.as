package  {
	
	public class PlatformDrop extends PlatformNormal {
		public static const PosChangeSpeed = 0.06; // speed of movement
		
		private var isFalling:Boolean = false;
		private var fallVelocity:Number = 0;
		
		public function PlatformDrop() {
			super();
		}
		
		public override function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = rgo.level.definition.normalBouncePower;
				
				// play sound effect
				var temp:Number = Math.random() * 3;
				if (temp < 1) {
					rgo.soundControl.playJump1();
				} else if (temp >= 1 && temp < 2) {
					rgo.soundControl.playJump2();
				} else if (temp >= 2 && temp < 3) {
					rgo.soundControl.playJump3();
				}
				
				this.isFalling = true;
			}
		}

		public function updatePosition(timeDiff:Number) {
			if (this.isFalling) {
				this.setY(this.my + timeDiff * this.fallVelocity);
				this.fallVelocity -= PosChangeSpeed;
			}
		}
	}
}
