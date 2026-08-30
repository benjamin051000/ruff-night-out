extends Node

@warning_ignore("unused_signal")
signal new_guest_spawned(guest)

## accepted == true -> entering the club
## accepted == false -> kicked out of line
@warning_ignore("unused_signal")
signal guest_left_queue(accepted: bool)

@warning_ignore("unused_signal")
signal guest_ready_for_minigame(guest)

## The total number of guests to spawn.
const NUM_GUESTS := 20

const music_bpm := 124.0
const beat_interval := 60.0 / music_bpm
