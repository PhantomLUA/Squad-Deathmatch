function GM:RenderScreenspaceEffects()
	if LocalPlayer():Health() <= 35 then
	DrawMotionBlur( 0.4, 0.8, 0.01 )
	end
end
