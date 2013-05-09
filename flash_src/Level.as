package  {
	
	public class Level {

		public var level:uint; // level number
		public var isDistance:Boolean = false; // this is a climb distance level
		public var target:uint; // climb distance target
		public var distribution:Array; // platform distribution
		public var numVerticalSections:uint = 6; // number of rows per screen
		public var yVariation:Boolean = false; // whether platform y coord is random
		public var numPerVerticalSection:uint = 3; // number of platforms per row
		
		public function Level(level:uint) {
			this.level = level;
			
			
			switch (level) {
			case 1:
				this.isDistance = true;
				this.target = 2;
				this.numVerticalSections = 6;
				this.numPerVerticalSection = 3;
				this.yVariation = true;
				// distribution means:
				// normal, gray, boost, glass, mobile rainbow, cloud, mobile cloud
				this.distribution = new Array(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 1.0);
				break;
			case 2:
				this.isDistance = true;
				this.target = 300;
				this.distribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 3:
				this.isDistance = true;
				this.target = 500;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 4:
				this.isDistance = true;
				this.target = 600;
				this.numPerVerticalSection = 1;
				this.distribution = new Array(0.7, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 5:
				this.isDistance = true;
				this.target = 600;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.6, 0.8, 0.8, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 6:
				this.isDistance = true;
				this.target = 1000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.5, 0.7, 0.8, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 7:
				this.isDistance = true;
				this.target = 1000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.4, 0.6, 0.6, 0.7, 1.0, 1.0, 1.0, 1.0);
				break;
			case 8:
				this.isDistance = true;
				this.target = 1000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 1;
				this.distribution = new Array(0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			case 9:
				this.isDistance = true;
				this.target = 4000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.0, 0.4, 0.6, 0.8, 0.8, 1.0, 1.0, 1.0);
				break;
			case 10:
				this.isDistance = true;
				this.target = 3000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.0, 0.0, 0.0, 0.0, 0.8, 1.0, 1.0, 1.0);
				break;
			case 11:
				this.isDistance = true;
				this.target = 3000;
				this.numVerticalSections = 4;
				this.numPerVerticalSection = 2;
				this.distribution = new Array(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0);
				break;
			default:
				this.isDistance = true;
				this.target = 99999;
				this.distribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
				break;
			}
		}

	}
}
