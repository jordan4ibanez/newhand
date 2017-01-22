minetest.register_node("newhand:hand", {
	description = "",
	tiles = {"character.png"},
	on_place = function(itemstack, placer, pointed_thing)
		--do nothing
	end,
	visual_scale = 1,
	wield_scale = {x=1,y=1,z=1},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "hand.b3d",
	node_placement_prediction = "",
})

minetest.register_on_joinplayer(function(player)
	player:get_inventory():set_stack("hand", 1, "newhand:hand")
end)


