package  {
	
	public class Cannon extends PlatformNormal {
		
		private var touched:Boolean = false;
		
		public override function contact(rgo:RainbowGameObject) {
			if (!touched && rgo.dy < 0) {
					rgo.dy = rgo.level.definition.cannonBouncePower;
				
					// play sound effect
					rgo.soundControl.playBoom();
					// play explosion effect
					var explosion:Explosion = new Explosion();
					explosion.x = this.x;
					explosion.y = this.y;
					rgo.addChild(explosion);
					this.visible = false;
					this.touched = true;
			}
		}
	}
}
