class AbilityEnergyLeech extends RPGAbility;

function AdjustTargetDamage(out int Damage, int OriginalDamage, Pawn Injured, Pawn InstigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
	local float AdrenalineBonus;

	if(
		Damage <= 0 ||
		InstigatedBy == Injured ||
		InstigatedBy.Controller.SameTeamAs(Injured.Controller) ||
		InstigatedBy.Controller.Adrenaline >= InstigatedBy.Controller.AdrenalineMax ||
		InstigatedBy.InCurrentCombo() ||
		HasActiveArtifact(InstigatedBy)
	)
	{
		return;
	}
	
	AdrenalineBonus = float(Min(Damage, Injured.Health)) * BonusPerLevel * AbilityLevel;

	InstigatedBy.Controller.Adrenaline =
		FMin(InstigatedBy.Controller.Adrenaline + AdrenalineBonus, InstigatedBy.Controller.AdrenalineMax);

	if(
		InstigatedBy.Controller.IsA('UnrealPlayer') &&
		InstigatedBy.Controller.Adrenaline >= InstigatedBy.Controller.AdrenalineMax
	)
	{
		UnrealPlayer(InstigatedBy.Controller).ClientDelayedAnnouncementNamed('Adrenalin', 15);
	}
}

static function bool HasActiveArtifact(Pawn Instigator)
{
	return class'RPGArtifact'.static.HasActiveArtifact(Instigator);
}

simulated function string DescriptionText()
{
	return repl(Super.DescriptionText(), "$1", class'Util'.static.FormatPercent(BonusPerLevel));
}

defaultproperties
{
	AbilityName="Energy Leech"
	Description="Whenever you deal damage to another player, you gain $1 of the damage per level as adrenaline."
	StartingCost=5
	CostAddPerLevel=5
	MaxLevel=5
	ForbiddenAbilities(0)=(AbilityClass=class'AbilityVampire',Level=1)
	BonusPerLevel=0.010000
	Category=class'AbilityCategory_Adrenaline'
}
