Config = {}

Config = {

	webhooks = "",

	jeveuxmarker = true, --- true = Oui | false = Non
	jeveuxblips = true, --- true = Oui | false = Non

    ------------
    ESXTrigger = "esx:getSharedObject",
    ------------
}

Marker = {
	Type = 22,
	Color = {R = 127, G = 255, B = 255},
	Size =  {x = 0.3, y = 0.3, z = 0.3},
	DrawDistance = 10,
	DrawInteract = 1.5,
}


Config.baritem = {
    {nom = "Eau", prix = 4, item = "eau"},
    {nom = "Pain", prix = 7, item = "pain"},   
    {nom = "Bière", prix = 5, item = "biere"},   
    {nom = "Whisky", prix = 2, item = "whisky"},   
    {nom = "Vodka", prix = 29, item = "vodka"},   
    {nom = "Rhum", prix = 6, item = "rhum"},  
    {nom = "Saucisson", prix = 4, item = "saucisson"},  
    {nom = "Ice-tea", prix = 5, item = "icetea"},  
    {nom = "Oasis", prix = 7, item = "oasis"},  
    {nom = "Coca-Cola", prix = 4, item = "coca"},  
    {nom = "Mojito", prix = 1, item = "mojito"}
}


Config.pos = {

	echangejeton = {
        position = {x = 1115.70,   y = 219.98,  z = -49.43}
    },

	ascenceur = {
		monter = {x = 935.38, y = 46.86, z = 81.09},
		descendre = {x = 1089.79, y = 206.36, z = -48.99}
	},
	blip = { 
	position = {x = 923.7822, y = 46.3247, z = 81.10634}
    },

	bar = { 
        position = {x = 1110.75, y = 209.42, z = -49.44} 
    },

	showroom = {
		menu = {x = 1094.53, y = 222.78, z = -48.99},
		show1 = {x = 1099.90, y = 219.98, z = -48.74, a = 288.79}

	},

	garage = {
		position = {x = 919.35, y = 40.15, z = 80.89}
	},
}

Config.spawn = {
	spawnvoiture = {
		position = {x = 919.07, y = 46.80, z = 80.76, h = 326.64}
	},
}

