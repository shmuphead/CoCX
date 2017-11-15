﻿package classes.Scenes.Areas.Desert
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;

	public class Naga extends Monster
	{

		//2a)  Ability -  Poison Bite - poisons player
		protected function nagaPoisonBiteAttack():void {
			//(Deals damage over 4-5 turns, invariably reducing 
			//your speed. It wears off once combat is over.)
			outputText("The " + this.short + " strikes with the speed of a cobra, sinking her fangs into your flesh!  ");
			if(!player.hasStatusEffect(StatusEffects.NagaVenom)) {
				outputText("The venom's effects are almost instantaneous; your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 4) {
					player.spe -= 3;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.createStatusEffect(StatusEffects.NagaVenom,3,0,0,0);
				}
				else {
					player.createStatusEffect(StatusEffects.NagaVenom,0,0,0,0);
					player.takeMagicDamage(5+rand(5));
				}
				player.takeMagicDamage(5+rand(5));
			}
			else {
				outputText("The venom's effects intensify as your vision begins to blur and it becomes increasingly harder to stand.");
				if(player.spe > 3) {
					player.spe -= 2;
					showStatDown( 'spe' );
					// speUp.visible = false;
					// speDown.visible = true;
					player.addStatusValue(StatusEffects.NagaVenom,1,2);
				}
				else player.takeMagicDamage(5+rand(5));
				player.takeMagicDamage(5+rand(5));
			}
			combatRoundOver();
		}
		
		//2b)  Ability - Constrict - entangles player, raises lust 
		//every turn until you break free
		protected function nagaConstrict():void {
			outputText("The " + this.short + " draws close and suddenly wraps herself around you, binding you in place! You can't help but feel strangely aroused by the sensation of her scales rubbing against your body. All you can do is struggle as she begins to squeeze tighter!");
			player.createStatusEffect(StatusEffects.NagaBind,0,0,0,0); 
			if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				player.takeDamage(2+rand(4));
			}
			combatRoundOver();
		}
		
		//2c) Abiliy - Tail Whip - minus ??? HP 
		//(base it on toughness?)
		protected function nagaTailWhip():void {
			outputText("The naga tenses and twists herself forcefully.  ");
			//[if evaded]
			if((player.findPerk(PerkLib.Evade) && rand(6) == 0)) {
				outputText("You see her tail whipping toward you and evade it at the last second. You quickly roll back onto your feet.");
			}
			else if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s tail-whip.");
			}
			else if(player.spe > rand(300)) {
				outputText("You see her tail whipping toward you and jump out of the way at the last second. You quickly roll back onto your feet.");
			}
			else {
				outputText("Before you can even think, you feel a sharp pain at your side as the naga's tail slams into you and shoves you into the sands. You pick yourself up, wincing at the pain in your side. ");
				var damage:Number = str;
				if(player.armorDef < 20) damage += 20 - player.armorDef;
				damage += rand(10);
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.desert.nagaScene.nagaRapeChoice();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe naga's eyes go wide and she turns to leave, no longer interested in you.");
				player.orgasm();
				doNext(game.cleanupAfterCombat);
			} else {
				game.desert.nagaScene.nagaFUCKSJOOOOOO();
			}
		}

		public function Naga(noInit:Boolean = false)
		{
			if (noInit) return;
			trace("Naga Constructor!");
			this.a = "the ";
			this.short = "naga";
			this.imageName = "naga";
			this.long = "You are fighting a naga. She resembles a beautiful and slender woman from the waist up, with dark hair hanging down to her neck. Her upper body is deeply tanned, while her lower body is covered with shiny scales, striped in a pattern reminiscent of the dunes around you. Instead of bifurcating into legs, her hips elongate into a snake's body which stretches far out behind her, leaving a long and curving trail in the sand.  She's completely naked, with her round C-cup breasts showing in plain sight. In her mouth you can see a pair of sharp, venomous fangs and a long forked tongue moving rapidly as she hisses at you.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+10;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_NAGA;
			this.skinTone = "mediterranean-toned";
			this.hairColor = "brown";
			this.hairLength = 16;
			initStrTouSpeInte(38, 50, 55, 42);
			initLibSensCor(55, 55, 40);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 5 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "scales";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusLust = 10;
			this.lust = 30;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 9;
			this.gems = rand(5) + 8;
			this.drop = new WeightedDrop().
					add(null,1).
					add(consumables.REPTLUM,5).
					add(consumables.SNAKOIL,4);
			this.special1 = nagaPoisonBiteAttack;
			this.special2 = nagaConstrict;
			this.special3 = nagaTailWhip;
			this.faceType = FACE_SNAKE_FANGS;
			this.str += 7 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 470;
			checkMonster();
		}

	}

}
