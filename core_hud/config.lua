Config = {

AlwaysDisplayRadar = true, -- Radar will be turned off when not in a vehicle

--Forth Pill function
DisplayId = true, -- Forth pill displays users id
DisplayStress = false, -- Forth pill displays users stress (You need to get the stress value yourself in the script)
DisplayVoice = false, -- Forth pill will display voice range and when speaking 


StatusUpdateInterval = 1000, -- Time it takes for status to update (lowering this value adds ms)
VitalsUpdateInterval = 500, -- Time it takes for vitals to update (lowering this value adds ms)

-- Choose icons from FontAwsome (https://fontawesome.com/) 
HealthIcon = "fa-heartbeat",
ArmorIcon = "fa-shield-alt",
FoodIcon = "fa-hamburger",
ThirstIcon = "fa-tint",
FourthIcon = "", -- Left blank because default function is displaying id (if you use stress or voice add any icon you like)


}
-- Return your hunger, thirst
local food = 0
local water = 0
local stress = 0
function GetStatus(cb)
    hunger = food --Your hunger data here
    thirst = water -- Your thirst data here
    stress = stress -- Your stress data here
    cb({hunger, thirst, stress})
end