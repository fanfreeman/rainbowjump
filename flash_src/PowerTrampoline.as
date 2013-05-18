package  {
	
	public class PowerTrampoline extends PlatformNormal {
		
		public override function contact(rgo:RainbowGameObject) {
			if (rgo.dy < 0) {
				rgo.dy = rgo.level.definition.powerTrampolineBouncePower;
				
				rgo.soundControl.playBoing();
				
				this.gotoAndPlay("down");
			}
		}
	}
	
}
