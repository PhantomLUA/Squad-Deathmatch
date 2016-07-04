surface.CreateFont( "Ammo", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 40,
	weight = 750,
	blursize = 0.05,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )
surface.CreateFont( "Name", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 30,
	weight = 500,
	blursize = 0.05,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )


function SHUD()
	local client = LocalPlayer()

	if !client:Alive() then
		return
	end

	draw.RoundedBox(4, 50, ScrH() - 65, 275, 50, Color(40, 40, 40, 175))
	draw.RoundedBox(4, ScrW() - 193.5, ScrH() - 64, 145, 50, Color(40, 40, 40, 175))

for k,v in pairs(ents.FindInSphere(LocalPlayer():GetPos(),2048)) do
	if v:GetClass() == "npc_grenade_frag" or v:GetClass() == "fas2_thrown_m67" or v:GetClass() == "fas2_m67" or v:GetClass() == "cw_grenade_thrown" then
	local Frag = Material("icons/grenade.png")
	surface.SetMaterial(Frag)
	surface.SetDrawColor(255,255,255,165)
	surface.DrawTexturedRectRotated( v:GetPos():ToScreen().x, v:GetPos():ToScreen().y - 15, 38/2, 42/2, 0 )
	end
end
	if(client:GetActiveWeapon():IsValid()) then
			if 	client:GetActiveWeapon():Clip1() >= 100  then draw.SimpleText(client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 155, ScrH() - 60, Color(85,85,85,85)) elseif
				(client:GetActiveWeapon():Clip1() >= 10 and client:GetActiveWeapon():Clip1()< 100) then draw.SimpleText("0"..client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 155, ScrH() - 60, Color(85,85,85,85)) else
					draw.SimpleText("00"..client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 155, ScrH() - 60, Color(85,85,85,85)) end
		if 	client:GetActiveWeapon():Clip1() >= 100 then draw.SimpleText(client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 145, ScrH() - 55, Color(255,255,255,95)) else
			draw.SimpleText(client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 125, ScrH() - 55, Color(255,255,255,95)) end
			draw.SimpleText("/"..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Name", ScrW() - 85, ScrH() - 60, Color(255,255,255,95))
		else
			if (client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) <= 0) then
		draw.SimpleText("- - -", "Ammo", ScrW() - 160, ScrH() - 65, Color(85,85,85,85))	elseif
			client:GetActiveWeapon():Clip1() <= 100  then draw.SimpleText(client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 155, ScrH() - 60, Color(85,85,85,85)) else
				draw.SimpleText("0"..client:GetActiveWeapon():Clip1(), "Ammo", ScrW() - 155, ScrH() - 60, Color(85,85,85,85)) end
			draw.SimpleText("- - -", "Ammo", ScrW() - 145, ScrH() - 60, Color(255,255,255,95))
		if (client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) <= 0) then
		draw.SimpleText("/---", "Name", ScrW() - 85, ScrH() - 60, Color(255,255,255,95)) else
			draw.SimpleText("/"..client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Name", ScrW() - 85, ScrH() - 60, Color(255,255,255,95))
		end
	end
end
hook.Add("HUDPaint", "TestHud", SHUD)



function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)
