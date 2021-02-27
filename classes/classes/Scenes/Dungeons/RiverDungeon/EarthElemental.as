/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.RiverDungeon 
{

import classes.*;
import classes.internals.*;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class EarthElemental extends Monster
	{
		public function baseElementalAttack():void {
			outputText("Earth elemental solidify it fist and send punch toward you.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 3);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise punch!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" It hit you square in the chest. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function fluffyOfPunches():void {
			outputText("Earth elemental solidify it fists and goes wild at you sending punches.");
			var damage:Number = inte + wis;
			damage *= ((flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] + 1) * 2);
			damage = Math.round(damage);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath it avoiding all punches!");
			else
			{
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" They hits you all over the body. ");
				damage = player.takePhysDamage(damage, true);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Provoke)) {
				var choiceP:Number = rand(5);
				if (choice1 < 5) fluffyOfPunches();
				if (choiceP == 5) baseElementalAttack();
			}
			else {
				var choice1:Number = rand(5);
				if (choice1 < 3) fluffyOfPunches();
				if (choice1 == 3 || choice1 == 4) baseElementalAttack();
				if (choice1 == 5) eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByEarthElemental();
		}
		
		public function EarthElemental() 
		{
			if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 0) {
				this.long = "You're currently fighting earth elemental. It's four feet tall, it body covered with earth and it's using bare fists to fight.";
				this.tallness = 48;
				initStrTouSpeInte(10, 40, 40, 40);
				initWisLibSensCor(40, 10, 20, 50);
				this.weaponAttack = 5;
				this.armorDef = 10;
				this.armorMDef = 30;
				this.level = 12;
				this.bonusHP = 500;
				this.additionalXP = 50;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 1) {
				this.long = "You're currently fighting earth elemental. It's four feet and three inches tall, it body covered with earth and it's using bare fists to fight.";
				this.tallness = 51;
				initStrTouSpeInte(12, 22, 42, 50);
				initWisLibSensCor(50, 10, 25, 50);
				this.weaponAttack = 7;
				this.armorDef = 15;
				this.armorMDef = 35;
				this.level = 15;
				this.bonusHP = 600;
				this.additionalXP = 75;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 2) {
				this.long = "You're currently fighting earth elemental. It's four and half feet tall, it body covered with earth and it's using bare fists to fight.";
				this.tallness = 54;
				initStrTouSpeInte(14, 44, 44, 60);
				initWisLibSensCor(60, 10, 30, 50);
				this.weaponAttack = 9;
				this.armorDef = 20;
				this.armorMDef = 40;
				this.level = 18;
				this.bonusHP = 700;
				this.additionalXP = 100;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 3) {
				this.long = "You're currently fighting earth elemental. It's four feet and nine iches tall, it body covered with earth and it's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 46, 46, 70);
				initWisLibSensCor(70, 10, 35, 50);
				this.weaponAttack = 11;
				this.armorDef = 25;
				this.armorMDef = 45;
				this.level = 21;
				this.bonusHP = 800;
				this.additionalXP = 125;
			}
			else if (flags[kFLAGS.RIVER_DUNGEON_ELEMENTAL_MIXER] == 4) {//river dungeon floor 2 subboss
				this.long = "You're currently fighting earth elemental. It's five feet tall, it body covered with earth and it's using bare fists to fight.";
				this.tallness = 57;
				initStrTouSpeInte(16, 46, 46, 70);
				initWisLibSensCor(70, 10, 35, 50);
				this.weaponAttack = 11;
				this.armorDef = 25;
				this.armorMDef = 45;
				this.level = 24;
				this.bonusHP = 800;
				this.additionalXP = 125;
			}
			this.a = "the ";
			this.short = "earth elemental";
			this.imageName = "earth elemental";
			this.plural = false;
			this.lustVuln = 0;
			this.drop = new ChainedDrop()
					.add(useables.ELSHARD, 1);
			this.createBreastRow(0, 1);
			initGenderless();
			this.weaponName = "fists";
			this.weaponVerb = "smash";
			this.armorName = "earth skin";
			this.createPerk(PerkLib.EnemyElementalType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}