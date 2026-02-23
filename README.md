# usage
if you need to exclude a remote, execute this: ```_G.excludetable = {"RandomSpammyRemote"}```  

this is a `very bad` remotespy I made a while back that I recently gave colors only scans 3 tables deep

# pros:
outputs debugid which makes it so if there's hundreds of identical remotes in name you can tell them apart  
in the console  

# cons:
starts a new thread to call getdebugid  
in the console  

# how to use debugids
this didnt deserve its own repo so im putting this here yay!!!
```lua
for i,v in ipairs(game:GetService("ReplicatedStorage").Communication.Events:GetChildren()) do
	local debugid = nil
	coroutine.wrap(function()
		setthreadidentity(8)
	    debugid = v:GetDebugId()
	end)()
	if debugid == "1_138475" then
		v:FireServer("Noob Dialer")
		print("twang")
	end
	task.wait()
end
```
