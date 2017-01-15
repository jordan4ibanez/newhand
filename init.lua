minetest.register_node("newhand:hand", {
	description = "",
	tiles = {"character.png"},--^[transformR180"},
	on_place = function(itemstack, placer, pointed_thing)
		--do nothing
	end,
	visual_scale = 0.25,
	wield_scale = {x=0.25,y=0.25,z=0.25},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "hand.x",
	node_placement_prediction = false,
})

minetest.register_on_joinplayer(function(player)
	player:get_inventory():set_stack("hand", 1, "newhand:hand")
end)


