#include <sdktools>
#include <tf2_stocks>

public Plugin myinfo = 
{
	name = "Change Class on Kill",
	author = "myst",
	description = "Change to your victim's class when you kill them.",
	version = "1.0",
	url = "https://titan.tf"
}

public void OnPluginStart() {
	HookEvent("player_death", Event_PlayerDeath);
}

public Action Event_PlayerDeath(Handle hEvent, const char[] sEventName, bool bDontBroadcast)
{
	int iVictim = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	int iAttacker = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
	
	int iDeathFlags = GetEventInt(hEvent, "death_flags");
	if (iDeathFlags & 32)
		return Plugin_Handled;
		
	if (IsValidClient(iVictim) && IsValidClient(iAttacker) && iVictim != iAttacker && IsPlayerAlive(iAttacker))
		TF2_SetPlayerClass(iAttacker, TF2_GetPlayerClass(iVictim));
		
	return Plugin_Continue;
}

stock bool IsValidClient(int iClient, bool bReplay = true)
{
	if (iClient <= 0 || iClient > MaxClients || !IsClientInGame(iClient))
		return false;
	if (bReplay && (IsClientSourceTV(iClient) || IsClientReplay(iClient)))
		return false;
	return true;
}