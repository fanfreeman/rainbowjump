package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class RainbowGameObject extends MovieClip {
		// constants
		public static const StageWidth:uint = 756;
		public static const StageHeight:uint = 650;
		private static const SeparationWidth:uint = 60; // minimum x distance between the centers of rainbows
		private static const SeparationHeight:uint = 30; // minimum y distance between the centers of rainbows
		private static const Gravity:Number = .00058;
		private static const InitialHeroX:int = -280;
		private static const InitialHeroY:int = -200;
		private static const RewindLength:uint = 300; // number of frames to rewind
		private static const MaxHorizontalVelocity:Number = 0.5;
		private static const ScreenBorder = 100; // the sum of the left and right screen borders
		private static const SpeedFactor = 1.0;
		
		/* instance variables */
		// velocity
		var dx:Number;
		var dy:Number;
		
		// all rainbows
		var rainbowList:Array;
		
		// hero
		var hero:Hero;
		
		// distance scrolled
		var scrollDist:Number = 0;
		
		// total distance climbed
		var climbDist:Number = 0;
		// max distance climbed
		var maxDist:Number = 0;
		
		// keyboard input
		var leftArrow:Boolean = false;
		var rightArrow:Boolean = false;
		var upArrow:Boolean = false;
		var downArrow:Boolean = false;
		
		// score display
		private var gameScoreField:TextField;
		private var gameScore:int;
		
		// game time
		private var gameTimeField:TextField;
		private var gameStartTime:uint;
		private var gameTime:uint;
		
		// level finished delay timer to allow player to play a bit longer after winning
		private var delayTimer:Timer;
		
		// text to notify player that they win
		private var messageField:TextField;
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
		// whether or not the player has control of the hero
		private var playerControl:Boolean = true;
		
		// the target winning condition
		private var target:uint;
		
		// the current level
		private var myLevel:Level;
		
		// starting mouseX
		private var startingMouseX:int;
		
		// history store
		private var history:Array;
		
		// denotes whether or not we are rewinding
		private var inRewind:Boolean = false;
		private var rewindStep:uint = 0;
		private var rewindsAvailable:int = 1;
		
		// denotes whether or not the simulation should run, we use this to pause the game
		private var doSimulation:Boolean = true;
		
		// background music
		public var bgmHappy:BgmHappy;
		public var bgmSoundChannel:SoundChannel;
		
		// animated scrolling background
		private var bg:Background;
		
		// number of y-axis screen sections for platforms
		private var currentVerticalSection:uint;
		
		/* eof instance variables */
		
		public function RainbowGameObject() {
			// get current level
			this.myLevel = new Level(MovieClip(root).level);
			this.target = myLevel.target;
			this.currentVerticalSection = 0;
			
			// create background
			this.bg = new Background(this, this.target);
			
			// start background music
			this.bgmHappy = new BgmHappy();
			this.bgmSoundChannel = this.bgmHappy.play();
			this.bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, bgmFinished);
			
			// set original mouse position
			this.startingMouseX = mouseX;
			
			// list of all rainbows
			rainbowList = new Array();
			
			// add all rainbows
			addRainbows(true);
			
			// add hero
			hero = new Hero();
			hero.setX(InitialHeroX);
			hero.setY(InitialHeroY);
			addChild(hero);
			
			// add score field
			gameScoreField = new TextField();
			addChild(gameScoreField);
			gameScore = 0;
			showGameScore();
			
			// add time field
			gameTimeField = new TextField();
			gameTimeField.x = 660;
			addChild(gameTimeField);
			gameStartTime = getTimer();
			gameTime = 0;
			
			// initialize history
			this.history = new Array();
			
			// initial velocity and time
			dx = 0.2;
			dy = 0.8;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			addEventListener(Event.ENTER_FRAME, animate);
		}
		
		/**
		 * Loop the background music
		 */
		public function bgmFinished(event:Event) {
			this.bgmSoundChannel = this.bgmHappy.play();
			this.bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, bgmFinished);
		}
		
		/**
		 * Set keydown states to true
		 */
		public function keyPressedDown(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = true;
			} else if (event.keyCode == 39) {
				rightArrow = true;
			} else if (event.keyCode == 38) {
				upArrow = true;
			} else if (event.keyCode == 40) {
				downArrow = true;
			}
		}
		
		/**
		 * Set keydown states to false
		 */
		public function keyPressedUp(event:KeyboardEvent) {
			if (event.keyCode == 37) {
				leftArrow = false;
			} else if (event.keyCode == 39) {
				rightArrow = false;
			} else if (event.keyCode == 38) {
				upArrow = false;
			} else if (event.keyCode == 40) {
				downArrow = false;
			}
		}
		
		/**
		 * Move hero
		 */
		function animate(event:Event) {
			// update time
			var newTime:uint = getTimer() - this.gameStartTime;
			var timeDiff:int = newTime - this.gameTime;
			this.gameTime = newTime;
			timeDiff *= SpeedFactor;
					
			// don't run simulation if game is paused
			if (!this.doSimulation) {
				return;
			}
			
			if (this.inRewind) { // let's rewind the game
				if (this.rewindStep < RewindLength) {
					// restore hero and rainbow locations
					this.hero.setX(this.history[this.rewindStep].heroX);
					this.hero.setY(this.history[this.rewindStep].heroY);
					if (this.history[this.rewindStep].scroll != 0) {
						this.scrollRainbows(-this.history[this.rewindStep].scroll);
					}
					
					// loop through rainbows to reset their states
					for (var rindex:String in this.history[this.rewindStep].rainbows) {
						this.rainbowList[rindex].setX(this.history[this.rewindStep].rainbows[rindex].mx);
					}
					
					this.rewindStep++;
				} else { // finish rewinding
					this.showMessage("Go!!");
					this.pause(1000); // pause for one second
					
					// reset velocities
					this.dx = 0;
					this.dy = 0;
					
					this.inRewind = false;
				}
			} else { // normal gameplay, not rewinding
				// play background
				this.bg.play(timeDiff, this.maxDist);
				
				//gameTimeField.text = "Time: " + clockTime(gameTime);
				gameTimeField.text = "Distance: " + String(Math.floor(maxDist / 10));
				
				// adjust vertical speed for gravity
				dy -= Gravity * timeDiff;
				
				// handle left and right arrow key input
				if (this.playerControl) {
					if (leftArrow) {
						dx -= 0.002 * timeDiff;
						if (dx < -MaxHorizontalVelocity) {
							dx = -MaxHorizontalVelocity;
						}
					}
					if (rightArrow) {
						dx += 0.002 * timeDiff;
						if (dx > MaxHorizontalVelocity) {
							dx = MaxHorizontalVelocity;
						}
					}
					
					if (mouseX > this.startingMouseX) {
						dx = (mouseX - this.startingMouseX) * timeDiff / 4000;
						if (dx > MaxHorizontalVelocity) {
							dx = MaxHorizontalVelocity;
						}
					} else if (mouseX < this.startingMouseX) {
						dx = -(this.startingMouseX - mouseX) * timeDiff / 4000;
						if (dx < -MaxHorizontalVelocity) {
							dx = -MaxHorizontalVelocity;
						}
					}
				}
				
				// move hero
				hero.setX(hero.mx + timeDiff * dx);
				hero.setY(hero.my + timeDiff * dy);
				this.climbDist += timeDiff * dy;
				if (this.climbDist > this.maxDist) {
					this.maxDist = this.climbDist;
				}
				
				// check for distance traveled winning condition
				if (this.checkWinLose && this.maxDist / 10 > this.target) {
					this.endLevel(true);
				}
				
				// store history
				var gameState:Object = new Object();
				gameState.heroX = hero.mx;
				gameState.heroY = hero.my;
				if (hero.my > 0) {
					gameState.scroll = hero.my;
				} else {
					gameState.scroll = 0;
				}
				gameState.rainbows = new Array();
				
				
				// move everything down
				if (hero.my > 0) {
					scrollRainbows(hero.my);
					hero.setY(0);
				}
				
				// loop through rainbows
				for (var index:String in rainbowList) {
					// store platform coords in history
					var rainbowState:Object = new Object();
					rainbowState.mx = rainbowList[index].mx;
					rainbowState.my = rainbowList[index].my;
					gameState.rainbows[index] = rainbowState;
					
					// check for collision with platforms
					if (this.playerControl) {
						if (rainbowList[index].testCollision(this.hero)) { // we have a bounce
							// we have come in contact with this platform
							rainbowList[index].contact(this);
							
							// check if this is a glass rainbow
							if (Object(rainbowList[index]).constructor == RainbowGlass) {
								this.removeRainbow(index);
							}
							
							// check if this is a fake rainbow
							if (Object(rainbowList[index]).constructor == RainbowGray) {
								this.removeRainbow(index);
							}
							
							// check if this is a mine
							if (Object(rainbowList[index]).constructor == Mine) {
								var explosion:Explosion = new Explosion();
								explosion.x = this.hero.x;
								explosion.y = this.hero.y;
								this.removeChild(this.rainbowList[index]); // remove mine
								this.addChild(explosion);
								this.playExplosion(); // play sound
								this.playerFail();
							}
							
							// update score
							gameScore++;
							showGameScore();
						}
					}
					
					// move mobile rainbows and clouds
					if (Object(this.rainbowList[index]).constructor == RainbowMobile ||
						Object(this.rainbowList[index]).constructor == CloudMobile) {
						this.rainbowList[index].updatePosition(timeDiff);
					}
					
					// update state of fading platforms
					if (Object(this.rainbowList[index]).constructor == RainbowFade) {
						if (this.rainbowList[index].updateState(timeDiff)) {
							if (this.contains(this.rainbowList[index])) {
								removeChild(this.rainbowList[index]);
							}
						} else {
							if (!this.contains(this.rainbowList[index])) {
								addChild(this.rainbowList[index]);
							}
						}
					}
				} // eof loop through rainbows
				
				// continue storing game history
				this.history.unshift(gameState);
				
				// we lose if we fall
				if (this.checkWinLose && hero.my < -1 * StageHeight / 2) {
					this.playerFail();
					return;
				}
			}
		}
		
		/**
		 * Player fails, check to see if saves are available
		 */
		private function playerFail() {
			if (this.rewindsAvailable > 0 && this.history.length > RewindLength) {
				this.rewind();
			} else {
				this.endLevel(false);
			}
		}
		
		/**
		 * Begin game rewind
		 */
		private function rewind() {
			this.rewindsAvailable--;
			this.inRewind = true;
			this.rewindStep = 0;
			this.showMessage("Rewind!");
			this.pause(1000); // pause for one second
		}
		
		/**
		 * Pause gameplay for the speicied amount in milliseconds
		 */
		private function pause(time:uint) {
			this.doSimulation = false;
			var pauseTimer:Timer = new Timer(time, 1);
			pauseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, unpause);
			pauseTimer.start();
		}
		
		/**
		 * Unpause gameplay
		 */
		private function unpause(event:TimerEvent) {
			// reset mouse position after pause
			this.startingMouseX = mouseX;
			this.doSimulation = true;
		}
		
		/**
		 * Remove a rainbow from screen and garbage collect
		 */
		public function removeRainbow(index) {
			removeChild(this.rainbowList[index]);
			//this.rainbowList[index] = null;
			//this.rainbowList.splice(index, 1);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollRainbows(distance:Number) {
			for (var index:String in rainbowList) {
				rainbowList[index].my -= distance;
				rainbowList[index].y = getStageY(rainbowList[index].my);
				
				// remove a rainbow if it has scrolled beyond visible screen
				//if (rainbowList[index].my <= -1 * StageHeight / 2) {
					//this.removeRainbow(index);
				//}
			}
			
			this.scrollDist += distance;
			if (this.scrollDist >= StageHeight / 2) {
				this.addRainbows(false);
				this.scrollDist -= StageHeight / 2;
			}
		}
		
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
			var r:Platform;
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
				else {
					r = new Rainbow();
				}
			}
			
			r.setX(x);
			r.setY(y);
			this.addChild(r);
			this.rainbowList.push(r);
		}
		
		/**
		 * Display a big message on screen
		 */
		public function showMessage(message:String) {
			var myFormat:TextFormat = new TextFormat();
			myFormat.font = "Arial";
			myFormat.size = 96;
			myFormat.bold = true;
			myFormat.color = 0xFF66CC;
			myFormat.align = "center";
			this.messageField = new TextField();
			this.messageField.defaultTextFormat = myFormat;
			this.messageField.selectable = false;
			this.messageField.y = 240;
			this.messageField.text = message;
			this.messageField.width = StageWidth;
			this.addChild(this.messageField);
			
			var messageTimer:Timer = new Timer(2000, 1);
			messageTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hideMessage);
			messageTimer.start();
		}
		
		/**
		 * Hide the big message on screen
		 */
		public function hideMessage(event:TimerEvent) {
			this.removeChild(this.messageField);
		}
		
		/**
		 * Finish playing the current level
		 */
		public function endLevel(isVictory:Boolean) {
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			if (isVictory) {
				// add win notify field
				this.showMessage("You Win!");
			
				this.delayTimer = new Timer(3000, 1);
				this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
				this.delayTimer.start();
				
				// update level
				MovieClip(root).level += 1;
			} else { // player loses
				// revoke player control of hero
				this.playerControl = false;
				
				// add win notify field
				this.showMessage("You Lose");
			
				this.delayTimer = new Timer(3000, 1);
				this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
				this.delayTimer.start();
			}
		}
		
		/**
		 * Clean up the stage and end game
		 */
		public function endGame(event:TimerEvent) {
			if (event != null) {
				this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endGame);
			}
			this.removeEventListener(Event.ENTER_FRAME, animate);
			for (var indexRemove:String in this.rainbowList) {
				//this.removeChild(this.rainbowList[indexRemove]); // cannot remove here because glass rainbows are already removed
				this.rainbowList[indexRemove] = null;
			}
			this.removeChild(this.hero);
			this.hero = null;
			
			// stop background music
			this.bgmSoundChannel.stop();

			MovieClip(root).gameScore = gameScore;
			MovieClip(root).gameTime = clockTime(gameTime);
			MovieClip(root).gotoAndStop("gameover");
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public static function getStageX(x:int) {
			if (x < -1 * StageWidth / 2) {
				x += StageWidth;
			}
			else if (x >= StageWidth / 2) {
				x -= StageWidth;
			}
			
			return StageWidth / 2 + x;
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public static function getStageY(y:int) {
			return StageHeight / 2 - y;
		}
		
		/**
		 * Display the game score
		 */
		public function showGameScore() {
			gameScoreField.text = "Score: " + String(gameScore);
		}
		
		/**
		 * Provides a nicely formatted time display given input in milliseconds
		 */
		 public function clockTime(ms:int) {
			 var seconds:int = Math.floor(ms / 1000);
			 var minutes:int = Math.floor(seconds / 60);
			 seconds -= minutes * 60;
			 var timeString:String = minutes + ":" + String(seconds + 100).substr(1, 2);
			 return timeString;
		 }
		 
		 /**
		  * Play a sound effect
		  */
		  private function playSound(soundObject:Object) {
			  var channel:SoundChannel = soundObject.play();
		  }
		  
		  public function playHighThud() {
			  this.playSound(new HighThud());
		  }
		  
		  public function playLowThud() {
			  this.playSound(new LowThud());
		  }
		  
		  public function playExplosion() {
			  this.playSound(new SfxExplosion());
		  }
	}
}
