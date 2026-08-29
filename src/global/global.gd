extends Node

@warning_ignore("unused_signal")
signal new_guest_spawned(guest)

## accepted == true -> entering the club
## accepted == false -> kicked out of line
@warning_ignore("unused_signal")
signal guest_left_queue(accepted: bool)

## The total number of guests to spawn.
const NUM_GUESTS := 20
