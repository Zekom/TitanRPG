class WeaponModifier_Medic extends WeaponModifier_Heal;

function WeaponFire(byte Mode)
{
	Identify();
}

function RPGTick(float dt)
{
	//TODO: Find a way for ballistic weapons
	Weapon.MaxOutAmmo();
}

function int GetMaxHealthBonus()
{
	local RPGPlayerReplicationInfo RPRI;
	local Ability_LoadedMedic LM;

	RPRI = class'RPGPlayerReplicationInfo'.static.GetFor(Instigator.Controller);
	if(RPRI != None)
	{
		LM = Ability_LoadedMedic(RPRI.GetOwnedAbility(class'Ability_LoadedMedic'));
		if(LM != None)
			return LM.GetHealMax();
	}
	
	return Super.GetMaxHealthBonus();
}

simulated function BuildDescription()
{
	Super.BuildDescription();
	AddToDescription(class'WeaponModifier_Infinity'.default.InfAmmoText);
}

defaultproperties
{
	HealText="$1 enhanced healing"
	bOmitModifierInName=True

	bAllowForSpecials=False
	bCanThrow=False

	MinModifier=5
	MaxModifier=5
	AIRatingBonus=0.100000
	PatternPos="Medic $W of Infinity"
}