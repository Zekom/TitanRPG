class AbilitySmartHealing extends RPGAbility;

function bool OverridePickupQuery(Pawn Other, Pickup item, out byte bAllowPickup)
{
	local int HealMax;

	if(TournamentHealth(item) != None)
	{
		HealMax = TournamentHealth(item).GetHealMax(Other);
		if(Other.Health + TournamentHealth(item).HealingAmount < HealMax)
		{
			Other.GiveHealth(int(float(TournamentHealth(item).HealingAmount) * BonusPerLevel * AbilityLevel), HealMax);
			bAllowPickup = 1;
			return true;
		}
	}

	return false;
}

simulated function string DescriptionText()
{
	return repl(Super.DescriptionText(), "$1", class'Util'.static.FormatPercent(BonusPerLevel));
}

defaultproperties
{
	AbilityName="Smart Healing"
	Description="Causes healing items to heal you $1 more per level."
	StartingCost=10
	CostAddPerLevel=0
	MaxLevel=4
	BonusPerLevel=0.250000
	RequiredAbilities(0)=(AbilityClass=class'AbilityAmmoMax',Level=5)
	RequiredAbilities(1)=(AbilityClass=class'AbilityHealthBonus',Level=3)
	Category=class'AbilityCategory_Health'
}
