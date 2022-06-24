# newhand
a mod which makes the hand 3d in minetest


# API
Any player skin mod can integrate the hand using this API
- newhand.register_hand(hand, texture)
  - name - Hand (node) name. Should match mod:name_xyz
  - texture - skin texture

- newhand.set_hand(player, hand)
  - player - Player object
  - hand - Hand (node) name
