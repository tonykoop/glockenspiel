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
