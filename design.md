# Glockenspiel Design Packet

## Project Intent

Build a 25-bar chromatic C5-C7 glockenspiel from the existing workbook design table, with a parallel 10-bar C-major-pentatonic art-fair variant that shares the same aluminum stock, frame jig, and validation discipline. The first build target is a CNC-routed walnut frame carrying 6061-T6 aluminum bars, suspended at the free-free nodes by rubber-grommeted cord through drilled node holes, with stainless support pins and no resonators.

The useful boundary for this packet is "build-ready documentation, not finished CAD or measured tuning data." Native SolidWorks files do not exist yet; the `cad/` folder defines the global-variable and design-table contract Tony can use to build the real model. All published bar lengths are first-pass cut-long targets — actual K varies with heat-treat and stock lot, so every bar should be cut at predicted length plus 0.25 in trim allowance and tuned down to pitch.

## Design Intake

| Field | Value |
| --- | --- |
| Instrument | Glockenspiel / Metallophone |
| Instrument family | Free-free beam idiophone (metal), no arch, no resonator |
| Active build range | C5-C7 chromatic, 25 bars (primary); C-major pentatonic, 10 bars (art-fair variant) |
| Source workbook | `glockenspiel-design-table.xlsx`, sheet `Glockenspiel`, range `A1:L174` |
| Primary material | 6061-T6 Aluminum, workbook K constant `204431` |
| Bar stock | `0.25 in` thick x `1.00 in` wide flat bar |
| Frame | CNC-routed Black Walnut, piano-keyboard layout (naturals front, sharps back) |
| Mounting | Cord through node holes at 22.4% and 77.6% of bar length, rubber grommets, 1/8 in stainless support rod |
| Done-bar reference | `tonykoop/marimba` for free-free node math and validation discipline; tongue-drum README for documentation shape |

## Governing Model

### Bar Pitch (Free-Free Beam, Metal)

Glockenspiel bars are treated as free-free beams in their first flexural mode:

```text
lambda_1 = 4.730
f_1 = (lambda_1^2 / (2*pi*L^2)) * sqrt(E*I/(rho*A))
```

The workbook uses the practical shop form:

```text
f ~= K * t / L^2
L ~= sqrt(K * t / f)
```

where:

- `f` is target frequency in Hz.
- `K` is the metal-specific free-free bar constant in imperial units.
- `t` is bar thickness in inches.
- `L` is bar length in inches.

For the active packet:

```text
material = 6061-T6 Aluminum
K = 204431
t = 0.250 in
w = 1.000 in
```

The K formula derived from the lambda_1 = 4.730 mode shape is:

```text
K_metal = (lambda_1^2 / (2 * pi)) * sqrt(E / (12 * rho)) / 0.0254
```

with `E` in Pa and `rho` in kg/m^3. This is the same formula family used by the marimba for wooden bars; only the material constants change.

Width does NOT affect frequency for a free-free beam in this mode. Width controls volume, sustain envelope, stiffness distribution, and the visual dimension of the bar — not pitch. The workbook's bar-width column is a sourcing convenience, not a tuning lever.

### No Arch, No Resonator

Per workbook row 140 and `references/acoustic-models.md`:

- **No arch undercut.** Glockenspiel bars are short and high-pitched; the dry, bright tone is desired. Arching would lower fundamentals and add manufacturing complexity without improving the instrument's musical role. Marimba/xylophone arch logic does not transfer.
- **No resonator tubes.** Small bars produce an immediate, bell-like attack. Resonator coupling at C5-C7 frequencies would require very short tubes (a few inches at C5, less than 1.5 in at C7) that are mechanically awkward and acoustically marginal.

### Empirical-Correction Discipline

NAF K2 corrections, vessel-flute Helmholtz corrections, and cantilever wood K-constant tables do **not** apply to free-free metal beams. See the "Empirical-correction guard rules" section of `references/acoustic-models.md`. The only honest correction loop here is:

1. Cut each pilot bar (C5, A5, C7) cut-long by 0.25 in.
2. Mount on soft node supports and measure flat-bar Hz.
3. Compute effective K from `K_eff = f * L^2 / t`.
4. If pilot K_eff differs from workbook K by more than 5%, update the K constant in `family-spec.csv` (and the workbook B21 cell) before cutting the remaining bars.
5. Trim to pitch in 0.05 in increments.

This is what makes the workflow honest: predicted lengths are the starting point, measured Hz is the ground truth, and each shop-purchased lot of aluminum re-calibrates K.

### Nodes And Mounting

Free-free node positions are fixed by the mode shape:

```text
node_1 = 0.2242 * L
node_2 = 0.7758 * L
```

Mounting strategy:

- Drill 0.1875 in (3/16 in) holes through the bar at the node positions, perpendicular to the long face.
- Thread 550 paracord (or low-stretch nylon) through the four node holes (two per bar, one cord per row).
- Rest each bar on rubber grommets seated in the walnut frame; the cord captures the bar without compressing the grommets.
- 1/8 in stainless steel rod runs the length of each row through the frame as a backup and travel restraint.

Critical: the rubber grommet durometer dominates sustain. Soft (~Shore 30A) grommets give long sustain; hard (~Shore 70A) grommets damp quickly. Pilot the C5/A5/C7 bars on three durometers before standardizing.

## Material Decision Matrix

The workbook's K library carries five candidate metals. Aluminum is the workbook default and packet primary. Surface the alternatives explicitly so the user can rerun the family-spec for any of them.

| Material | E (GPa) | rho (kg/m^3) | K | Tone Character | Cut Method | Notes |
| --- | ---: | ---: | ---: | --- | --- | --- |
| 6061-T6 Aluminum | 68.9 | 2700 | 204431 | Bright, bell-like, long sustain | Band saw, chop saw | Lightest, easiest to cut, lowest cost. Packet default. |
| Brass C260 | 110 | 8530 | 145325 | Warm, mellow, classic glock tone | Band saw, hacksaw | Heavier, traditional orchestra-bell tone, higher material cost. |
| Steel 1018 | 200 | 7850 | 204267 | Harsh, metallic, very loud | Chop saw, angle grinder | Loud and bright; can be perceived as harsh. K is similar to aluminum because E/rho ratio is similar. |
| 304 Stainless Steel | 193 | 8000 | 198770 | Clean, modern, corrosion-resistant | Chop saw, angle grinder | Outdoor / weather-resistant variant. |
| Phosphor Bronze | 110 | 8860 | 142593 | Rich, warm, excellent sustain | Band saw | Premium tone, highest material cost. |

To rebuild the family-spec for a different metal: replace the K column in `family-spec.csv` and recompute `predicted_length_in = sqrt(K * t / f)`. Width and node positions stay the same.

## Bar Schedule

The full 25-bar chromatic schedule is in `family-spec.csv`. Representative rows for 6061-T6 aluminum at t=0.250, w=1.000:

| Note | MIDI | Target Hz | Length in | Node 1 in | Node 2 in |
| --- | ---: | ---: | ---: | ---: | ---: |
| C5 | 72 | 523.251 | 9.883 | 2.216 | 7.667 |
| A5 | 81 | 880.000 | 7.621 | 1.709 | 5.912 |
| C6 | 84 | 1046.502 | 6.988 | 1.567 | 5.422 |
| A6 | 93 | 1760.000 | 5.389 | 1.208 | 4.181 |
| C7 | 96 | 2093.005 | 4.941 | 1.108 | 3.834 |

The 10-bar pentatonic art-fair variant (C5, D5, E5, G5, A5, C6, D6, E6, G6, A6) is also in `family-spec.csv` under `scale_label = C major pentatonic art-fair`. It shares the same K, t, w defaults and reuses the same frame jig with different drill positions.

## Frame Layout

Piano-keyboard layout. Naturals (C, D, E, F, G, A, B) live in the front row; sharps/flats live in the back row, raised about 0.5 in. From the workbook (cells B107-B110):

```text
total_bar_stock_chromatic = 191.02 in (~16 ft) for 25 bars cut long by 0.5 in each
longest_bar = 9.883 in (C5)
shortest_bar = 4.941 in (C7)
chromatic_frame_length = 25 * (w + 0.25) + 2 = 33.25 in
pentatonic_frame_length = 10 * (w + 0.25) + 2 = 14.50 in
```

Frame depth follows the longest bar plus 1 in margin on each end (about 12 in). Final frame ergonomics (height, mallet reach, accidental row offset, transport handles) are TBD until a full-size mock-up is taped on a bench.

## Striker Hardness

Striker hardness controls the timbre as much as the bar material does. Workbook row 145 lists three options:

| Striker Head | Tone | Use |
| --- | --- | --- |
| Brass | Sharpest attack, bright, percussive | Orchestral / soloist; loud rooms |
| Hard rubber | Balanced bright/warm | Studio / classroom; default for art-fair pentatonic |
| Lexan / Delrin | Bright but less metallic than brass | Solo work; chimes |

Include at least two pairs in the BOM; let the player choose by context.

## Hardware Alignment

| Operation | Tool / Fixture | Datum | Release Check |
| --- | --- | --- | --- |
| Bar receiving | Calipers, scale, scratch awl | Edge of stock | Verify thickness 0.25 +/- 0.005 in, width 1.00 +/- 0.010 in, no surface damage |
| Mark length and nodes | Stop-block sled, square, fine marker | Left end B, centerline C | Length within +/- 0.020 in of `predicted_length_in + 0.25` (cut long); nodes within +/- 0.020 in |
| Cut to length | Band saw or chop saw with stop block | Left end B | Squareness within 0.5 deg; deburr both ends |
| Drill node holes | Drill press with V-block fence and backer | Centerline C, node line | Hole diameter 0.1875 +/- 0.005 in; perpendicular within 1 deg; no edge tear-out |
| Deburr / file | Bench file, deburring tool, sandpaper | Top face A | Edges chamfered 0.005-0.010 in; node holes deburred |
| Strike test (flat) | Soft foam supports at nodes, tuner, mic | Acoustic node | Record measured Hz, cents error, sustain s in `validation.csv` |
| Trim to pitch | Belt sander or fine file at the ends | Acoustic-tuning datum | Remove material symmetrically from both ends; sneak up slowly (raising pitch is hard to reverse) |
| Mount | Walnut frame jig, paracord, grommets, 1/8 in stainless rod | Frame centerline | All bars seated; cord captures every bar; no metal-on-metal contact |
| Final tune (framed) | Frame on bench, tuner, mallets | Frame centerline | Every bar within +/- 5 cents at soft/medium dynamics |

`jig-decision.md` is the controlling fixture decision record. Pilot fixtures (cut sled, node-drill V-block jig, mounting test rig) are built only for C5/A5/C7 before the full 25-bar run.

## Open Assumptions

- Active packet uses C5-C7 (workbook default). Lower-pitched bass-glock variants (C4-C6) are out of scope for this build.
- 6061-T6 aluminum is the workbook-selected material. Actual stock lot K may differ by 5-10%. The validation pilot is the K-recalibration step, not a confirmation.
- Mounting cord material, grommet durometer, and stainless rod diameter are first-pass picks — pilot at three durometers before freezing.
- Walnut frame geometry, mallet selection, and accidental row offset are TBD until a full-size taped layout passes ergonomic review.
- Final finish on bars: leave raw or clear-coat. Clear coats add mass; expect a small flat-pitch shift (typically <5 cents). Tune after finish if a finish is applied.
- No measured bar data exists yet, so all frequencies are target predictions.

## Validation Plan

1. Cut three pilot bars first: C5, A5, C7. Cut each to `predicted_length_in + 0.25`.
2. Mass-and-strike test on foam supports before drilling node holes (`flat_bar` row in `validation.csv`). Compute K_eff = f * L^2 / t.
3. If pilot K_eff differs from workbook K = 204431 by more than 5%, update the K column in `family-spec.csv` and the workbook B21 cell before cutting the remaining bars.
4. Drill node holes; mount on cord+grommet rig (`mounted` row). Record measured Hz, cents error, and sustain (time to first 6 dB drop after a moderate strike).
5. Trim each pilot to within +/- 10 cents by removing material symmetrically from both ends. Cents error formula:

```text
cents = 1200 * log2(measured_hz / target_hz)
```

6. Mount in the walnut frame (`framed` row). Strike at soft, medium, and loud dynamics; check for buzz, rubber-on-stainless-rod rattle, and frame resonance.
7. Cut the remaining 22 chromatic bars (and 7 additional pentatonic bars if building both) using the calibrated K and the pilot trim discipline.
8. Final assembly check: every bar within +/- 5 cents at soft dynamics, no buzz, sustain consistent across the row to within 30%.

## Provenance

- Source workbook: `glockenspiel-design-table.xlsx`, generated before this v4.3 packet run. 94 formulas, 16 blue inputs, single sheet `Glockenspiel`.
- Skill workflow: `instrument-maker-v4` v4.3 root-mode.
- Reference family: `cantilever-idiophone` / `free-free-bar-idiophone`. Done-bar sibling: `tonykoop/marimba`.
- Cultural context: glockenspiel is a modern Western orchestral idiophone (German "bells play") derived from 18th-19th century military-band bell sets and Berlioz-era orchestral bells. No cultural-appropriation review required for the instrument category.
