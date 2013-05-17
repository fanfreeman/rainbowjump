/**
		 * Add new rainbows to the stage
		 * 
		 * @param isInitialization set to true if add the very first rainbows
		 * at the beginning of a new game
		 */
		public function addRainbows(isInitialization:Boolean) {
			var x:Number = 0;
			var y:Number = 0;
			var yMin:Number;
			var yMax:Number;
			var yRange:Number;
			var yStepRange:Number;
			var moveDist:Number;
			var overlap:Boolean; // whether the current coords overlaps an existing platform
			var existingRainbow:String;
			if (isInitialization) {
				yMin = -StageHeight / 2;
				yMax = StageHeight /2;
				yRange = yMax - yMin;
				yStepRange = yRange / this.myLevel.numVerticalSections;
				moveDist = StageHeight / 2;
				while (this.currentVerticalSection < this.myLevel.numVerticalSections) {
					for (var i:uint=0; i<this.myLevel.numPerVerticalSection; i++) {
						do {
							overlap = false;
							x = Math.random() * (StageWidth - ScreenBorder) - (StageWidth - ScreenBorder) / 2
							if (this.myLevel.yVariation) {
								y = Math.random() * yStepRange - moveDist;
							} else {
								y =yStepRange - moveDist;
							}
							// prevent creation of rainbow in existing rainbow location
							for (existingRainbow in rainbowList) {
								if (Math.abs(rainbowList[existingRainbow].mx - x) < SeparationWidth && Math.abs(rainbowList[existingRainbow].my - y) < SeparationHeight) {
									overlap = true;
								}
							}
						} while (overlap);
						this.addPlatform(x, y, isInitialization);
					}
					moveDist -= yStepRange;
					this.currentVerticalSection++;
				}
			}
			
			// only add to the half-size section above visible stage
			yMin = StageHeight / 2;
			yMax = StageHeight;
			yRange = yMax - yMin;
			yStepRange = yRange / (this.myLevel.numVerticalSections / 2);
			moveDist = StageHeight / 2;
			while (this.currentVerticalSection < this.myLevel.numVerticalSections * 1.5) {
				for (var ii:uint=0; ii<this.myLevel.numPerVerticalSection; ii++) {
					do {
						overlap = false;
						x = Math.random() * (StageWidth - ScreenBorder) - (StageWidth - ScreenBorder) / 2
						if (this.myLevel.yVariation) {
							y = Math.random() * yStepRange + moveDist;
						} else {
							y = yStepRange + moveDist;
						}
						// prevent creation of rainbow in existing rainbow location
						for (existingRainbow in rainbowList) {
							if (Math.abs(rainbowList[existingRainbow].mx - x) < SeparationWidth && Math.abs(rainbowList[existingRainbow].my - y) < SeparationHeight) {
								overlap = true;
							}
						}
					} while (overlap);
					this.addPlatform(x, y, isInitialization);
				}
				moveDist += yStepRange;
				this.currentVerticalSection++;
			}
			this.currentVerticalSection = this.myLevel.numVerticalSections;
		}
		
		/**
		 * Add one platform to the platform list
		 *
		 * @param x y the custom coordinates of the platform
		 * @isInitialization if set to true, only create normal platforms
		 */
		private function addPlatform(x:Number, y:Number, isInitialization:Boolean) {
			var r:GameObject;
			if (isInitialization) { // only create normal rainbows during initialization
				r = new Rainbow();
			} else { // if not initialization, we can create all types of rainbows
				var seed:Number = Math.random();
				if (seed >= myLevel.distribution[0] && seed < myLevel.distribution[1]) {
					r = new RainbowGray();
				} 
				else if (seed >= myLevel.distribution[1] && seed < myLevel.distribution[2]) {
					r = new RainbowBoost();
				}
				else if (seed >= myLevel.distribution[2] && seed < myLevel.distribution[3]) {
					r = new RainbowGlass();
				}
				else if (seed >= myLevel.distribution[3] && seed < myLevel.distribution[4]) {
					r = new RainbowMobile();
				}
				else if (seed >= myLevel.distribution[4] && seed < myLevel.distribution[5]) {
					r = new Cloud();
				}
				else if (seed >= myLevel.distribution[5] && seed < myLevel.distribution[6]) {
					r = new CloudMobile();
				}
				else if (seed >= myLevel.distribution[6] && seed < myLevel.distribution[7]) {
					r = new RainbowFade();
				}
				else if (seed >= myLevel.distribution[7] && seed < myLevel.distribution[8]) {
					r = new Mine();
				}
				else if (seed >= myLevel.distribution[8] && seed < myLevel.distribution[9]) {
					r = new Coin();
				}
				else {
					r = new Rainbow();
				}
			}
			
			r.setX(x);
			r.setY(y);
			this.addChild(r);
			this.rainbowList.push(r);
		}