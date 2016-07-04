function GM:PlayerDisconnected(ply)
	ply:SetPData("playerLvl", ply:GetNWInt("playerLvl"))
	ply:SetPData("playerXp", ply:GetNWInt("playerXp"))
	ply:SetPData("playerMoney", ply:GetNWInt("playerMoney"))
	ply:SetPData("playerMaterials", ply:GetNWInt("playerMaterials"))
end

function GM:ShutDown()
	for k,v in pairs(player.GetAll()) do
		v:SetPData("playerLvl",v:GetNWInt("playerLvl"))
		v:SetPData("playerXp",v:GetNWInt("playerXp"))
		v:SetPData("playerMoney",v:GetNWInt("playerMoney"))
		v:SetPData("playerMaterials",v:GetNWInt("playerMaterials"))
	end
end
