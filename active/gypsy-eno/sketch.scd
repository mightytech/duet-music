// ==========================================
// GYPSY ENO — v01 initial sketch
// Bittersweet, wistful. Accordion meets fuzz guitar meets bowed bass.
// A minor | 7/8 (3+2+2) | quarter = 95 BPM
// Requires: sc3-plugins (DWGBowed)
// Stop: Cmd+. (Mac) or Ctrl+. (Linux/Windows)
// ==========================================

(
s.waitForBoot({

    // ---------- SynthDefs ----------

    // Accordion-synth: reed-like additive synthesis with vibrato and breath
    // The goal isn't a realistic accordion — it's a synth that makes your brain say "accordion"
    SynthDef(\accordion, {
        arg out = 0, freq = 440, amp = 0.15, gate = 1,
            vibRate = 5.5, vibDepth = 4;
        var sig, vibrato, env, breath;

        // Vibrato — like a bellows arm, slightly unsteady
        vibrato = freq + SinOsc.kr(vibRate, 0, vibDepth);

        // Stack harmonics — odd ones stronger, characteristic of reed instruments
        sig = Mix.ar([
            SinOsc.ar(vibrato, 0, 1.0),       // fundamental
            SinOsc.ar(vibrato * 2, 0, 0.5),    // 2nd harmonic
            SinOsc.ar(vibrato * 3, 0, 0.7),    // 3rd — stronger (odd)
            SinOsc.ar(vibrato * 4, 0, 0.25),   // 4th
            SinOsc.ar(vibrato * 5, 0, 0.4),    // 5th — stronger (odd)
        ]) * 0.2;

        // Bellows breath — a whisper of pink noise shaped around the pitch
        breath = BPF.ar(PinkNoise.ar(0.02), vibrato * 1.5, 0.4);
        sig = sig + breath;

        env = EnvGen.kr(Env.asr(0.06, 1, 0.12), gate, doneAction: 2);
        sig = sig * env * amp;
        Out.ar(out, Pan2.ar(sig, 0));
    }).add;

    // Fuzz guitar: sustained, distorted, drifting through reverb
    // Think Eno/Fripp — not a riff, a weather system
    SynthDef(\fuzzGuitar, {
        arg out = 0, freq = 220, amp = 0.08, gate = 1, lagTime = 2.5;
        var sig, env;

        // Portamento — notes bleed slowly into each other
        freq = Lag.kr(freq, lagTime);

        // Two slightly detuned saws for thickness
        sig = Saw.ar(freq) + Saw.ar(freq * 1.003);

        // Soft clipping — warm fuzz, not harsh
        sig = (sig * 6).tanh * 0.5;

        // Tame the highs post-distortion, let the lows breathe
        sig = LPF.ar(sig, freq * 3);

        // Big reverb — this voice lives far away in its own room
        sig = FreeVerb.ar(sig, 0.65, 0.92, 0.25);

        env = EnvGen.kr(Env.asr(2, 1, 4), gate, doneAction: 2);
        sig = sig * env * amp;
        Out.ar(out, Pan2.ar(sig, 0.35));
    }).add;

    // Bowed bass: DWGBowed physical model — bow on string
    // TK [SC-CHECK]: DWGBowed argument order may vary between sc3-plugins versions.
    // If this doesn't compile, check your version's help file for the correct signature.
    SynthDef(\bowedBass, {
        arg out = 0, freq = 55, amp = 0.3, gate = 1,
            force = 0.4, pos = 0.14;
        var sig, env;

        // Physical bow-on-string model
        // pos = bow position on string (closer to bridge = brighter, more overtones)
        sig = DWGBowed.ar(freq, force, pos, 0.5, gate);

        // Roll off highs — keep it warm and round
        sig = LPF.ar(sig, freq * 4);

        env = EnvGen.kr(Env.asr(0.6, 1, 0.9), gate, doneAction: 2);
        sig = sig * env * amp;
        Out.ar(out, Pan2.ar(sig, -0.25));
    }).add;

    s.sync; // wait for SynthDefs to be ready

    // ---------- Composition ----------

    // Quarter note = 95 BPM
    ~tempo = TempoClock(95/60);

    // Progression roots (MIDI): Am -> Bm -> C -> Dm -> E -> Am
    // One chord per measure, six measures per cycle
    ~roots = [45, 47, 48, 50, 52, 45]; // A2 B2 C3 D3 E3 A2
    ~measureDur = 3.5; // one measure of 7/8 in quarter-note beats

    // ----- Accordion: the melody, the soul -----
    // Three notes per measure, following the 3+2+2 grouping
    // A wistful arc that peaks with G# at the E chord, then falls home
    Pbind(
        \instrument, \accordion,
        \midinote, Pseq([
            76, 74, 72,    // Am:  E5 D5 C5 — longing descent from the fifth
            74, 71, 69,    // Bm:  D5 B4 A4 — settling lower, finding ground
            72, 76, 79,    // C:   C5 E5 G5 — rising into light
            77, 74, 69,    // Dm:  F5 D5 A4 — gravity pulls it back down
            76, 80, 76,    // E:   E5 G#5 E5 — the bright moment, the one G#
            81, 76, 69,    // Am:  A5 E5 A4 — home, an octave descent to rest
        ], inf),
        // Dotted quarter + quarter + quarter = 1.5 + 1 + 1 = 3.5 (one 7/8 measure)
        \dur, Pseq([1.5, 1, 1], inf),
        \amp, 0.18,
        \legato, 0.85,
    ).play(~tempo);

    // ----- Bowed bass: the gravity -----
    // One note per measure, roots only
    // Bow pressure builds through the progression, relaxes at resolution
    Pbind(
        \instrument, \bowedBass,
        \midinote, Pseq(~roots, inf),
        \dur, ~measureDur,
        \amp, 0.3,
        // Bow force: gentle at home, pressing harder as tension builds, easing at return
        \force, Pseq([0.3, 0.35, 0.4, 0.45, 0.55, 0.3], inf),
        \legato, 0.95,
    ).play(~tempo);

    // ----- Fuzz guitar: the weather -----
    // One note every two measures, slow portamento slides
    // Not following the harmony — just coexisting with it
    Pbind(
        \instrument, \fuzzGuitar,
        \midinote, Pseq([
            64,  // E4 — floats over Am and Bm, a quiet fifth
            67,  // G4 — drifts over C and Dm, passing through
            68,  // G#4 — catches the E chord's brightness, then rubs against Am
        ], inf),
        \dur, ~measureDur * 2, // two full measures per note
        \amp, 0.07,
        \lagTime, 3,
        \legato, 1.1, // slight overlap so the sound never fully drops
    ).play(~tempo);

});
)
