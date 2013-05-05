package  {
	
	public class Level {

		public var level:uint;
		public var isDistance:Boolean = false;
		public var target:uint;
		public var distribution:Array;
		
		public function Level(level:uint) {
			this.level = level;
			
			switch (level) {
			case 1:
				this.isDistance = true;
				this.target = 100;
				this.distribution = new Array(1.0, 1.0, 1.0);
				break;
			case 2:
				this.isDistance = true;
				this.target = 200;
				this.distribution = new Array(1.0, 1.0, 1.0);
				break;
			case 3:
				this.isDistance = true;
				this.target = 300;
				this.distribution = new Array(0.9, 1.0, 1.0);
				break;
			case 4:
				this.isDistance = true;
				this.target = 400;
				this.distribution = new Array(0.8, 1.0, 1.0);
				break;
			case 5:
				this.isDistance = true;
				this.target = 800;
				this.distribution = new Array(0.7, 0.95, 1.0);
				break;
			default:
				this.isDistance = true;
				this.target = 99999;
				this.distribution = new Array(1.0, 0);
				break;
			}
		}

	}
}
