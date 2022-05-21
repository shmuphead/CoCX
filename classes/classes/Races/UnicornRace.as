package classes.Races {
import classes.BodyData;
import classes.BodyParts.*;
import classes.CockTypesEnum;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.Race;
import classes.VaginaClass;
import classes.internals.Utils;

public class UnicornRace extends Race{
	public static const BicornFurColors:/*String*/Array  = ["silver", "black", "midnight black", "midnight"];
	public static const BicornHairColors:/*String*/Array = ["silver","black", "midnight black", "midnight"];
	public static const UnicornFurColors:/*String*/Array  = ["white", "pure white"];
	public static const UnicornHairColors:/*String*/Array = ["platinum blonde","silver", "white", "pure white"];
	
	public function UnicornRace(id:int) {
		super("Unicorn", id);
	}
	
	public override function setup():void {
		
		addScores()
				.faceType(Face.HUMAN, +1, -1000)
				.earType(Ears.HORSE, +1)
				.tailType(Tail.HORSE, +1)
				.isTaur(+1)
				.legType(LowerBody.HOOFED, +1)
				.eyeType(Eyes.HUMAN, +1)
				.hornType(ANY(Horns.UNICORN, Horns.BICORN), 0, -1000)
				
				.wingType(NONE(Wings.FEATHERED_ALICORN,Wings.NIGHTMARE), 0, -1000)
				.noWings(+4)
				
				.skinPlainOnly(+1)
				.hasCockOfType(CockTypesEnum.HORSE, +1)
				.vaginaType(VaginaClass.EQUINE, +1)
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Unicorn branch - size 1-5 unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Unicorn branch - size 6+ unicorn horn")
				.hornTypeAndCount(Horns.UNICORN, LESS_THAN(6), +1, 0, "Bicorn branch - size 1-5 bicorn horns")
				.hornTypeAndCount(Horns.UNICORN, AT_LEAST(6), +2, 0, "Bicorn branch - size 6+ bicorn horns")
				.customRequirement("",
						"Wings match horns",
						function (body:BodyData):Boolean {
							if (body.hornType == Horns.UNICORN) return body.wingType == Wings.FEATHERED_ALICORN;
							if (body.hornType == Horns.BICORN) return body.wingType == Wings.NIGHTMARE;
							return true;
						}, 0, -1000);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.UNICORN;
				}, "Unicorn branch;")
				.customRequirement(
						"",
						"hair color: "+UnicornHairColors.join("/")+
						"; coat color: "+UnicornFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, UnicornHairColors) &&
									Utils.InCollection(body.skinCoatColor, UnicornFurColors)
						},
						+1)
				.eyeColor("blue", +1)
				.hasPerk(PerkLib.AvatorOfPurity, +1);
		addConditionedScores(
				function(body:BodyData):Boolean {
					return body.hornType == Horns.BICORN;
				}, "Bicorn branch;")
				.customRequirement(
						"",
						"hair color: "+BicornHairColors.join("/")+
						"; coat color: "+BicornFurColors.join("/"),
						function (body:BodyData):Boolean {
							return Utils.InCollection(body.hairColor, BicornHairColors) &&
									Utils.InCollection(body.skinCoatColor, BicornFurColors)
						},
						+1)
				.eyeColor("red", +1)
				.hasPerk(PerkLib.AvatorOfCorruption, +1);
		
		addMutation(IMutationsLib.TwinHeartIM, +2);
		addMutation(IMutationsLib.EclipticMindIM, +1);
		
		buildTier(8, "Half Unicorn/Bicorn")
				.customNamingFunction(function(body:BodyData):String {
					if (body.hornType == Horns.UNICORN) return "half unicorn";
					return "half bicorn";
				})
				.buffs({
					"tou.mult": +0.25,
					"spe.mult": +0.40,
					"int.mult": +0.55
				})
				.end()
		
		buildTier(18, "Unicorn/Bicorn")
				.customNamingFunction(function(body:BodyData):String {
					if (body.hornType == Horns.UNICORN) return "unicorn";
					return "bicorn";
				})
				.buffs({
					"tou.mult": +0.55,
					"spe.mult": +0.90,
					"int.mult": +1.25,
					"maxsf_mult": +0.10,
					"maxhp_base": +250,
					"maxfatigue_base": +20
				})
				.withExtraBonuses([
						"Mana & SF recovery +5%",
						"Combat HP regen +150",
						"Regenerate Spell +200%"
				])
				.end()
		
		buildTier(27, "True Unicorn/Bicorn")
				.customNamingFunction(function(body:BodyData):String {
					if (body.hornType == Horns.UNICORN) return "true unicorn";
					return "true bicorn";
				})
				.buffs({
					"str.mult": +0.60,
					"tou.mult": +0.90,
					"spe.mult": +1.15,
					"int.mult": +1.40,
					"maxsf_mult": +0.10,
					"maxhp_base": +250,
					"maxfatigue_base": +20
				})
				.withExtraBonuses([
					"Mana & SF recovery +5%",
					"Combat HP regen +150",
					"Regenerate Spell +200%"
				])
				.end()
	}
}
}
