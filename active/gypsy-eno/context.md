# Gypsy Eno

## Concept

Bittersweet, wistful, romantic. Eastern European accordion feel meets Eno-esque fuzz guitar texture. Not a genre exercise — personal music that draws from multiple traditions without trying to reproduce any of them. "I want to be true to me more than try to reproduce the irreproducible."

The piece should feel pulled in multiple directions — but in a good way. Three voices from different worlds held in the same space.

This piece also serves as a demonstration of the Duet NLA system. Option B was chosen over Option A partly because the conversation that produced it better showcases the collaborative process — the AI having opinions, pushing back, self-correcting, and the human shaping the piece's identity.

## Sound Engine

SuperCollider

## Decisions

### Instrumentation

- **Accordion-synth** (melody): Additive synthesis with vibrato, breathy quality. Evokes an accordion without imitating one — "clearly a synth but conjures feelings of." Dry, present in the mix. Center-panned.
- **Fuzz guitar** (texture): Long sustained tones, slow bends, heavy reverb. Not a counter-melody — texture and atmosphere. The Eno/Another Green World element. Diffused, spacious. Panned slightly right.
- **Bowed bass** (anchor): DWGBowed physical modeling. Glacial movement, root notes. Clean and warm. Bow pressure as expressive parameter — builds through the progression, relaxes at resolution. Panned slightly left.

### Meter and Tempo

- 7/8 grouped as 3+2+2
- Quarter note = 95 BPM
- Faster than initially planned (~70) because 7/8 needs enough speed to feel like a groove, not like rubato. Arrived at this through discussion — wistful doesn't have to mean slow.

### Harmony

- A natural minor with G# only at the V chord (harmonic minor color reserved for one moment per cycle)
- Progression: Am → Bm → C → Dm → E → Am, one chord per bar, six bars per cycle
- Softened from full harmonic minor harmonization (Bdim, Caug felt intellectual rather than musical)
- The single bright E major chord is the "moment" — one flash of major in a minor landscape
- The Bm chord introduces a subtle F# (Dorian borrowing), adding Eastern European color without disruption

### Melody

- Composed (not generative) — specific phrases to react to, can loosen up in iteration
- Three notes per measure following the 3+2+2 grouping (dotted quarter, quarter, quarter)
- Arc: descend → descend → rise → fall → bright moment (G#) → resolve home
- The G# in measure 5 is THE moment — brief brightness before the fall back to Am

### Aesthetic

- The fuzz guitar is the personal element that prevents pastiche
- Three voices from different worlds (Eastern European folk, art-rock, chamber music) held together by the bass
- The guitar doesn't follow the harmony — it coexists with it, creating friction and alignment by accident
- "Pulled in multiple directions — but in a good way"

## Rejected

- **Option A** (FM bell/Rhodes, 3/4, ambient, ~69 BPM): Too safe, less distinctive. Good idea, less compelling for demonstrating the system. Pinned as a possibility but not chosen.
- **Intra-measure chord changes** (chords changing on 3+2+2 beat groups within a measure): Elegant on paper, over-designed in practice. At moderate tempo the dissonant chords don't "flash by" as intended — they sit. The AI flagged this in self-critique.
- **Guitar as chromatic counter-melody**: User described texture ("long notes fading and sliding"), AI inflated it into an active melodic role. Corrected back to texture after honest reassessment.
- **Starting with two voices only**: User pushed back — the guitar is identity, not decoration. All three voices from the start.
- **Full harmonic minor harmonization** (Bdim, Caug as passing chords): Felt like an intellectual exercise rather than music. User: "softening the chords feels more like music and less like an intellectual exercise."
- **Slow tempo (~70 BPM) in 7/8**: 7/8 needs enough speed to groove. At very slow tempos, the odd meter stops being felt and becomes rubato. Pushed tempo up to quarter = 95.

## References

- **Eno's "Another Green World"** — atmospheric, textural, art-rock. The guitar's role model.
- **Piazzolla** — the accordion/bowed bass connection, bittersweet tango. The emotional ancestor.
- **Balkan folk** — the 7/8 feel, modal quality, the ache in the augmented second.
- Not trying to reproduce any of these — drawing from them personally.

## Listening Notes

*To be updated after each iteration. This is the most valuable section — the human's ears are the ground truth.*

## Unresolved

- How much rosin grit on the bowed bass? (bow force parameter)
- Is the guitar's presence level right relative to accordion and bass?
- Should the progression vary on repeats or stay constant?
- Does the melody want to develop across cycles or remain the same?
- Pmono vs Pbind for bass/guitar — continuous sound vs retriggered notes?

## Iteration History

- **v01**: Initial sketch. Three voices, six-bar progression, composed melody.
