package  {
	public class Trampoline extends PlatformNormal {
		
		public override function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = rgo.level.definition.trampolineBouncePower;
				
				// play sound effect
				var temp:Number = Math.random() * 3;
				if (temp < 1) {
					rgo.soundControl.playJump1();
				} else if (temp >= 1 && temp < 2) {
					rgo.soundControl.playJump2();
				} else if (temp >= 2 && temp < 3) {
					rgo.soundControl.playJump3();
				}
				
				this.gotoAndPlay("down");
			}
		}
	}
}
