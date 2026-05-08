# Glockenspiel — Tuned Metal-Bar Idiophone Build Packet Print Packet

Generated: 2026-05-08

Packet folder: `/mnt/c/Users/Tony/Documents/GitHub/glockenspiel`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, governing model, material decision matrix, mounting strategy, validation plan. |
| `bom.csv` | Bar set + frame + hardware + mallets + tooling + measurement gear. |
| `sourcing.csv` | Supplier candidates with all prices marked not verified. |
| `cut-list.csv` | Bar stock, walnut frame stock, and jig material cuts. |
| `drawing-brief.md` | Drawing classes, tolerances, and source files. |
| `assembly-manual.md` | Pilot-first build philosophy and full bench workflow. |
| `validation.csv` | Target/measured values per bar; pilot stages for C5/A5/C7. |
| `supplier-rfq.md` | RFQ template covering aluminum + alternates + walnut + hardware. |
| `visual-bom-brief.md` | Image-forward visual BOM plate spec. |
| `jig-decision.md` | Pilot fixture decisions and release gates. |
| `risks.md` | Acoustic / structural / ergonomic / supply / fit-finish risks. |
| `photo-shotlist.md` | Build-log photo plan. |
| `resources.md` | Provenance, family context, public-safety inventory. |
| `README.md` | Project artifact. |
| `family-spec.csv` | 25 chromatic + 10 pentatonic bar dimensions. |

<div class="page-break"></div>

## design.md

Project intent, governing model, material decision matrix, mounting strategy, validation plan.

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


<div class="page-break"></div>

## bom.csv

Bar set + frame + hardware + mallets + tooling + measurement gear.

| item | subassembly | part_name | qty | unit | material_or_spec | make_buy | status | estimated_cost | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Bar set | C5-C7 chromatic tuned bars | 25 | ea | 6061-T6 Aluminum 0.25 x 1.00 in flat bar | make | workbook-derived | $25-40 | Individual dimensions in family-spec.csv. Cut long by 0.25 in and trim to pitch. |
| 2 | Bar set (alt) | Pentatonic art-fair tuned bars | 10 | ea | 6061-T6 Aluminum 0.25 x 1.00 in flat bar | make | workbook-derived | included | Same stock as chromatic. C major pentatonic block in family-spec.csv. |
| 3 | Bar material (alt) | Brass C260 0.25 x 1.00 flat bar | as needed | ft | Brass C260 K=145325 | buy | alternate | $$$ | Premium tone variant. Regenerate family-spec.csv with K=145325 if used. |
| 4 | Bar material (alt) | Steel 1018 0.25 x 1.00 flat bar | as needed | ft | Steel 1018 K=204267 | buy | alternate | $ | K nearly identical to aluminum but heavier and brighter; same predicted lengths. |
| 5 | Bar material (alt) | 304 Stainless flat bar | as needed | ft | 304 SS K=198770 | buy | alternate | $$ | Outdoor / weather-resistant variant. |
| 6 | Bar material (alt) | Phosphor Bronze flat bar | as needed | ft | Phosphor Bronze K=142593 | buy | alternate | $$$$ | Best sustain; highest cost. |
| 7 | Frame | Black Walnut frame stock | ~6 | bf | 3/4 in thick clear straight-grain walnut | make | workbook-derived | $30-60 | CNC-routed front + back rails plus end caps. Hard maple acceptable substitute. |
| 8 | Frame | Frame fastener kit | 1 | set | Wood screws, threaded inserts, washers | buy | TBD | $5-10 | Prefer removable fasteners for tuning access. |
| 9 | Hardware | 550 Paracord (mounting cord) | ~12 | ft | Low-stretch braided nylon cord 4 mm | buy | TBD | $5-10 | Sized to pass through 3/16 in node holes without buzz. |
| 10 | Hardware | Rubber grommets | ~50 | ea | 3/16 in ID rubber grommets in two-three durometer candidates | buy | TBD | $5-15 | Pilot Shore 30A / 50A / 70A on C5/A5/C7 before standardizing. |
| 11 | Hardware | Stainless steel support rod | 2 | ea | 1/8 in 304 stainless steel rod cut to frame length | buy | TBD | $5-10 | Front and back row backup restraints; not load-bearing. |
| 12 | Hardware | Self-adhesive rubber feet | 4 | ea | 1/2 in rubber feet | buy | TBD | $3-5 | Prevent frame sliding on table. |
| 13 | Mallets | Hard rubber mallets | 1 | pair | Hard rubber head 1 in dia / 8-10 in handle | buy | TBD | $10-20 | Default striker; balanced bright/warm tone. |
| 14 | Mallets | Brass mallets | 1 | pair | Brass head 0.75 in dia / 8-10 in handle | buy | TBD | $15-25 | Bright orchestral attack; ship as upgrade option. |
| 15 | Mallets (alt) | Lexan / Delrin mallets | 1 | pair | Lexan or Delrin head | buy | TBD | $15-20 | Less metallic than brass; alternative for solo work. |
| 16 | CNC tooling | 1/4 in downcut spiral router bit | 1 | ea | Hardwood-capable carbide downcut | buy | TBD | $15-25 | Walnut frame profile and grommet pockets. |
| 17 | CNC tooling | 1/8 in upcut spiral router bit | 1 | ea | Hardwood-capable carbide upcut | buy | TBD | $15-25 | Small reliefs and inlay grooves. |
| 18 | CNC tooling | 1/8 in V-bit (60 deg) | 1 | ea | V-carving bit for inlay/engraving | buy | TBD | $15-25 | Optional: Broinwood-style frame inlay. |
| 19 | Bar tooling | 3/16 in HSS or carbide drill bit | 1 | ea | Brad-point or jobber-length bit | buy | TBD | $5-10 | Node-hole drilling. |
| 20 | Bar tooling | Non-ferrous carbide chop-saw blade | 1 | ea | 80T or 100T carbide blade for aluminum | buy | TBD | $30-60 | Cut bars to length without burr-up. |
| 21 | Finish | Tung oil or shellac for frame | 1 | can | Frame finish only; bars left raw or clear-coated separately | buy | TBD | $10-20 | Avoid heavy finishes that load the playing surface. |
| 22 | Finish | Optional clear coat for bars | 1 | can | Thin spray lacquer if desired | buy | TBD | $5-15 | Test pitch shift on offcut before committing. |
| 23 | Measurement | Chromatic tuner / strobe | 1 | ea | Peterson StroboClip HD or app capable of 2 kHz+ | buy/owned | TBD | $30-100 | Must reliably read C7 = 2093 Hz. |
| 24 | Measurement | Microphone for sustain logging | 1 | ea | Dynamic or condenser mic; phone app acceptable for first build | buy/owned | TBD | $0-100 | Capture sustain to first 6 dB drop. |
| 25 | Measurement | Calipers + scale + strike support foam | 1 | set | Digital calipers, kitchen scale, foam blocks | buy/owned | TBD | $0-30 | For K_eff calibration and node-support strike tests. |

<div class="page-break"></div>

## sourcing.csv

Supplier candidates with all prices marked not verified.

| item | stable_spec | supplier_candidates | current_price_status | lead_time_status | verification_needed | notes |
| --- | --- | --- | --- | --- | --- | --- |
| 6061-T6 Aluminum flat bar | 0.25 x 1.00 in flat bar; T6 temper preferred for consistent K; minimum 18 ft per build with pilot scrap | Online Metals; McMaster-Carr; Metal Supermarkets; local metal supplier | not verified | not verified | Verify temper and mill lot; request mill cert for K-calibration record | Buy enough for 25 chromatic + 10 pentatonic + at least 3 pilot/scrap bars from one mill lot. |
| Brass C260 flat bar (alt) | 0.25 x 1.00 in C260 yellow brass flat bar | Online Metals; McMaster-Carr; Metal Supermarkets | not verified | not verified | Verify alloy and temper | Premium tone alt; regenerate family-spec.csv with K=145325 before cutting. |
| Steel 1018 flat bar (alt) | 0.25 x 1.00 in 1018 cold-rolled steel flat bar | Online Metals; McMaster-Carr; local metal supplier | not verified | not verified | Verify cold-rolled vs hot-rolled | Loud and bright; same family-spec lengths as aluminum (K nearly identical). |
| 304 Stainless flat bar (alt) | 0.25 x 1.00 in 304 SS flat bar | Online Metals; McMaster-Carr | not verified | not verified | Verify finish (#4 vs polished) | Outdoor variant; regenerate family-spec.csv with K=198770. |
| Phosphor Bronze flat bar (alt) | 0.25 x 1.00 in phosphor bronze flat bar | Online Metals; specialty metal supplier | not verified | not verified | Verify alloy (510 vs 544) | Premium tone; highest cost; regenerate family-spec.csv with K=142593. |
| Walnut frame lumber | Clear straight-grain Black Walnut 4/4 dressed to 3/4 in thick; sufficient for two rails (~36 in long) plus end caps and accidental row | Local hardwood dealer; Woodcraft; Rockler | not verified | not verified | Verify board flatness and absence of checks | Hard maple or cherry acceptable substitutes; frame wood does not affect bar tuning. |
| Paracord (mounting) | 550 paracord or low-stretch braided nylon cord; 4 mm diameter to fit through 3/16 in node holes | Outdoor / climbing supplier; Amazon; local hardware | not verified | not verified | Verify diameter and stretch under tension | Must not buzz against bar holes. |
| Rubber grommets | 3/16 in ID rubber grommets in Shore 30A / 50A / 70A durometers | McMaster-Carr; marimba parts supplier; Amazon | not verified | not verified | Verify durometer accuracy and sample three options | Two grommets per bar minimum; durometer is the dominant sustain control. |
| Stainless steel support rod | 1/8 in 304 stainless steel rod in 36 in lengths | McMaster-Carr; OnlineMetals; local hardware | not verified | not verified | Verify diameter +/- 0.005 in | Two rods per instrument (front + back row). |
| Self-adhesive rubber feet | 1/2 in rubber feet with 3M adhesive backing | McMaster-Carr; hardware store | not verified | not verified | Verify adhesion strength | Four per frame. |
| Hard rubber mallets | Pair of hard-rubber-headed mallets with 8-10 in wood handles | Music supplier; Amazon; Steve Weiss Music | not verified | not verified | Verify head durometer | Default striker for the assembled instrument. |
| Brass mallets | Pair of brass-headed mallets with 8-10 in wood handles | Music supplier; Steve Weiss Music | not verified | not verified | Verify head finish (polished vs natural) | Optional bright-attack upgrade. |
| Lexan / Delrin mallets | Pair of synthetic-headed mallets | Music supplier; specialty supplier | not verified | not verified | Verify head material | Optional alternative striker; less metallic than brass. |
| CNC router bits | 1/4 in downcut + 1/8 in upcut + 1/8 in V-bit (carbide) | Amana; Whiteside; Onsrud; local CNC supplier | not verified | not verified | Verify shank diameter for collet | Walnut frame profile and inlay. |
| Aluminum drill bit | 3/16 in HSS or carbide bit; brad-point or jobber-length | McMaster-Carr; local hardware | not verified | not verified | Verify bit type | Node-hole drilling. |
| Non-ferrous saw blade | 80T or 100T carbide blade for aluminum chop saw | Local tooling supplier; Amazon | not verified | not verified | Verify arbor size | Avoid burr-up on bar ends. |
| Frame finish | Tung oil or shellac for walnut frame | Wood finishing supplier; hardware store | not verified | not verified | Verify finish compatibility with walnut | Avoid heavy lacquer on the playing surface. |
| Chromatic tuner | Strobe or chromatic tuner with 2 kHz+ range; Peterson StroboClip HD recommended | Music store; Sweetwater; Amazon | not verified | not verified | Verify upper frequency range | Must read C7 = 2093 Hz reliably. |

<div class="page-break"></div>

## cut-list.csv

Bar stock, walnut frame stock, and jig material cuts.

| cut_id | subassembly | qty | material | rough_dimension_in | finished_dimension_or_reference | operation | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CUT-BAR-CHROM-LOW | Chromatic bars C5-G5 | 8 | 6061-T6 Aluminum 0.25 x 1.00 | Cut 0.25 in oversize from family-spec.csv lengths | See GLK-C5 through GLK-G5 in family-spec.csv | Mark/cut/drill/deburr/trim | Longest bars are the stock-yield driver; cut long and trim to pitch. |
| CUT-BAR-CHROM-MID | Chromatic bars Gsharp5-G6 | 12 | 6061-T6 Aluminum 0.25 x 1.00 | Cut 0.25 in oversize from family-spec.csv lengths | See GLK-Gsharp5 through GLK-G6 in family-spec.csv | Mark/cut/drill/deburr/trim | Mid-range bars; standard trim discipline. |
| CUT-BAR-CHROM-HIGH | Chromatic bars Gsharp6-C7 | 5 | 6061-T6 Aluminum 0.25 x 1.00 | Cut 0.25 in oversize from family-spec.csv lengths | See GLK-Gsharp6 through GLK-C7 in family-spec.csv | Mark/cut/drill/deburr/trim | Short bars are pitch-sensitive; trim in 0.05 in increments. |
| CUT-BAR-PENT | Pentatonic art-fair bars (10) | 10 | 6061-T6 Aluminum 0.25 x 1.00 | Cut 0.25 in oversize from family-spec.csv lengths | See GLK-PENT-* in family-spec.csv | Mark/cut/drill/deburr/trim | Optional second instrument; same stock as chromatic. |
| CUT-FRAME-FRONT | Walnut front rail (naturals row) | 1 | Black Walnut 3/4 in thick | ~34 in x ~3 in x 3/4 in rough blank | 33.25 in finished length per design.md | CNC profile/pocket/drill | Holds 15 natural bars (chromatic) or 7 naturals (pentatonic). |
| CUT-FRAME-BACK | Walnut back rail (sharps/flats row) | 1 | Black Walnut 3/4 in thick | ~34 in x ~3 in x 3/4 in rough blank | 33.25 in finished length per design.md (raised 0.5 in) | CNC profile/pocket/drill | Holds 10 sharps/flats (chromatic) or 3 (pentatonic). |
| CUT-FRAME-ENDS | Walnut end caps | 2 | Black Walnut 3/4 in thick | ~5 in x ~3 in x 3/4 in rough blank | Width set by frame depth (~4 in) plus 1 in margin | Cut/drill/joint | End caps tie front and back rails; carry stainless rod holes. |
| CUT-FRAME-CROSS | Walnut cross members (optional) | 2 | Black Walnut 3/4 in thick or hardwood plywood | ~14 in x ~2 in x 3/4 in rough blank | Width set by frame ergonomics | Cut/drill | Optional cross members for stiffness; not required for first build. |
| CUT-JIG-MARK | Marking sled (jig) | 1 | MDF or scrap hardwood | Sized to longest bar plus 6 in | Per JD-020 in jig-decision.md | Cut/clamp/scribe | Stop-block sled for length and node marking. |
| CUT-JIG-DRILL | Node-hole V-block jig (jig) | 1 | MDF or hardwood | ~12 in x 4 in x 1.5 in | Per JD-040 in jig-decision.md | Cut/route/V-groove/drill | V-block fence with hardwood backer for drill press. |
| CUT-JIG-MOUNT | Mounting prototype rig (jig) | 1 | Walnut offcut or scrap hardwood | Three short blocks ~3 in x 1 in x 0.75 in | Per JD-060 in jig-decision.md | Cut/drill/grommet test | Three-block rig for grommet durometer pilot. |
| CUT-JIG-FRAME | Full-size paper or MDF frame template | 1 | Paper or thin MDF | Sized to chromatic frame footprint (~34 in x ~12 in) | Per JD-070 in jig-decision.md | Print or scribe | Validate ergonomics before cutting walnut. |

<div class="page-break"></div>

## drawing-brief.md

Drawing classes, tolerances, and source files.

# Drawing Brief

## Drawing Set

The current packet requires five build-critical drawing classes:

1. **Per-bar dimensioned SVGs** for the three pilot bars (`drawings/GLK-C5-body.svg`, `drawings/GLK-A5-body.svg`, `drawings/GLK-C7-body.svg`). These show the long flat bar, node-hole positions, length dimension, thickness, and a title block. Additional per-bar SVGs can be generated from `family-spec.csv` if the full chromatic set is required.
2. **Family overview** (`drawings/family-overview.svg`) — scaled side-by-side outline of all 25 chromatic bars from C5 (longest) to C7 (shortest), labeled with note + Hz + length, to show the visual tuning gradient.
3. **Frame layout** (`drawings/frame-layout.svg`) — top-down piano-keyboard layout with naturals in the front row, sharps/flats in the back row raised 0.5 in. Shows bar spacing, accidental row offset, frame envelope, and player-side datum.
4. **Mounting detail** (`drawings/mounting-detail.svg`) — section view through one bar at a node showing: bar profile, 3/16 in node hole, paracord, rubber grommet, walnut frame pocket, and 1/8 in stainless support rod position. Critical for explaining why the bar is acoustically isolated from the frame.
5. **Visual BOM plate** (`drawings/visual-bom-plate.svg`) — exploded callout of bar set, frame rails, hardware, and tooling with numbered references to `bom.csv`.

## Drawing Standards

- Units: inches.
- Primary datum for each bar: left end (B) and centerline (C). Top face (A) is implicit.
- Node holes shown at `0.2242 * L` and `0.7758 * L` from the left end.
- Bar dimensions to call out: length, width, thickness, node positions, hole diameter (3/16 in).
- Frame dimensions: rail length, rail thickness, accidental row offset, grommet pocket diameter and depth, support rod hole diameter.
- Tolerances:
  - Bar length cut: `+0.250 in / -0.000 in` before tuning (cut long).
  - Final length: tune-to-pitch, not dimension-only.
  - Thickness: `+/- 0.005 in` (verified at receiving).
  - Node hole placement: `+/- 0.020 in`.
  - Frame pocket: `+/- 0.010 in`.
- CNC notes: bit diameter, stepover, Z-zero surface, tabs, workholding, and release checks per `cnc/setup-sheet.md`.
- Jig notes: which fixture carries datum A/B/C and which validation row releases the operation.

## Open Drawing Questions

- Whether to generate per-bar SVGs for all 25 chromatic notes or only the three pilots.
- Final accidental row offset (currently 0.5 in raised; ergonomic test may reduce).
- Final grommet pocket depth (depends on selected grommet supplier).
- Whether the optional Broinwood-style inlay on rail sides gets a dedicated detail drawing.
- Whether to draw the brass/steel/stainless/phosphor-bronze alternate-metal variants.

## Source Files

- `family-spec.csv` (canonical bar dimensions)
- `design.md` (governing model, mounting strategy)
- `glockenspiel-design-table.xlsx` (parametric workbook)
- `cad/glockenspiel-master.scad` (3D starter)
- `cad/SolidWorks-MasterLayout-Plan.md` (SolidWorks contract)
- `cnc/setup-sheet.md` (operation order, datums)
- `jig-decision.md` (fixture release gates)


<div class="page-break"></div>

## assembly-manual.md

Pilot-first build philosophy and full bench workflow.

# Glockenspiel Assembly Manual

## Build Philosophy

Cut three pilot bars before committing the whole set: C5, A5, and C7. They bound the longest/lowest bar, the mid-scale 880 Hz reference, and the shortest/highest bar. Use their measured pitch and mounting response to decide whether the workbook K constant, selected aluminum stock, and node-hole geometry are ready for the full 25-bar run.

## Preflight

- [ ] Confirm active range: chromatic C5-C7 (25 bars) and / or pentatonic C-major art-fair variant (10 bars).
- [ ] Confirm selected metal (default 6061-T6 Aluminum, K=204431) and verify stock thickness (0.250 in) and width (1.000 in) with calipers.
- [ ] Confirm grommet durometer candidates (suggested: Shore 30A, 50A, 70A).
- [ ] Confirm 1/8 in stainless support rod is on hand and cut to frame length plus 0.5 in margin per end.
- [ ] Review `jig-decision.md` and build only the pilot jigs (JD-010 to JD-050).
- [ ] Print or open `drawings/GLK-C5-body.svg`, `GLK-A5-body.svg`, `GLK-C7-body.svg`, `mounting-detail.svg`, and `cnc/setup-sheet.md`.

## Jig Decision Gate

Use `jig-decision.md` as the shop stop/go sheet. Do not cut the full 25-bar set, drill the final walnut frame, or commit to a permanent grommet system until the pilot rows in `validation.csv` have measured values for `flat_bar`, `post_trim`, `mounted`, and `framed` for C5, A5, and C7.

## Bar Workflow

1. Receive aluminum flat bar. Verify thickness 0.250 +/- 0.005 in and width 1.000 +/- 0.010 in. Reject stock with deep scratches in the playing area or evident bow.
2. Mark each bar with member_id, target note, target Hz, and top face per `family-spec.csv`.
3. Mark each bar at length = `predicted_length_in + 0.25` (cut long, trim to pitch).
4. Mark node positions at `0.2242 * L` and `0.7758 * L` from the left end. Use a centerline gauge for the node-hole position across the bar width.
5. Cut to marked length using the chop saw with non-ferrous carbide blade or band saw with miter gauge. Deburr both ends.
6. Drill 0.1875 in (3/16 in) node holes through the bar at marked positions. Use a V-block fence on the drill press, hardwood backer, depth stop. Peck-drill, lubricate, deburr both faces.
7. Light file/sand on bar edges and corners. Do not round the top face contact zone unnecessarily.
8. Strike-test on foam supports placed at the node positions. Record measured Hz, sustain, timbre, tuner model, and shop temperature in `validation.csv` (`flat_bar` row).

## Tuning Direction

- To lower pitch: remove material from the underside center of the bar (small file or sander). Do this only as a last resort; metal bars are usually tuned by trimming length.
- To raise pitch: shorten the bar by trimming both ends symmetrically. Sneak up in 0.05 in increments — raising pitch is hard to reverse.
- Symmetrical trimming preserves the node-position ratio. Asymmetric trimming shifts the node line and damps mounting.
- Tune flat bars before drilling node holes if the K_eff is off by more than 5%; the calibrated K updates the predicted lengths for all remaining bars.

## Mounting Workflow

1. Cut paracord (or low-stretch braided nylon) to frame length plus 12 in margin.
2. Thread paracord through the front-row node holes (one cord through `node_1` of every front-row bar, a second cord through `node_2`).
3. Thread the back-row sharp/flat bars on a separate pair of cords.
4. Seat each bar on rubber grommets in the frame. Grommets seat in pre-drilled frame pockets; cord captures the bar without compressing the grommets.
5. Run the 1/8 in stainless support rod through the frame as a backup restraint (do not load-bearing the rod).
6. Tension cords just enough to keep bars from sliding; cords should not damp the bar at the nodes.
7. Strike-test each bar after mounting. Record `mounted` row in `validation.csv`.

## Frame Workflow

1. Validate ergonomics first: tape a full-size bar layout on the bench (see `drawings/frame-layout.svg`). The intended player reaches every bar without shoulder strain.
2. CNC-route the walnut frame: front rail (naturals), back rail (sharps/flats raised 0.5 in), end caps, grommet pockets, support rod holes, fastener holes.
3. Optionally laser- or CNC-engrave a Broinwood-style decorative inlay on the rail sides (workbook row 115).
4. Sand to 220 grit. Apply tung oil or shellac. Avoid heavy lacquer; not for tone reasons (the bars are isolated from the frame), but for finish-rub-off on the playing surface.
5. Add four self-adhesive 1/2 in rubber feet to the frame underside.
6. Mount all bars per the Mounting Workflow.
7. Strike-test the assembled instrument at soft, medium, and loud dynamics. Listen for buzz, rattle, or rod-on-bar contact. Record `framed` row in `validation.csv`.

## Final Checks

- [ ] All bars are labeled and match `family-spec.csv`.
- [ ] Cord captures every bar at both node holes; no cord rides between nodes.
- [ ] No metal-on-metal contact (bar-to-rod, bar-to-frame fastener).
- [ ] Every measured pitch has a `validation.csv` row, including pilot K-calibration.
- [ ] Every framed bar within +/- 5 cents at soft dynamics.
- [ ] No persistent buzz at any dynamic on any bar.
- [ ] At least two striker pairs included (suggested: hard rubber and brass).
- [ ] Sustain consistent across the row to within 30%.

## Maintenance

- Wipe aluminum bars with a microfiber cloth to remove fingerprints. Avoid abrasive polish; it changes mass.
- Inspect cords annually for fraying; replace before they fail.
- Replace rubber grommets every 5-10 years or when sustain drops noticeably.
- Re-tune any bar that drifts more than 10 cents (rare for aluminum unless the bar was bent or damaged).


<div class="page-break"></div>

## validation.csv

Target/measured values per bar; pilot stages for C5/A5/C7.

| member_id | target_note | target_hz | predicted_length_in | stage | measured_hz | cents_error | sustain_s | timbre | tuner | environment | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GLK-C5 | C5 | 523.251 | 9.883 | prebuild |  |  |  |  |  |  | Pilot low/longest bar; bounds K-constant + cut-long discipline. |
| GLK-Csharp5 | C#5 | 554.365 | 9.602 | prebuild |  |  |  |  |  |  |  |
| GLK-D5 | D5 | 587.330 | 9.328 | prebuild |  |  |  |  |  |  |  |
| GLK-Dsharp5 | D#5 | 622.254 | 9.063 | prebuild |  |  |  |  |  |  |  |
| GLK-E5 | E5 | 659.255 | 8.805 | prebuild |  |  |  |  |  |  |  |
| GLK-F5 | F5 | 698.456 | 8.554 | prebuild |  |  |  |  |  |  |  |
| GLK-Fsharp5 | F#5 | 739.989 | 8.311 | prebuild |  |  |  |  |  |  |  |
| GLK-G5 | G5 | 783.991 | 8.074 | prebuild |  |  |  |  |  |  |  |
| GLK-Gsharp5 | G#5 | 830.609 | 7.844 | prebuild |  |  |  |  |  |  |  |
| GLK-A5 | A5 | 880.000 | 7.621 | prebuild |  |  |  |  |  |  | A5 = 440·2 reference; mid-scale K check. |
| GLK-Asharp5 | A#5 | 932.328 | 7.404 | prebuild |  |  |  |  |  |  |  |
| GLK-B5 | B5 | 987.767 | 7.193 | prebuild |  |  |  |  |  |  |  |
| GLK-C6 | C6 | 1046.502 | 6.988 | prebuild |  |  |  |  |  |  |  |
| GLK-Csharp6 | C#6 | 1108.731 | 6.789 | prebuild |  |  |  |  |  |  |  |
| GLK-D6 | D6 | 1174.659 | 6.596 | prebuild |  |  |  |  |  |  |  |
| GLK-Dsharp6 | D#6 | 1244.508 | 6.408 | prebuild |  |  |  |  |  |  |  |
| GLK-E6 | E6 | 1318.510 | 6.226 | prebuild |  |  |  |  |  |  |  |
| GLK-F6 | F6 | 1396.913 | 6.049 | prebuild |  |  |  |  |  |  |  |
| GLK-Fsharp6 | F#6 | 1479.978 | 5.876 | prebuild |  |  |  |  |  |  |  |
| GLK-G6 | G6 | 1567.982 | 5.709 | prebuild |  |  |  |  |  |  |  |
| GLK-Gsharp6 | G#6 | 1661.219 | 5.547 | prebuild |  |  |  |  |  |  |  |
| GLK-A6 | A6 | 1760.000 | 5.389 | prebuild |  |  |  |  |  |  |  |
| GLK-Asharp6 | A#6 | 1864.655 | 5.235 | prebuild |  |  |  |  |  |  |  |
| GLK-B6 | B6 | 1975.533 | 5.086 | prebuild |  |  |  |  |  |  |  |
| GLK-C7 | C7 | 2093.005 | 4.941 | prebuild |  |  |  |  |  |  | Pilot high/shortest bar; validates short-bar dimensional sensitivity (~1% cent shift per ~0.025 in). |
| GLK-PENT-C5 | C5 | 523.251 | 9.883 | prebuild |  |  |  |  |  |  | Art-fair pentatonic; share aluminum stock with chromatic. |
| GLK-PENT-D5 | D5 | 587.330 | 9.328 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-E5 | E5 | 659.255 | 8.805 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-G5 | G5 | 783.991 | 8.074 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-A5 | A5 | 880.000 | 7.621 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-C6 | C6 | 1046.502 | 6.988 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-D6 | D6 | 1174.659 | 6.596 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-E6 | E6 | 1318.510 | 6.226 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-G6 | G6 | 1567.982 | 5.709 | prebuild |  |  |  |  |  |  |  |
| GLK-PENT-A6 | A6 | 1760.000 | 5.389 | prebuild |  |  |  |  |  |  |  |
| GLK-C5 | C5 | 523.251 | 9.883 | flat_bar |  |  |  |  |  |  | Cut-long aluminum blank; mass-and-strike test on foam supports before drilling node holes. |
| GLK-C5 | C5 | 523.251 | 9.883 | post_trim |  |  |  |  |  |  | After trim-to-length and deburr; supports at node positions; record measured Hz. |
| GLK-C5 | C5 | 523.251 | 9.883 | mounted |  |  |  |  |  |  | Cord through node holes with rubber grommets; supported on 1/8" stainless rod. |
| GLK-C5 | C5 | 523.251 | 9.883 | framed |  |  |  |  |  |  | Final walnut frame; check buzz at soft/medium/loud strikes; record sustain after first 6 dB drop. |
| GLK-A5 | A5 | 880.000 | 7.621 | flat_bar |  |  |  |  |  |  | Cut-long aluminum blank; mass-and-strike test on foam supports before drilling node holes. |
| GLK-A5 | A5 | 880.000 | 7.621 | post_trim |  |  |  |  |  |  | After trim-to-length and deburr; supports at node positions; record measured Hz. |
| GLK-A5 | A5 | 880.000 | 7.621 | mounted |  |  |  |  |  |  | Cord through node holes with rubber grommets; supported on 1/8" stainless rod. |
| GLK-A5 | A5 | 880.000 | 7.621 | framed |  |  |  |  |  |  | Final walnut frame; check buzz at soft/medium/loud strikes; record sustain after first 6 dB drop. |
| GLK-C7 | C7 | 2093.005 | 4.941 | flat_bar |  |  |  |  |  |  | Cut-long aluminum blank; mass-and-strike test on foam supports before drilling node holes. |
| GLK-C7 | C7 | 2093.005 | 4.941 | post_trim |  |  |  |  |  |  | After trim-to-length and deburr; supports at node positions; record measured Hz. |
| GLK-C7 | C7 | 2093.005 | 4.941 | mounted |  |  |  |  |  |  | Cord through node holes with rubber grommets; supported on 1/8" stainless rod. |
| GLK-C7 | C7 | 2093.005 | 4.941 | framed |  |  |  |  |  |  | Final walnut frame; check buzz at soft/medium/loud strikes; record sustain after first 6 dB drop. |

<div class="page-break"></div>

## supplier-rfq.md

RFQ template covering aluminum + alternates + walnut + hardware.

# Supplier RFQ - Glockenspiel C5-C7 Build

## Scope

Request quotes for one 25-bar C5-C7 chromatic glockenspiel prototype build, with optional materials for a 10-bar pentatonic art-fair variant. Prices, stock, and lead times are intentionally not assumed in this repo; verify current facts before purchasing.

## Bar Stock - Aluminum (Primary)

Please quote 6061-T6 aluminum flat bar suitable for tuned percussion bars.

Required:

- Dimensions: `0.250 in x 1.000 in` flat bar.
- Length: minimum 18 ft total per build (chromatic + pentatonic + pilot scrap).
- Temper: `T6` strongly preferred for consistent K constant.
- Surface: free of deep scratches in playing area.

Please return:

- Mill / mill lot identifier (so the K-calibration record stays traceable across rebuilds).
- Available temper variants and their K-constant impact, if known.
- Cutting service availability (longest single bar needed is 11 in cut from 12-ft stock).
- Mill cert availability for E and rho (used to recompute K_metal independently).

## Bar Stock - Alternate Metals (Optional)

Please quote alternate flat-bar options at the same `0.250 in x 1.000 in` cross-section, in lengths sufficient for one 25-bar build per metal:

| Metal | Spec | Use Case |
| --- | --- | --- |
| Brass C260 | Yellow brass C260 flat bar | Premium warm tone variant |
| Steel 1018 | Cold-rolled 1018 flat bar | Loud / sharp tone variant |
| 304 Stainless | 304 stainless steel flat bar | Outdoor / weather-resistant variant |
| Phosphor Bronze | C510 or C544 phosphor bronze flat bar | Best-sustain premium variant |

Each metal alters the K constant materially; the user will regenerate `family-spec.csv` from the workbook before cutting.

## Frame Hardwood

Please quote Black Walnut frame stock suitable for CNC-routed glockenspiel frames.

Required:

- Black Walnut, 4/4 dressed to `0.750 in` thick.
- Clear straight-grain stock; no checks in finished area.
- Minimum dimensions: enough for two rails (about `36 in x 3 in` finished) plus end caps and an optional accidental row.
- Quantity: enough for one frame plus 1 spare rail.

Acceptable substitutes (functionally equivalent for tuning purposes; aesthetics differ):

- Hard maple
- Cherry

## Hardware

Please quote:

- 550 paracord or low-stretch braided nylon cord, 4 mm diameter.
- Rubber grommets, `0.1875 in` ID, available in Shore 30A / 50A / 70A durometers (sample of three durometers required for pilot).
- 1/8 in 304 stainless steel rod in 36 in lengths (qty 2 minimum per build).
- Self-adhesive 1/2 in rubber feet (qty 4 per frame).
- Frame fastener kit: wood screws, threaded inserts, washers; prefer removable.

## Mallets

Please quote at least two pairs from the following:

- Hard rubber head (default), 1.0 in head dia, 8-10 in handle.
- Brass head (orchestral upgrade), 0.75 in head dia, 8-10 in handle.
- Lexan or Delrin head (alternate), 0.75-1.0 in head dia, 8-10 in handle.

## CNC and Bar Tooling

Please quote:

- 1/4 in carbide downcut spiral router bit, hardwood-capable.
- 1/8 in carbide upcut spiral router bit, hardwood-capable.
- 1/8 in V-bit (60 deg) for optional inlay.
- 3/16 in HSS or carbide drill bit for aluminum (brad-point or jobber).
- 80T or 100T carbide chop-saw blade for non-ferrous metals.

Include shank diameter, cut length, recommended feed/speed range, and replacement availability.

## Measurement

Please quote:

- Chromatic tuner or strobe with reliable readout up to 2.5 kHz (must read C7 = 2093 Hz). Peterson StroboClip HD or equivalent.

## Response Format

Please return:

```text
item
supplier part number
material/spec
actual dimensions / temper / lot id
quantity available
unit price
lead time
shipping estimate
notes/substitution risks
```


<div class="page-break"></div>

## visual-bom-brief.md

Image-forward visual BOM plate spec.

# Visual BOM Brief

## Goal

Create a visual BOM plate that lets another maker understand the glockenspiel build at a glance: bar set, walnut frame, mounting hardware, mallets, CNC and bar tooling, and measurement gear.

## Required Views

1. Hero view of the assembled C5-C7 chromatic glockenspiel on a finished walnut frame, mallets to one side.
2. Exploded view showing bars above the front and back walnut rails, with cord, grommets, and stainless support rods called out.
3. Detail inset for one bar: 3/16 in node holes, top/bottom faces, dimensional callouts (L, w, t).
4. Detail inset for the mounting cross-section: bar, grommet, cord, walnut pocket, stainless support rod.
5. Detail inset for one mallet pair (hard rubber default + brass upgrade).
6. Material swatches: 6061-T6 aluminum bar stock, Black Walnut frame stock, paracord, rubber grommets, stainless support rod, MDF/plywood jig stock.

## BOM Rows To Show

| Item | Visual Needed | Source |
| --- | --- | --- |
| Tuned aluminum bars | Actual shop photo once cut; concept placeholder acceptable before build | `family-spec.csv` |
| Alternate metals (Brass, Steel, SS, Phosphor Bronze) | Supplier image; small swatch row | `sourcing.csv` |
| Walnut frame stock | CAD render or shop photo | `cad/` |
| Paracord (mounting cord) | Supplier image or shop photo | `bom.csv` |
| Rubber grommets (3 durometers) | Supplier image with durometer label | `bom.csv` |
| 1/8 in stainless support rod | Supplier image or shop photo | `bom.csv` |
| Hard rubber + brass mallets | Shop photo | `bom.csv` |
| CNC bits (1/4 downcut, 1/8 upcut, 1/8 V-bit) | Supplier image | `bom.csv` |
| 3/16 in drill bit for aluminum | Supplier image | `bom.csv` |
| Chromatic tuner | Supplier image or shop photo | `validation.csv` workflow |

## Labeling Rules

- Label generated images as concept placeholders.
- Do not use generated images for exact dimensions.
- Every dimension callout must match `family-spec.csv` or be marked `TBD`.
- Keep supplier prices out of the visual until current quotes are verified.
- The five-metal K-comparison is a useful side panel (E vs rho scatter sized by K) — see workbook §6 row 165.

## First Plate Layout

Top: title (Glockenspiel C5-C7), date, range (C5-C7 chromatic + C-pentatonic art-fair), primary material (6061-T6 aluminum).

Middle left: exploded assembly with numbered callouts.

Middle right: BOM table grouped by bar set, frame, hardware, mallets, tooling, measurement.

Side panel: metal K-constant scatter (E vs rho axes, points sized by K). Shows aluminum/steel cluster vs brass/phosphor-bronze cluster.

Bottom: assumptions (workbook K is first-pass; pilot K-calibration required; durometer pilot required) and missing purchase-verification items.


<div class="page-break"></div>

## jig-decision.md

Pilot fixture decisions and release gates.

# Glockenspiel Jig Decision Record

Generated: 2026-05-08

## Purpose

This file is the manufacturing decision layer for the glockenspiel packet. The design table gives bar dimensions; the CNC setup sheet gives operations on the walnut frame. This record decides which jigs earn their way into the first build, what each jig controls, and which validation row proves the decision worked.

The active recommendation is a staged jig system, not one universal fixture. The pilot build should make only the jigs needed to cut, drill, and mount C5, A5, and C7. The remaining 22 chromatic bars wait until those three pilot bars validate K-constant, node-hole geometry, and mounting damping.

## Source Inputs

| Source | Used for |
| --- | --- |
| `family-spec.csv` | Bar length, width, thickness, node positions per note. |
| `design.md` | Free-free metal beam model, mounting strategy, K-calibration discipline. |
| `cnc/setup-sheet.md` | Operation sequence, datum scheme, tool list, pilot gate. |
| `drawings/GLK-C5-body.svg`, `GLK-A5-body.svg`, `GLK-C7-body.svg` | Per-pilot dimensioned drawings. |
| `drawings/mounting-detail.svg` | Node-hole + grommet + cord + stainless-rod section. |
| `drawings/frame-layout.svg` | Piano-keyboard layout, naturals-front / sharps-back rows. |
| `validation.csv` | Measurement rows that decide whether to scale from pilot to full set. |

## Datum Rules

| Datum | Meaning | Must survive |
| --- | --- | --- |
| A | Top face of the bar | Cut to length, drill, deburr, strike test, mounting. |
| B | Left end of the bar | Length mark, node mark 1, drill hole 1. |
| C | Bar centerline | Node hole drilling, mounting, frame layout. |

If a jig loses A/B/C, the bar is no longer traceable to `family-spec.csv`; stop and remark before cutting.

## Pilot Decision

| Pilot bar | Why it is in the pilot | Pass gate before full set |
| --- | --- | --- |
| C5 | Longest bar (9.883 in), lowest pitch (523 Hz). Validates the workbook K constant against the actual stock. | Cut-long blank Hz produces K_eff within 5% of workbook K. Measured Hz after trim within +/- 10 cents of target. Sustain >= 3 s. |
| A5 | A5 = 880 Hz reference (one octave above orchestral A4). Mid-scale K check. | Measured Hz within +/- 5 cents of 880 Hz after trim. Mounting does not damp below 1.5 s sustain. |
| C7 | Shortest bar (4.941 in), highest pitch (2093 Hz). Validates dimensional sensitivity (a 0.025 in length change shifts pitch ~1%). | Trim discipline can land C7 within +/- 10 cents in 0.05 in length increments. Striker hardness is musical, not harsh. |

Full production is blocked until these rows in `validation.csv` have measured values: `flat_bar`, `post_trim`, `mounted`, `framed` for C5, A5, and C7.

## Decision Matrix

| Decision ID | Operation | Chosen jig | Why this choice | Go/no-go test |
| --- | --- | --- | --- | --- |
| JD-010 | Receive and verify aluminum stock | Calipers, scratch-awl marking station | Stock dimension and surface quality must be confirmed before cut planning. | Thickness 0.250 +/- 0.005 in, width 1.000 +/- 0.010 in, no deep scratches in playing area. |
| JD-020 | Mark bar length and node positions | Stop-block sled with scribe and centerline gauge | Repeatability matters more than speed; a misplaced node hole damps the bar. | Length within +/- 0.020 in of `predicted_length_in + 0.25`; node 1/2 within +/- 0.020 in of `0.2242·L` and `0.7758·L`. |
| JD-030 | Cut to length | Chop saw with carbide non-ferrous blade and stop block, OR band saw with miter gauge | Chop saw is faster and squarer; band saw is safer for short pilot bars. Pick one and document. | Cut squareness <= 0.5 deg from perpendicular; deburred to no-snag. |
| JD-040 | Drill node holes | Drill press with V-block jig referenced to centerline, hardwood backer, depth stop | Holes off-axis or off-node will damp the bar; the V-block + backer is the standard pattern. | Holes 0.1875 +/- 0.005 in, perpendicular within 1 deg, no edge tear-out, deburred both faces. |
| JD-050 | Strike-test on pilot supports | Foam-block node-support cradle, dynamic mic, tuner | A consistent acoustic datum is required to compare flat vs mounted vs framed. | Same support spacing every test; measured Hz repeatable within 2 cents across three strikes. |
| JD-060 | Mounting prototype rig | Three short walnut blocks (drilled for grommets, slotted for cord, drilled for stainless rod), test cord | Sustain depends on grommet durometer and cord tension; need to test before frame routing. | Pilot bars retain >= 75% of flat-bar sustain when mounted. |
| JD-070 | Walnut frame layout template | Full-size paper or MDF template marked with chromatic bar positions, sharps/naturals rows, hand zones | Player reach must be validated before cutting walnut. | Player reaches all bars without shoulder strain; mallet trajectory clear of frame. |

## Rejected Fixture Options

| Rejected option | Reason |
| --- | --- |
| Single 25-bar CNC nest for all node-hole drilling | Too much aluminum in one fixture before pilot K is confirmed; one wrong K kills the lot. |
| Permanent press-fit grommets in finished walnut frame | Locks in durometer choice before pilot sustain test; rework requires destroying the frame. |
| Final furniture-grade walnut frame on first build | The frame should validate ergonomics, mallet reach, and grommet durometer before final joinery. |
| Resonator tubes under each bar | Out of scope per workbook §3 row 140; small bars at C5-C7 do not benefit from quarter-wave coupling at usable tube lengths. |
| Arch undercut (marimba-style) | Out of scope per workbook §3; metal bars want a dry, bright tone, not lowered fundamental. |

## Jig Build Order

1. Build only JD-010 through JD-050 for the pilot set.
2. Cut and measure C5, A5, C7 through `flat_bar` and `post_trim` validation rows.
3. Confirm K_eff and trim discipline before drilling node holes on remaining bars.
4. Build JD-060 (mounting prototype) with three durometer candidates; measure sustain.
5. Build JD-070 (frame template) and validate reach.
6. Cut the remaining 22 chromatic bars (and 7 additional pentatonic bars if both scales are being built) using the calibrated K and trim discipline.
7. Route the walnut frame; mount all bars; run final `framed` validation row.

## Validation Rows To Preserve

| Row pattern | Purpose | Release threshold |
| --- | --- | --- |
| `flat_bar` | Cut-long blank Hz; K-calibration. | K_eff within 5% of workbook K, or workbook K updated. |
| `post_trim` | After trim-to-length and deburr; supports at nodes. | Within +/- 10 cents of target Hz for pilot bars. |
| `mounted` | After cord + grommet + stainless rod mounting on test rig. | Sustain >= 75% of flat-bar sustain; pitch shift <= 5 cents. |
| `framed` | After installation in final walnut frame. | Within +/- 5 cents at soft dynamics; no buzz at any dynamic. |

## Open Decisions

- Final grommet durometer (Shore 30A vs 50A vs 70A) remains TBD until pilot sustain measurements.
- Striker hardness selection (brass vs hard rubber vs lexan/Delrin) — at minimum two pairs ship with the instrument; let the player pick.
- Whether the first build uses a temporary MDF validation frame or jumps directly to walnut.
- Whether the chromatic and pentatonic builds share one frame jig with two drilling templates, or use independent jigs.
- Whether to run a parallel brass / phosphor-bronze pilot (one C5 bar in each metal) to validate the K library beyond aluminum.


<div class="page-break"></div>

## risks.md

Acoustic / structural / ergonomic / supply / fit-finish risks.

# Glockenspiel Risk Register

## Acoustic Risks

### Bar pitch misses workbook prediction (K-constant variance)

- Risk: Selected 6061-T6 aluminum stock has a different effective K than the workbook value of 204431. Heat-treat condition (T6 vs T4 vs annealed), extrusion vs sawn flat-bar, cold-work history, and dimensional tolerance all shift effective K by 5-10%.
- Impact: Every bar cut to `predicted_length_in` lands sharp or flat by a consistent amount; without trim allowance the entire batch is scrap.
- Test: Cut C5, A5, C7 pilot bars cut-long by 0.25 in. Mount on foam at nodes. Compute `K_eff = f * L^2 / t` from measured Hz.
- Pass criterion: Pilot K_eff differs from workbook K by less than 5%, or the workbook K is updated to match before the remaining 22 bars are cut.
- Mitigation: Always cut bars at predicted length + 0.25 in. Tune by removing material from both ends. Update `family-spec.csv` and workbook B21 with the calibrated K.

### Mounting damps fundamental or kills sustain

- Risk: Rubber grommet durometer, cord tension, or stainless support rod contact damps the free-free first mode. Free-free bars require contact only at the nodes; any contact away from the node line shortens sustain.
- Impact: Bars sound dead, sustain drops below 1 second, or pitch shifts flat under load.
- Test: Pilot each grommet candidate (Shore 30A, 50A, 70A) on C5/A5/C7. Measure sustain to first 6 dB drop after a moderate strike.
- Pass criterion: Sustain >= 3 s for C5 fundamental, >= 1.5 s for A5, >= 0.8 s for C7. Pitch shift under mounting <= 5 cents from flat-bar measurement.
- Mitigation: Soften grommets, increase node-hole diameter, or relocate the support rod so it does not contact the bar between nodes.

### Striker hardness produces unwanted timbre

- Risk: Brass strikers on aluminum bars produce a harsh, ear-piercing attack at C7 frequencies (above 2 kHz).
- Impact: Player or audience experiences listening fatigue; instrument is unpleasant in small rooms.
- Test: Strike each pilot bar with brass, hard rubber, and lexan strikers. Record perceived timbre and decay.
- Pass criterion: At least one striker option produces a tone judged "musical" rather than "harsh" by two listeners in the build space.
- Mitigation: Ship the instrument with hard-rubber strikers as the default and brass as an optional upgrade; document the trade-off in the assembly manual.

## Structural Risks

### Drilling node holes splits or burrs the aluminum

- Risk: Drilling 3/16 in holes through 1/4 in flat bar without proper backing causes burr-up, edge tear-out, or work-hardening.
- Impact: Cracked bar, rough hole, asymmetric mounting, audible buzz at the node.
- Test: Drill sample holes in offcut aluminum with the intended bit and backing board. Inspect for clean entry/exit and freedom from burrs.
- Pass criterion: Clean holes, no visible burrs after deburring, no cracks visible under magnification.
- Mitigation: Use a sharp HSS or carbide bit, peck-drill through hardwood backer, deburr both faces, lubricate with cutting fluid.

### Bar-to-stainless-rod metal contact buzz

- Risk: 1/8 in stainless support rod contacts the underside of a bar between the cord supports, causing audible buzz at moderate-to-loud strike intensity.
- Impact: Metallic rattle on every strike; instrument is unusable for performance.
- Test: Strike each bar at three dynamic levels (soft, medium, loud) on the assembled frame.
- Pass criterion: No audible rattle or buzz at any dynamic.
- Mitigation: Lower the stainless rod relative to the bar, add a continuous foam strip on top of the rod, or remove the rod and rely on cord-only mounting.

## Ergonomic Risks

### Frame too wide for player reach

- Risk: 25-bar chromatic frame is about 33 in wide. With sharps in a back row offset 0.5 in higher, the playing surface depth approaches 4 in.
- Impact: Player cannot reach center bars without leaning; mallet strikes lose accuracy at the edges.
- Test: Tape a full-size bar layout on a bench and have the intended player reach every bar from a normal stance.
- Pass criterion: All 25 bars reachable without shoulder strain in less than 1 second per note.
- Mitigation: Reduce range to two octaves (C5-C6, 13 bars), use the pentatonic 10-bar variant, or split the chromatic into a stacked / curved frame.

### Mallet handle length wrong for table-height frame

- Risk: Stock 8-10 in mallet handles assume the frame sits at standing-shop-bench height (~36 in). A seated player at a 30 in table will overshoot strikes.
- Impact: Inconsistent attack; player cannot control dynamics.
- Test: Strike each bar at the intended playing surface height; measure mallet head trajectory.
- Pass criterion: Mallet head can land flat on the bar center without forearm strain.
- Mitigation: Provide both handle lengths, or specify the intended playing surface height in the BOM.

## Supply Risks

### Aluminum stock lot variation

- Risk: Different mill lots of 6061-T6 1/4 in x 1 in flat bar carry slightly different temper and effective K. A second build using a new lot can produce systematically different pitches.
- Impact: Second-batch instrument plays out of tune relative to first.
- Test: Each new aluminum lot triggers a fresh K-calibration pilot (C5/A5/C7 only).
- Pass criterion: Each lot's K_eff is documented in `validation.csv` and `family-spec.csv` is updated before the run.
- Mitigation: Treat K as a per-lot parameter. Buy enough stock for a complete instrument from one mill lot.

### Walnut frame stock availability

- Risk: Clear straight-grain Black Walnut for the CNC-routed frame may be expensive or out of stock locally.
- Impact: Build delay or fall-back to a less attractive frame wood.
- Test: Quote walnut, hard maple, cherry from local hardwood dealers before committing.
- Pass criterion: Selected wood available within the build's lead-time budget at acceptable cost.
- Mitigation: Hard maple is an acceptable substitute for the frame; cherry works if walnut is unavailable. None of these affect bar tuning.

### Metal supplier substitution risk (alternative metals)

- Risk: If the user switches from aluminum to brass / steel / stainless / phosphor bronze, the K constant changes by up to 30%. Reusing a packet computed for aluminum produces wildly wrong lengths.
- Impact: Whole-batch scrap.
- Test: Verify `material` and `k_constant` columns in `family-spec.csv` match the actual metal before any cutting.
- Pass criterion: Metal name and K constant match.
- Mitigation: Regenerate `family-spec.csv` from the workbook with the new K value before cutting. Document the swap in `validation.csv` notes.

## Fit And Finish Risks

### Clear-coat finish detunes bars

- Risk: Lacquer or clear coat on aluminum adds mass and damping; pitch can drop 3-10 cents and sustain can shorten.
- Impact: Bars finished after tuning play flat.
- Test: Apply finish to one offcut and one tuned sacrificial bar. Measure Hz before and after.
- Pass criterion: Pitch shift predictable within +/- 5 cents and within final tuning allowance.
- Mitigation: Use a thin finish, tune after finish, or leave bars raw with periodic light polish.

### Frame buzz from loose hardware

- Risk: Wood screws, threaded inserts, washers, or rubber feet rattle against the frame at moderate-to-loud strikes.
- Impact: Buzz on every strike; instrument fails final validation.
- Test: Strike every bar at soft / medium / loud dynamics on the fully assembled frame; listen for any non-bar sound source.
- Pass criterion: No audible buzz at any dynamic.
- Mitigation: Add thread-locker, soft washers, or felt pads under hardware. Replace rubber feet if they shed grip on the playing surface.


<div class="page-break"></div>

## photo-shotlist.md

Build-log photo plan.

# Photo Shotlist

This shotlist follows the repo-level photo pipeline expectations from `instrument-maker/docs/photo-pipeline.md`: capture real process images first, use generated or supplier images only as labeled placeholders, and keep build-log image names stable enough for `site/index.html`.

## Intake And Materials

- `images/01-workbook-table.png`: screenshot of `glockenspiel-design-table.xlsx` showing the Glockenspiel sheet with K library and bar calculator.
- `images/02-aluminum-stock.jpg`: rough 6061-T6 flat bar with ruler and mill-cert label visible.
- `images/03-walnut-frame-stock.jpg`: walnut boards selected for the frame, with a grain-direction arrow.
- `images/04-hardware-options.jpg`: three durometer rubber grommets, paracord, 1/8 in stainless rod laid out for the durometer pilot.
- `images/05-mallets-options.jpg`: hard rubber, brass, and lexan/Delrin mallet pairs side-by-side.

## Bar Fabrication

- `images/10-bar-marking.jpg`: stop-block sled with C5 blank marked for length and node positions.
- `images/11-bar-cutting.jpg`: chop saw or band saw cutting C5 to length.
- `images/12-bar-deburr.jpg`: deburred bar end close-up.
- `images/13-node-drilling.jpg`: drill press with V-block jig and hardwood backer drilling node hole.
- `images/14-node-hole-detail.jpg`: clean 3/16 in hole through the bar.

## Tuning And Mounting

- `images/20-flat-bar-strike.jpg`: pilot bar on foam supports at nodes with tuner reading Hz.
- `images/21-trim-to-pitch.jpg`: belt sander or fine file removing material symmetrically from both ends.
- `images/22-mounting-rig.jpg`: three-block prototype rig with three durometer grommets ready for sustain comparison.
- `images/23-cord-thread.jpg`: paracord threaded through node holes of one row.

## Frame And Final Assembly

- `images/30-frame-routing.jpg`: walnut rail on CNC router with grommet pockets cut.
- `images/31-frame-layout-test.jpg`: full-size paper template on bench for ergonomic check.
- `images/32-mounted-row.jpg`: full natural row mounted in walnut rail.
- `images/33-finished-front.jpg`: full instrument front view.
- `images/34-finished-side.jpg`: side view showing accidental row offset.
- `images/35-detail-grommet.jpg`: close-up of one bar in its grommet, showing isolation from frame.

## Validation

- `images/40-pilot-c5-tuning.jpg`: C5 framed and measured.
- `images/41-pilot-a5-tuning.jpg`: A5 framed and measured.
- `images/42-pilot-c7-tuning.jpg`: C7 framed and measured.
- `images/43-validation-log.jpg`: tuner, mic, and `validation.csv` workflow on bench.
- `images/44-buzz-test.jpg`: buzz check at three dynamics on the assembled instrument.


<div class="page-break"></div>

## resources.md

Provenance, family context, public-safety inventory.

# Resources & Provenance

## Workbook Lineage

- Source workbook: `glockenspiel-design-table.xlsx` (committed to this repo).
  - Single sheet `Glockenspiel`, range `A1:L174`.
  - 94 formula cells, 16 blue input cells.
  - Five-metal K library (rows 14-20): 6061-T6 Aluminum, Brass C260, Steel 1018, 304 Stainless, Phosphor Bronze.
  - Two scale blocks: 25-bar chromatic C5-C7 (rows 23-49) and 10-bar C-major pentatonic (rows 92-110).
  - Wolfram notebook spec (rows 129-159) and Wolfram exploration ideas (rows 161-174).

## Instrument Family Context

- Cultural origin: glockenspiel is a modern Western orchestral and military-band idiophone. The German name means "bells play"; the form derives from sets of small bells used in 18th-19th century military bands and was standardized as a bar instrument by Berlioz-era orchestras (1819+).
- Synonyms: orchestra bells, bell lyre (marching), orchestral bells (some scores).
- Distinguished from xylophone (wood bars, no arch) and marimba (wood bars, arch + resonators) by being metal bars without arch or resonator.

## Reference Repos

- `tonykoop/marimba` — closest sibling: free-free beam idiophone, same node math, same imperial K formulation, same validation discipline. The glockenspiel diverges by using metal instead of wood, omitting arch and resonator, and replacing wood K-table with metal K-table.
- `tonykoop/tongue-drum` — README convention and documentation standard reference.
- `tonykoop/instrument-maker` — catalog this repo is part of.

## Skill / Documentation Lineage

- Skill: `instrument-maker-v4` v4.3 root-mode.
- Reference docs consulted: `references/acoustic-models.md` (Free-Free Beams + empirical-correction guard rules), `references/new-instruments-v4.md` (Glockenspiel section), `references/repo-relationships.yaml` (cantilever-idiophone family).

## Empirical-Correction Guard Rules (Honest Inventory)

The following corrections do NOT apply to this packet:

- **NAF K2 corrections** (open-pipe flute bore-diameter table) — open-pipe flute model only.
- **Vessel Helmholtz corrections** — applies to ocarina/udu/gemshorn, not free-free beams.
- **Cantilever wood K-table** — applies to fixed-free wood beams (tongue drums), not free-free metal bars.
- **Marimba arch undercut math** — out of scope for metal bars (no arch).
- **Quarter-wave resonator math** — out of scope for this packet (no resonators).

The only correction loop that DOES apply: per-lot K calibration from pilot measurements, recorded in `validation.csv` and propagated to `family-spec.csv` and the workbook B21 cell.

## Public-Safety Inventory

- No private repo links.
- No local absolute paths in user-facing artifacts.
- No supplier prices frozen as facts (`current_price_status = not verified` throughout).
- No unlicensed images (no images currently committed; placeholders documented in `photo-shotlist.md`).
- No cultural-appropriation flags for the instrument category (modern Western orchestral instrument).
- License: CC BY 4.0 per existing `LICENSE` file.

## Open Provenance Questions

- Whether the K constants in the workbook material library should be regenerated from a single E/rho source (e.g., MatWeb) for traceability vs the current literature-pulled values.
- Whether to commit a small `data/k-library-source.csv` documenting where each K came from.
- Whether to add a "what would change for an outdoor sound-garden glockenspiel" appendix once the indoor build is validated.


<div class="page-break"></div>

## README.md

Project artifact.

# Glockenspiel

Engineering documentation and parametric design table for the glockenspiel — metal bar idiophone tuned via cantilever-beam scaling.

Part of the [tonykoop/instrument-maker](https://github.com/tonykoop/instrument-maker) catalogue.

> CAD renders, Wolfram notebook recordings, and a finalized build method are forthcoming.

## License

[CC BY 4.0](LICENSE) — see LICENSE for details.


<div class="page-break"></div>

## family-spec.csv

25 chromatic + 10 pentatonic bar dimensions.

| member_id | target_note | midi | target_hz | predicted_length_in | predicted_width_in | predicted_thick_in | node_1_in | node_2_in | material | k_constant | scale_label | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GLK-C5 | C5 | 72 | 523.251 | 9.883 | 1.000 | 0.250 | 2.216 | 7.667 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Csharp5 | C#5 | 73 | 554.365 | 9.602 | 1.000 | 0.250 | 2.153 | 7.449 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-D5 | D5 | 74 | 587.330 | 9.328 | 1.000 | 0.250 | 2.091 | 7.237 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Dsharp5 | D#5 | 75 | 622.254 | 9.063 | 1.000 | 0.250 | 2.032 | 7.031 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-E5 | E5 | 76 | 659.255 | 8.805 | 1.000 | 0.250 | 1.974 | 6.831 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-F5 | F5 | 77 | 698.456 | 8.554 | 1.000 | 0.250 | 1.918 | 6.636 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Fsharp5 | F#5 | 78 | 739.989 | 8.311 | 1.000 | 0.250 | 1.863 | 6.447 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-G5 | G5 | 79 | 783.991 | 8.074 | 1.000 | 0.250 | 1.810 | 6.264 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Gsharp5 | G#5 | 80 | 830.609 | 7.844 | 1.000 | 0.250 | 1.759 | 6.085 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-A5 | A5 | 81 | 880.000 | 7.621 | 1.000 | 0.250 | 1.709 | 5.912 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Asharp5 | A#5 | 82 | 932.328 | 7.404 | 1.000 | 0.250 | 1.660 | 5.744 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-B5 | B5 | 83 | 987.767 | 7.193 | 1.000 | 0.250 | 1.613 | 5.580 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-C6 | C6 | 84 | 1046.502 | 6.988 | 1.000 | 0.250 | 1.567 | 5.422 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Csharp6 | C#6 | 85 | 1108.731 | 6.789 | 1.000 | 0.250 | 1.522 | 5.267 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-D6 | D6 | 86 | 1174.659 | 6.596 | 1.000 | 0.250 | 1.479 | 5.117 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Dsharp6 | D#6 | 87 | 1244.508 | 6.408 | 1.000 | 0.250 | 1.437 | 4.972 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-E6 | E6 | 88 | 1318.510 | 6.226 | 1.000 | 0.250 | 1.396 | 4.830 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-F6 | F6 | 89 | 1396.913 | 6.049 | 1.000 | 0.250 | 1.356 | 4.693 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Fsharp6 | F#6 | 90 | 1479.978 | 5.876 | 1.000 | 0.250 | 1.318 | 4.559 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-G6 | G6 | 91 | 1567.982 | 5.709 | 1.000 | 0.250 | 1.280 | 4.429 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Gsharp6 | G#6 | 92 | 1661.219 | 5.547 | 1.000 | 0.250 | 1.244 | 4.303 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-A6 | A6 | 93 | 1760.000 | 5.389 | 1.000 | 0.250 | 1.208 | 4.181 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-Asharp6 | A#6 | 94 | 1864.655 | 5.235 | 1.000 | 0.250 | 1.174 | 4.062 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-B6 | B6 | 95 | 1975.533 | 5.086 | 1.000 | 0.250 | 1.140 | 3.946 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-C7 | C7 | 96 | 2093.005 | 4.941 | 1.000 | 0.250 | 1.108 | 3.834 | 6061-T6 Aluminum | 204431 | C5-C7 chromatic | Workbook-derived from Glockenspiel sheet (rows 25-49); free-free metal beam, 6061-T6 K=204431; nodes at 0.224·L and 0.776·L; metal bars carry NO arch undercut and NO resonator (workbook §3 row 140). |
| GLK-PENT-C5 | C5 | 72 | 523.251 | 9.883 | 1.000 | 0.250 | 2.216 | 7.667 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-D5 | D5 | 74 | 587.330 | 9.328 | 1.000 | 0.250 | 2.091 | 7.237 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-E5 | E5 | 76 | 659.255 | 8.805 | 1.000 | 0.250 | 1.974 | 6.831 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-G5 | G5 | 79 | 783.991 | 8.074 | 1.000 | 0.250 | 1.810 | 6.264 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-A5 | A5 | 81 | 880.000 | 7.621 | 1.000 | 0.250 | 1.709 | 5.912 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-C6 | C6 | 84 | 1046.502 | 6.988 | 1.000 | 0.250 | 1.567 | 5.422 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-D6 | D6 | 86 | 1174.659 | 6.596 | 1.000 | 0.250 | 1.479 | 5.117 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-E6 | E6 | 88 | 1318.510 | 6.226 | 1.000 | 0.250 | 1.396 | 4.830 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-G6 | G6 | 91 | 1567.982 | 5.709 | 1.000 | 0.250 | 1.280 | 4.429 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |
| GLK-PENT-A6 | A6 | 93 | 1760.000 | 5.389 | 1.000 | 0.250 | 1.208 | 4.181 | 6061-T6 Aluminum | 204431 | C major pentatonic art-fair | Art-fair C major pentatonic (workbook rows 94-103, alt scale row 122); same bar stock and K as chromatic block; 10-bar set. |

<div class="page-break"></div>