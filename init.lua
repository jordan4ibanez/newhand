--print(dump(skins.list))

local simple_skins = minetest.get_modpath("simple_skins") ~= nil



--simple skins is enabled
if simple_skins == true then
	newhand_oldskin = {}
	--generate a node for every skin
	for _,texture in pairs(skins.list) do
		minetest.register_node("newhand:"..texture, {
			description = "",
			tiles = {texture..".png"},
			inventory_image = "newhand_inv.png",
			on_place = function(itemstack, placer, pointed_thing)
				if minetest.get_node(pointed_thing.under).name == "default:chest_locked" then
					minetest.item_place(itemstack, placer, pointed_thing, param2)
				end
			end,
			visual_scale = 1,
			wield_scale = {x=1,y=1,z=1},
			paramtype = "light",
			drawtype = "mesh",
			mesh = "hand.b3d",
			node_placement_prediction = "",
		})
	end
	--change the player's hand to their skin
	minetest.register_on_joinplayer(function(player)
		local skin = skins.skins[player:get_player_name()]
		player:get_inventory():set_size("hand", 1)
		player:get_inventory():set_stack("hand", 1, "newhand:"..skin)
	end)
	
	--check to update the skin
	minetest.register_globalstep(function(dtime)
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local skin = skins.skins[name]
			
			if skin ~= newhand_oldskin[name] then
                          player:get_inventory():set_size("hand", 1)
                          player:get_inventory():set_stack("hand", 1, "newhand:"..skin)
			end
			
			newhand_oldskin[name] = skin
		end
	end)
	
--do default skin if no skin mod installed
else
	minetest.register_node("newhand:hand", {
		description = "",
		tiles = {"character.png"},
		inventory_image = "newhand_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if minetest.get_node(pointed_thing.under).name == "default:chest_locked" then
				minetest.item_place(itemstack, placer, pointed_thing, param2)
			end
		end,
		visual_scale = 1,
		wield_scale = {x=1,y=1,z=1},
		paramtype = "light",
		drawtype = "mesh",
		mesh = "hand.b3d",
		node_placement_prediction = "",
	})

	minetest.register_on_joinplayer(function(player)
		player:get_inventory():set_size("hand", 1)
		player:get_inventory():set_stack("hand", 1, "newhand:hand")
	end)
end
