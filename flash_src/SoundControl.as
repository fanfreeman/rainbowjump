package  {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.*;
	
	public class SoundControl {
		
		// background music
		private var bgmHappy:BgmHappy;
		private var bgmSoundChannel:SoundChannel;

		///////////////////////////////////////////
		// PUBLIC
		public function SoundControl() {
			// constructor code
		}
		
		public function playBgm() {
			// start background music
			this.bgmHappy = new BgmHappy();
			this.bgmSoundChannel = this.bgmHappy.play();
			this.bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, bgmFinished);
		}
		
		public function stopBgm() {
			this.bgmSoundChannel.stop();
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
		
		public function playJump1() {
			this.playSound(new SfxJump1());
		}
		
		public function playJump2() {
			this.playSound(new SfxJump2());
		}
		public function playJump3() {
			this.playSound(new SfxJump3());
		}
		
		public function playScratch() {
			this.playSound(new SfxScratch());
		}
		
		public function playGotCoin() {
			this.playSound(new SfxGotCoin());
		}
		
		public function playBoom() {
			this.playSound(new SfxBoom());
		}
		
		public function playBoing() {
			this.playSound(new SfxBoing());
		}
		
		public function playGoal() {
			this.playSound(new SfxGoal());
		}
		
		///////////////////////////////////////////
		// PRIVATE
		/**
		 * Loop the background music
		 */
		private function bgmFinished(event:Event) {
			this.bgmSoundChannel = this.bgmHappy.play();
			this.bgmSoundChannel.addEventListener(Event.SOUND_COMPLETE, bgmFinished);
		}
		
		/**
		* Play a sound effect
		*/
		private function playSound(soundObject:Object) {
		  var channel:SoundChannel = soundObject.play();
		}
	}
	
}
