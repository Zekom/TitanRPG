class WeaponModifier_Nullification extends RPGWeaponModifier;
	
var localized string MagicNullText;

function bool AllowEffect(class<RPGEffect> EffectClass, Controller Causer, float Duration, float Modifier)
{
	if(
		EffectClass == class'Effect_Freeze' ||
		EffectClass == class'Effect_Knockback' ||
		EffectClass == class'Effect_NullEntropy' ||
		EffectClass == class'Effect_Poison' ||
		EffectClass == class'Effect_Vorpal'
	)
	{
		Identify();
		return false;
	}
	
	return true;
}

simulated function BuildDescription()
{
	Super.BuildDescription();
	AddToDescription(MagicNullText);
}

defaultproperties
{
	MagicNullText="nullifies harmful effects"
	bCanHaveZeroModifier=True
	DamageBonus=0.050000
	MinModifier=4
	MaxModifier=6
	ModifierOverlay=Shader'AW-2k4XP.Weapons.ShockShieldShader'
	PatternPos="Nullifying $W"
	//AI
	//CountersModifier(0)=class'WeaponFreeze'
	//CountersModifier(1)=class'WeaponNullEntropy'
	//CountersModifier(2)=class'WeaponPoison'
	//CountersModifier(3)=class'WeaponKnockback'
	AIRatingBonus=0.025000
}