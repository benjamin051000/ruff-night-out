extends Node

@warning_ignore("unused_signal")
signal new_guest_spawned(guest)

## accepted == true -> entering the club
## accepted == false -> kicked out of line
@warning_ignore("unused_signal")
signal guest_left_queue(accepted: bool)

@warning_ignore("unused_signal")
signal guest_ready_for_minigame(guest)

@warning_ignore("unused_signal")
signal minigame_started(name)

# Speech bubbles
@warning_ignore("unused_signal")
signal bouncer_bubble(text: String)
@warning_ignore("unused_signal")
signal guest_bubble(text: String)

@warning_ignore("unused_signal")
signal start_endgame

## The total number of guests to spawn.
const NUM_GUESTS := 10
const FAKE_RATE := 0.4

## Must get at least this % to win
const WIN_CUTOFF := 0.5

const music_bpm := 124.0
const beat_interval := 60.0 / music_bpm
