package  {
	public class LevelGenerator {
		// designed patterns constants
		public static const Dots3PerRow100RowSpace:uint = 10000;
		// other constants
		private static const ScreenBorder = 100; // the sum of the left and right screen borders
		private static const SeparationWidth:uint = 60; // minimum x distance between the centers of rainbows
		private static const SeparationHeight:uint = 30; // minimum y distance between the centers of rainbows
		
		private var level:Level;
		
		public function LevelGenerator(level:Level, type:uint, yMin:Number, yMax:Number) {
			this.level = level;
			var elementDistribution:Array;
			var elementsPerRowDistribution:Array;
			switch(type) {
				// random generation
				case 1:
					// normal, gray, boost, glass, mobile rainbow, cloud, mobile cloud, fading rainbow, mine, coin, dot
					elementDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
					// 1 per row, 2 per row, 3 per row, etc.
					elementsPerRowDistribution = new Array(1.0, 1.0, 1.0, 1.0, 1.0);
					this.generateRandom(yMin, yMax, 150, false, true, elementDistribution, elementsPerRowDistribution);
					break;
				case 2:
					elementDistribution = new Array(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
					elementsPerRowDistribution = new Array(0.0, 0.0, 0.0, 0.0, 1.0);
					this.generateRandom(yMin, yMax, 100, false, false, elementDistribution, elementsPerRowDistribution);
					break;
				
				// designed patterns
				case Dots3PerRow100RowSpace:
					this.generateDots3PerRow100RowSpace(yMin, yMax);
					break;
				default:
					break;
			}
		}
		
		// generate random segment according to specifications
		private function generateRandom(yMin:Number, yMax:Number, rowHeight:Number, yVariation:Boolean, xVariation:Boolean, elementDistribution:Array, elementsPerRowDistribution:Array) {
			var x:Number = 0;
			var y:Number = 0;
			var currentY:Number = yMin;
			var overlap:Boolean; // whether the current coords overlaps an existing platform
			
			while (currentY <= yMax) {
				var numElementsPerRow:uint = this.getNumElementsPerRow(elementsPerRowDistribution);
				for (var i:uint = 0;  i < numElementsPerRow; i++) {
					do {
						overlap = false;
						if (xVariation) {
							x = Math.random() * (RainbowGameObject.StageWidth - ScreenBorder)
							- (RainbowGameObject.StageWidth - ScreenBorder) / 2;
						} else {
							x = (RainbowGameObject.StageWidth / (numElementsPerRow + 1)) * (i + 1) - RainbowGameObject.StageWidth / 2;
						}
						
						if (yVariation) {
							y = Math.random() * rowHeight - rowHeight + currentY;
						} else {
							y = currentY;
						}
						// prevent creation of rainbow in existing rainbow location
						for each (var element:GameObject in this.level.rgo.rainbowList) {
							if (Math.abs(element.mx - x) < SeparationWidth && Math.abs(element.my - y) < SeparationHeight) {
								overlap = true;
							}
						}
					} while (overlap);
					this.level.addElement(y, x, this.getElementClassByDistribution(elementDistribution));
				}
				currentY += rowHeight;
			}
		}
		
		// obtain a number of elements per row for random generation according to distribution
		private function getNumElementsPerRow(elementsPerRowDistribution:Array):uint {
			var seed:Number = Math.random();
			if (seed < elementsPerRowDistribution[0]) {
				return 1;
			}
			if (seed >= elementsPerRowDistribution[0] && seed < elementsPerRowDistribution[1]) {
				return 2;
			} 
			else if (seed >= elementsPerRowDistribution[1] && seed < elementsPerRowDistribution[2]) {
				return 3;
			}
			else if (seed >= elementsPerRowDistribution[2] && seed < elementsPerRowDistribution[3]) {
				return 4;
			}
			else if (seed >= elementsPerRowDistribution[3] && seed < elementsPerRowDistribution[4]) {
				return 5;
			}
			return 1;
		}
		
		// obtain an element class for random generation according to distribution
		private function getElementClassByDistribution(elementDistribution:Array):String {
			var seed:Number = Math.random();
			if (seed >= elementDistribution[0] && seed < elementDistribution[1]) {
				//r = new RainbowGray();
				return Level.PlatformNormal;
			} 
			else if (seed >= elementDistribution[1] && seed < elementDistribution[2]) {
				//r = new RainbowBoost();
				return Level.PlatformNormal;
			}
			else if (seed >= elementDistribution[2] && seed < elementDistribution[3]) {
				return Level.PlatformDrop;
			}
			else if (seed >= elementDistribution[3] && seed < elementDistribution[4]) {
				return Level.PlatformMobile;
			}
			else if (seed >= elementDistribution[4] && seed < elementDistribution[5]) {
				//r = new Cloud();
				return Level.PlatformNormal;
			}
			else if (seed >= elementDistribution[5] && seed < elementDistribution[6]) {
				//r = new CloudMobile();
				return Level.PlatformNormal;
			}
			else if (seed >= elementDistribution[6] && seed < elementDistribution[7]) {
				//r = new RainbowFade();
				return Level.PlatformNormal;
			}
			else if (seed >= elementDistribution[7] && seed < elementDistribution[8]) {
				//r = new Mine();
				return Level.PlatformNormal;
			}
			else if (seed >= elementDistribution[8] && seed < elementDistribution[9]) {
				return Level.Coin;
			}
			else if (seed >= elementDistribution[9] && seed < elementDistribution[10]) {
				return Level.AntigravDot;
			}
			return Level.PlatformNormal;
		}
		
		/********** Designed Patterns **********/
		
		private function generateDots3PerRow100RowSpace(yMin:Number, yMax:Number) {
			var currentY:Number = yMin;
			while (currentY <= yMax) {
				this.level.addElement(currentY, -100, Level.AntigravDot);
				this.level.addElement(currentY, 0, Level.AntigravDot);
				this.level.addElement(currentY, 100, Level.AntigravDot);
				currentY += 100;
			}
		}
	}
}
