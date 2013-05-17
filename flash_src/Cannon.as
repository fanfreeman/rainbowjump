package  {
	
	public class Cannon extends PlatformNormal {

		public function Cannon() {
			this.bouncePower = 3.5;
		}
		
		public override function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = this.bouncePower;
				
				// play sound effect
				rgo.soundControl.playBoom();
				var explosion:Explosion = new Explosion();
				explosion.x = this.x;
				explosion.y = this.y;
				rgo.removeChild(this);
				rgo.addChild(explosion);
				
				this.gotoAndPlay("down");
			}
		}
	}
	
}
