-- Define modifier key
local mainMod = "SUPER"

-- Dynamic Zoom Function
local function adjust_zoom(operation)
	-- Fetch current factor or default to 1.0
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	local new_zoom = 1.0

	if operation == "in" then
		new_zoom = current * 1.1 -- Multiplies zoom for smoother increments
	elseif operation == "out" then
		new_zoom = current / 1.1
		if new_zoom < 1.0 then
			new_zoom = 1.0 -- Prevents breaking the layout boundaries
		end
	elseif operation == "reset" then
		new_zoom = 1.0
	end

	-- Apply the new configuration state dynamically
	hl.config({
		cursor = {
			zoom_factor = new_zoom,
		},
	})
end
