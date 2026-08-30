extends Node2D
var dialogue := [
	[
		"Hey, uh, I just wanted to let you know that the last guy said you smelled a bit like updog.",
		["What's updog?", "Exactly."],  # Real
		["*Sniff, sniff* “No I don’t! >:(", "Then I s’pose you ain’t dog enough for this joint. Be seein’ ya."]  # Fake
	],
	[
		"So, what kind of music are you into?",
		["Ever heard of K.K. Slider or Three Dog Night?", "Right answer, homedog."],
		["I’m a bit of a jazz cat myself.", "A jazz what now??"]
	],
	[
		"You got a favorite Looney Toons character?",
		["Well I’m kind-of biased because my uncle is Wile E. Coyote.", "Haha, no way! Please, come on in. Drinks are on me once I go on break."],
		["Easy answer: Sylvester J. Pussycat Sr.", "...woof. No dog in their right mind would know that cat’s full name."]
	],
	[
		"I heard some folks are squirrelin’ their way into the line back there. That true?",
		["DID YOU SAY SQUIRREL?", "Sure did, pal. Head on in."],
		["Um… I dunno, I wasn’t really paying attention. I was kinda on my phone.", "What’s a phone?"],
	],
	[
		"Just one question: Who’s a good boy?",
		[":D <3 *wags tail*", "Now get on in there."],
		["Oh I don’t know… you are?", "Heh. Good one. Flattery won’t get you in here though, human."],
	],
	[
		"Boy do I have a bone to pick with some of these patrons.",
		["Bone?? I love bones!", "Guess you’re one of the good ones."],
		["I don’t even like bones so hopefully you don’t have one to pick with me.", "*Sigh* Well I do now…"],
	],
	[
		"I must say your outfit looks absolutely fetching!",
		["Thanks! I fetched it myself!", "That’s all I need to hear, get on in there!"],
		["Thanks! I bought it today at the store :)", "Oh… hm…"],
	],
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.bouncer_bubble.emit
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
