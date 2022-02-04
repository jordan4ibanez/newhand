newhand = {}

function newhand.register_hand(name, texture)
	minetest.register_node(name, {
		description = "",
		tiles = {texture},
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
		use_texture_alpha = "clip"
	})
end

local oldhand = {}

function newhand.set_hand(player, hand)
	local name = player:get_player_name()
	if hand ~= oldhand[name] then
		if hand and minetest.registered_nodes[hand] then
			player:get_inventory():set_size("hand", 1)
			player:get_inventory():set_stack("hand", 1, hand)
		else
			player:get_inventory():set_size("hand", 0)
		end
	end
	oldhand[name] = hand
end

--simple skins is enabled
if minetest.get_modpath("simple_skins") then
	--generate a node for every skin
	for _,texture in pairs(skins.list) do
		newhand.register_hand("newhand:"..texture, texture..".png")
	end

	--change the player's hand to their skin
	minetest.register_on_joinplayer(function(player)
		local skin = skins.skins[player:get_player_name()]
		player:get_inventory():set_stack("hand", 1, "newhand:"..skin)
	end)

	--check to update the skin
	minetest.register_globalstep(function(dtime)
		for _,player in ipairs(minetest.get_connected_players()) do
			local skin = skins.skins[player:get_player_name()]
			newhand.set_hand(player, "newhand:"..skin)
		end
	end)

--do default skin if no skin mod installed
else
	newhand.register_hand("newhand:hand", "character.png")
	minetest.register_on_joinplayer(function(player)
		newhand.set_hand(player, "newhand:hand")
	end)
end
