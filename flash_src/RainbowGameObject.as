package  {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Mouse;
	
	public class RainbowGameObject extends MovieClip {
		// constants
		private static const NumRainbows:uint = 10;
		private static const RainbowWidth:uint = 60;
		private static const RainbowHeight:uint = 30;
		private static const Gravity:Number = .00058;
		private static const InitialHeroX:int = -280;
		private static const InitialHeroY:int = -200;
		
		/* instance variables */
		// stage size
		var stageWidth:uint;
		var stageHeight:uint;
		
		// velocity
		var dx:Number;
		var dy:Number;
		
		// all rainbows
		var rainbowList:Array;
		
		// hero
		var hero:Hero;
		
		// distance scrolled
		var scrollDist:uint = 0;
		
		// total distance climbed
		var climbDist:uint = 0;
		// max distance climbed
		var maxDist:uint = 0;
		
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
		
		// sound effects
		var theLowThud:LowThud = new LowThud();
		var theHighThud:HighThud = new HighThud();
		
		// level finished delay timer to allow player to play a bit longer after winning
		private var delayTimer:Timer;
		
		// text to notify player that they win
		private var winNotifyField:TextField;
		
		// whether or not to check win/lose condition
		private var checkWinLose:Boolean = true;
		
		// the target winning condition
		private var target:uint;
		
		// the current level
		private var myLevel:Level;
		
		// starting mouseX
		private var startingMouseX:int;
		/* eof instance variables */
		
		public function RainbowGameObject() {
			Mouse.hide();
			this.startingMouseX = mouseX;
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			// get current level
			this.myLevel = new Level(MovieClip(root).level);
			this.target = myLevel.target;
			
			// list of all rainbows
			rainbowList = new Array();
			
			// add all rainbows
			addRainbows(true);
			
			// add hero
			hero = new Hero(stageWidth, stageHeight);
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
			
			// initial velocity and time
			dx = 0.2;
			dy = 0.8;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
			addEventListener(Event.ENTER_FRAME, animate);
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
			var newTime:uint = getTimer() - gameStartTime;
			var timeDiff:int = newTime - gameTime;
			gameTime = newTime;
			//gameTimeField.text = "Time: " + clockTime(gameTime);
			gameTimeField.text = "Distance: " + String(Math.floor(maxDist / 10));
			
			// adjust vertical speed for gravity
			dy -= Gravity * timeDiff;
			
			// handle left and right arrow key input
			if (leftArrow) {
				dx -= 0.05;
				if (dx < -0.3) {
					dx = -0.3;
				}
			}
			if (rightArrow) {
				dx += 0.05;
				if (dx > 0.3) {
					dx = 0.3;
				}
			}
			
			if (mouseX > this.startingMouseX) {
				dx = (mouseX - this.startingMouseX) / 300;
				if (dx > 0.5) {
					dx = 0.5;
				}
			} else if (mouseX < this.startingMouseX) {
				dx = -(this.startingMouseX - mouseX) / 300;
				if (dx < -0.5) {
					dx = -0.5;
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
			
			// move everything down
			if (hero.my > 0) {
				scrollRainbows(hero.my);
				hero.setY(0);
			}
			
			// check for collision with rainbow when moving downward
			if (dy < 0 ) {
				for (var index:String in rainbowList) {
					if (rainbowList[index].hitTestPoint(hero.x - 20, hero.y + 16, true) ||
						rainbowList[index].hitTestPoint(hero.x + 20, hero.y + 16, true)) { // we have a bounce
						// flip rainbow
						rainbowList[index].startFlip();
						
						// bounce up on collision
						if (rainbowList[index].bouncePower != 0) {
							dy = rainbowList[index].bouncePower;
						}
						
						// check if this is a glass rainbow
						if (Object(rainbowList[index]).constructor == RainbowGlass) {
							this.removeRainbow(index);
						}
						
						// play sound effect
						playSound(theHighThud);
						
						// update score
						gameScore++;
						showGameScore();
					}
				}
			}
			
			// we lose if we fall
			if (this.checkWinLose && hero.my < -1 * stageHeight / 2) {
				this.endLevel(false);
			}
		}
		
		/**
		 * Remove a rainbow from screen and garbage collect
		 */
		public function removeRainbow(index) {
			removeChild(this.rainbowList[index]);
			this.rainbowList[index] = null;
			this.rainbowList.splice(index, 1);
		}
		
		/**
		 * Scroll all of the rainbows downward
		 */
		public function scrollRainbows(distance:uint) {
			for (var index:String in rainbowList) {
				rainbowList[index].my -= distance;
				rainbowList[index].y = getStageY(rainbowList[index].my);
				
				// remove a rainbow if it has scrolled beyond visible screen
				if (rainbowList[index].my <= -1 * stageWidth / 2) {
					this.removeRainbow(index);
				}
			}
			
			this.scrollDist += distance;
			if (this.scrollDist >= stageHeight / 2) {
				this.addRainbows(false);
				this.scrollDist -= stageHeight / 2;
			}
		}
		
		/**
		 * Add new rainbows to the stage
		 * 
		 * @param isInitialization set to true if add the very first rainbows
		 * at the beginning of a new game
		 */
		public function addRainbows(isInitialization:Boolean) {
			// add 1.5 times the rainbows if we are initializing
			var numRainbows:uint = 0;
			if (isInitialization) {
				numRainbows = NumRainbows * 1.5;
			} else {
				numRainbows = NumRainbows * 0.5;
			}
			
			// add rainbows
			for (var i:uint=0; i<numRainbows; i++) {
				var x:Number = Math.random() * stageWidth - stageWidth / 2;
				var y:Number = 0;
				if (isInitialization) {
					y = Math.random() * stageHeight * 1.5 - stageHeight / 2;
				} else {
					y = Math.random() * stageHeight * 0.5 + stageHeight / 2;
				}
				
				// prevent creation of rainbow in existing rainbow location
				var skip:Boolean = false;
				for (var existingRainbow:String in rainbowList) {
					if (Math.abs(rainbowList[existingRainbow].mx - x) < RainbowWidth && Math.abs(rainbowList[existingRainbow].my - y) < RainbowHeight) {
						skip = true;
						break;
					}
				}
				if (skip) {
					i--;
					continue;
				}
				
				//var r:Rainbow = new Rainbow();
				var r:Rainbow;
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
					else {
						r = new Rainbow();
					}
				}
				
				r.mx = x;
				r.my = y
				r.x = getStageX(r.mx);
				r.y = getStageY(r.my);
				addChild(r);
				rainbowList.push(r);
			}
		}
		
		/**
		 * Finish playing the current level
		 */
		public function endLevel(isVictory:Boolean) {
			// stop checking win/lose condition
			this.checkWinLose = false;
			
			if (isVictory) {
				// add win notify field
				var myFormat:TextFormat = new TextFormat();
				myFormat.font = "Arial";
				myFormat.size = 96;
				myFormat.bold = true;
				myFormat.color = 0xFF66CC;
				this.winNotifyField = new TextField();
				this.winNotifyField.defaultTextFormat = myFormat;
				this.winNotifyField.x = 180;
				this.winNotifyField.y = 240;
				this.winNotifyField.text = "You Win!";
				this.winNotifyField.width = 450;
				this.winNotifyField.height = 300;
				this.addChild(this.winNotifyField);
			
				this.delayTimer = new Timer(3000, 1);
				this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endGame);
				this.delayTimer.start();
				
				// update level
				MovieClip(root).level += 1;
			} else {
				this.endGame(null);
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
				this.removeChild(this.rainbowList[indexRemove]);
				this.rainbowList[indexRemove] = null;
			}
			this.removeChild(this.hero);
			this.hero = null;
			
			Mouse.show();
			
			MovieClip(root).gameScore = gameScore;
			MovieClip(root).gameTime = clockTime(gameTime);
			MovieClip(root).gotoAndStop("gameover");
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public function getStageX(x:int) {
			if (x < -1 * stageWidth / 2) {
				x += stageWidth;
			}
			else if (x >= stageWidth / 2) {
				x -= stageWidth;
			}
			
			return stageWidth / 2 + x;
		}
		
		/**
		 * Convert custom coordinates to Flash stage coordinates
		 */
		public function getStageY(y:int) {
			return stageHeight / 2 - y;
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
		  public function playSound(soundObject:Object) {
			  var channel:SoundChannel = soundObject.play();
		  }
	}
}
