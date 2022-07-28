local voiceRadius = 50
local istalking = false
local voicechatkey = 50 -- change this to your server's voicechat key
local voiceToggled = false
local UIHidden = false
local UIRadar = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if(voicechatkey) then
            istalking = true
        else
            istalking = false
        end
    end
end)

--Cricle Radar
Citizen.CreateThread(
    function()
        Citizen.Wait(Config.StatusUpdateInterval)
        SendNUIMessage(
            {
                type = "Init",
                healthIcon = Config.HealthIcon,
                armorIcon = Config.ArmorIcon,
                foodIcon = Config.FoodIcon,
                thirstIcon = Config.ThirstIcon,
                fourthIcon = Config.FourthIcon,
                showid = Config.DisplayId,
                showstress = Config.DisplayStress,
                showvoice = Config.DisplayVoice
            }
        )

        while true do
            Citizen.Wait(0)


            if Config.DisplayVoice then
              local netTalk = istalking 
                
                if netTalk  ~= voiceToggled then
              
                SendNUIMessage(
                    {
                        type = "toggleTalking",
                        talking = netTalk
                    }
                )
                voiceToggled = netTalk
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(Config.StatusUpdateInterval)

            GetStatus(
                function(result)
                    hunger = result[1]
                    thirst = result[2]
                    stress = result[3]
                end
            )
        end
    end
)
GetPlayerServerId = function()
	for j=0,31,1 do
		if(IsNetworkPlayerActive(j)) then
			if(GetPlayerChar(GetPlayerId()) == GetPlayerChar(j)) then
				return j
			end
		end
	end
end
Citizen.CreateThread(
    function()
        while true do

            Citizen.Wait(Config.VitalsUpdateInterval)
            
            local ped = GetPlayerChar(-1)
            local vehicle = GetCarCharIsUsing(ped)
            local health = GetCharHealth(ped) - 100
            local armor = GetCharArmour(ped)
            local serverid = GetPlayerServerId(GetPlayerId())
            local pauseMenu = IsPauseMenuActive()

            SendNUIMessage(
                {
                    type = "changeStatus",
                    health = health,
                    armor = armor,
                    food = hunger,
                    thirst = thirst,
                    id = serverid,
                    stress = stress,
                    voice = voiceRadius
                }
            )

           if pauseMenu and not UIHidden then
                 SendNUIMessage(
                        {
                            type = "hideUI"
                        }
                    )
                 UIHidden = true
            elseif UIHidden and not pauseMenu then
                 SendNUIMessage(
                        {
                            type = "showUI"
                        }
                    )
                UIHidden = false
            end

            if not Config.AlwaysDisplayRadar then
                if vehicle ~= 0 and UIRadar then
                    SendNUIMessage(
                        {
                            type = "openMapUI"
                        }
                    )
                    DisplayRadar(true)
                    UIRadar = false
                elseif not UIRadar and vehicle == 0 then
                    SendNUIMessage(
                        {
                            type = "closeMapUI"
                        }
                    )
                    UIRadar = true
                    DisplayRadar(false)
                end
            else
                DisplayRadar(true)
            end

            
        end
    end
)
