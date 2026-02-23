xpcall(function()
print("o")

local Modules = {
    Colors =  {
        ["Green"] = "0,255,0", -- color in rgb
        ["Cyan"] = "33, 161, 163"
    }
}

Modules.ChangeColor = function() 
    game:GetService("RunService").Heartbeat:Connect(function()
    	if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster") then 
	        for _, v in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 
	            if v:IsA("TextLabel") then 
	                v.RichText = true 
	            end 
	        end 
	    end
    end)
end

Modules.print = function(color, text, size)
	if not Modules.Colors[color] then 
		warn("Color was not found!")
		return 
	end 
	
	
    local Text = '<font color="rgb(' .. Modules.Colors[color] .. ')"'
    if size then
        Text = Text .. ' size="' .. tostring(size) .. '"'
    end
    Text = Text .. '>' .. tostring(text) .. '</font>'
    print(Text)
end


Modules.ChangeColor()

_G.excludetable = {}
local namecall = nil
namecall = hookmetamethod(game, "__namecall", newcclosure(function(caller, ...)
	local method = getnamecallmethod()
	local args = {...}
	if method == "InvokeServer" or method == "FireServer" or method == "Invoke" then
		if not table.find(_G.excludetable, caller.Name) then
		local debugid = nil
		coroutine.wrap(function()
			setthreadidentity(8)
		    debugid = caller:GetDebugId()
		end)()
		if getcallingscript() then Modules.print("Cyan", "from: "..tostring(getcallingscript()).." --") end
		Modules.print("Cyan", caller.Name.." / "..debugid.." -- "..tostring(method))
		for i,v in args do
			if type(v) == "table" then
				Modules.print("Green", tostring(v).." -- "..type(v))
				Modules.print("Green", "{")
				for z,b in v do
					if type(b) == "table" then
						Modules.print("Green", "   "..tostring(b).." -- "..type(b))
						Modules.print("Green", "   {")
						for z,n in b do
							Modules.print("Green", "      "..tostring(n)..", -- "..type(n))
						end
						Modules.print("Green", "   },")
					else
						Modules.print("Green", "   "..tostring(b)..", -- "..type(b))
					end
				end
				Modules.print("Green", "},")
			elseif tostring(typeof(v)) == "Instance" then
				Modules.print("Green", tostring(v.Parent.Name).."."..tostring(v.Name).." -- "..tostring(typeof(v)))
			elseif type(v) == "string" then
				Modules.print("Green", tostring(v).." / "..crypt.base64encode(tostring(v)).." -- "..type(v))
			else
				Modules.print("Green", tostring(v).." -- "..tostring(typeof(v)))
			end
		end
		end
	end
	return namecall(caller,...)
end))
print("wa")
end,function(err)
	warn(err)
end)
