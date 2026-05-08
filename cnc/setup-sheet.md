# CNC / Manufacturing Setup Sheet — Glockenspiel

- Packet: `/mnt/c/Users/Tony/Documents/GitHub/glockenspiel`
- Family: `free-free-bar-idiophone-metal`
- Generated: 2026-05-08
- Machine note: Maker Nexus / home shop CNC router for the **walnut frame only**. Bar work is bench-top: chop saw or band saw + drill press + bench file + tuner. Verify exact CNC machine, spindle, collet, bed size, and hold-down before CAM.

## Assumptions

- This is a pre-CAM operation graph, not verified G-code.
- Active build range: C5-C7 chromatic, 25 bars (with optional 10-bar C-major-pentatonic art-fair variant sharing the same stock and frame jig).
- Source dimensions come from `family-spec.csv` and `glockenspiel-design-table.xlsx`.
- Bars are 6061-T6 aluminum flat stock at 0.250 in × 1.000 in. NO arch undercut, NO resonator tubes (per `design.md`).
- Walnut frame is the only true CNC operation. Pilot fixtures (cut sled, V-block drill jig, mounting rig) are MDF/scrap and built per `jig-decision.md`.
- Effective K constant is calibrated from C5/A5/C7 pilot measurements; workbook K = 204431 is a first-pass estimate.

## Pilot Gate

Cut C5, A5, C7 bars cut-long, drill node holes, strike-test, trim to pitch, and run the mounting prototype before any walnut is loaded on the CNC.

Release to full production only if:

- C5 cut-long Hz produces K_eff within 5% of workbook K, OR `family-spec.csv` is updated with the calibrated K and the workbook B21 cell is also updated.
- A5 trims to within +/- 5 cents of 880 Hz; mounting on the prototype rig does not damp below 1.5 s sustain.
- C7 trim discipline lands within +/- 10 cents in 0.05 in length increments.
- Mounting rig (OP-300) confirms a durometer choice (typically Shore 50A is the starting expectation).
- Frame layout template confirms ergonomic reach for the intended player.

## Operation Graph

### OP-010 — Review design package and pilot gate

- Machine: Bench
- Tool: `design.md`, `family-spec.csv`, `jig-decision.md`, calipers, tuner
- Workholding: Flat bench, drawing packet
- Datum: Top face A, left end B, bar centerline C
- Inputs: `design.md`, `family-spec.csv`, `drawings/family-overview.svg`, `validation.csv`
- Outputs: pilot-build checklist
- Checks:
  - C5/A5/C7 pilot bars identified.
  - Actual metal stock (mill lot) verified.
  - Full-set cutting held until pilot data is reviewed.

### OP-100 — Receive and verify aluminum stock

- Machine: Bench
- Tool: Calipers, scratch awl, scale
- Workholding: Flat bench
- Datum: Stock edge
- Inputs: `bom.csv`, `sourcing.csv`
- Outputs: Verified aluminum bar stock
- Checks:
  - Thickness `0.250 +/- 0.005 in`.
  - Width `1.000 +/- 0.010 in`.
  - No deep scratches in playing area.
  - Mill lot recorded for K-calibration traceability.

### OP-110 — Mark bar length and node positions

- Machine: Bench
- Tool: Stop-block sled (JD-020), square, fine marker, centerline gauge
- Workholding: Sled
- Datum: Left end B against fence; centerline C
- Inputs: `family-spec.csv`, `drawings/GLK-*-body.svg`
- Outputs: Marked blanks ready for cutting
- Checks:
  - Length within `+/- 0.020 in` of `predicted_length_in + 0.250 in` (cut-long discipline).
  - node_1 and node_2 within `+/- 0.020 in`.

### OP-120 — Cut bars to length

- Machine: Chop saw (preferred) or band saw with miter gauge
- Tool: 80T or 100T carbide blade for non-ferrous metals
- Workholding: Stop block, hold-down clamp
- Datum: Left end B against fence
- Inputs: `family-spec.csv`, `cut-list.csv`
- Outputs: Cut-long bar blanks
- Checks:
  - Cut squareness <= 0.5 deg from perpendicular.
  - Both ends deburred (light file or chamfer).
  - Each bar labeled with `member_id` and target Hz.

### OP-130 — Drill node holes

- Machine: Drill press
- Tool: 3/16 in HSS or carbide drill bit, hardwood backer, depth stop, optional cutting fluid
- Workholding: V-block jig (JD-040) clamped to drill-press table
- Datum: Left end B against jig fence; centerline C
- Inputs: `family-spec.csv`, `drawings/GLK-*-body.svg`
- Outputs: Bars with two clean node holes
- Checks:
  - Hole diameter `0.1875 +/- 0.005 in`.
  - Perpendicular within 1 deg.
  - No edge tear-out.
  - Both faces deburred.

### OP-140 — Strike-test on foam supports (flat_bar row)

- Machine: Bench
- Tool: Foam blocks at node positions, chromatic tuner (>= 2 kHz range), microphone
- Workholding: Foam node-support cradle (JD-050)
- Datum: Acoustic node datum
- Inputs: `validation.csv`, `family-spec.csv`
- Outputs: Measured Hz, sustain, timbre per pilot bar
- Checks:
  - K_eff = f * L^2 / t computed for each pilot.
  - Sustain to first 6 dB drop logged.
  - If K_eff differs from workbook K by more than 5%, update `family-spec.csv` and workbook B21 before cutting remaining bars.

### OP-150 — Trim to pitch (post_trim row)

- Machine: Bench / belt sander or fine bench file
- Tool: Belt sander or bench file, calipers, tuner
- Workholding: Hand-held; both ends accessible
- Datum: Acoustic-tuning datum (preserve symmetry)
- Inputs: `validation.csv`
- Outputs: Bars trimmed to within tuning tolerance
- Checks:
  - Material removed symmetrically from both ends (preserves node ratio).
  - Cents error logged in `validation.csv`.
  - Length recorded post-trim.

### OP-200 — Walnut frame: receive and inspect

- Machine: Bench
- Tool: Calipers, square, moisture meter (optional)
- Workholding: Flat bench
- Datum: Board edge
- Inputs: `bom.csv`, `sourcing.csv`
- Outputs: Verified walnut stock
- Checks:
  - Thickness `0.75 in` (or planed to it).
  - Straight grain through the finished rail area.
  - No checks running through the rail.

### OP-210 — Walnut frame: CNC fixture and datum verification

- Machine: CNC router
- Tool: Spoilboard surfacing bit, edge finder/probe, clamps/tape
- Workholding: Replaceable spoilboard, datum fence, optional vacuum + clamps
- Datum: Machine X0 at left rail end, Y0 at rail centerline, Z0 top face
- Inputs: `cnc/setup-sheet.md`, `drawings/frame-layout.svg`
- Outputs: Verified fixture, air-cut report
- Checks:
  - Spoilboard surfaced.
  - Clamps clear toolpath.
  - Sample air-cut passes before walnut is loaded.

### OP-220 — Walnut frame: rough rail profile and grommet pockets

- Machine: CNC router
- Tool: 1/4 in carbide downcut spiral (profile), 1/8 in carbide upcut spiral (pocket detail)
- Workholding: Spoilboard tape/clamps; tabs at non-stress regions
- Datum: Top face, left end, centerline
- Inputs: `family-spec.csv`, `cad/design-table-inputs.csv`, `drawings/frame-layout.svg`
- Outputs: Profiled walnut rails with grommet pockets
- Checks:
  - Pocket diameter and depth match `cad/sw-global-variables.csv` (`grommet_pocket_dia = 0.45 in`, `grommet_pocket_depth = 0.30 in`).
  - Rail length 33.25 in (chromatic) or 14.50 in (pentatonic).
  - Bar-to-bar spacing 1.25 in.
  - Front rail (15 naturals chromatic / 7 pentatonic) and back rail (10 sharps chromatic / 3 pentatonic) cut separately.

### OP-230 — Walnut frame: optional inlay engraving

- Machine: CNC router or diode laser
- Tool: 1/8 in V-bit (60 deg) for V-carve, OR diode laser for surface engraving
- Workholding: Same fixture as OP-220
- Datum: Same as OP-220
- Inputs: `drawing-brief.md`
- Outputs: Decorated rails (optional)
- Checks:
  - Engraving depth consistent across rail run.
  - No splintering or burn marks.
- Notes: Per workbook row 115, optional Broinwood-style decorative inlay or laser-engraved logo. Skip for the pilot build.

### OP-240 — Walnut frame: drill stainless rod and fastener holes

- Machine: CNC router or drill press
- Tool: 1/8 in drill bit (rod hole), pilot bits matched to selected fasteners
- Workholding: End-cap fixture or rail-end fixture
- Datum: Rail end face, rail centerline
- Inputs: `drawings/mounting-detail.svg`, `cad/sw-global-variables.csv`
- Outputs: Through-drilled rails and end caps
- Checks:
  - Rod hole diameter `0.140 +/- 0.005 in` (1/8 in nominal plus clearance).
  - Fastener holes match the selected hardware.
  - End-cap holes align with rail holes.
  - Slip-fit verified with the actual stainless rod before assembly.

### OP-300 — Mounting prototype rig (durometer pilot)

- Machine: Bench
- Tool: Three short walnut blocks (drilled and pocketed), three durometer grommets, paracord, 1/8 in stainless rod
- Workholding: Bench-top assembly
- Datum: Block centerline
- Inputs: `bom.csv`, `drawings/mounting-detail.svg`
- Outputs: Sustain and pitch-shift data per durometer
- Checks:
  - Sustain >= 75% of flat-bar sustain.
  - Pitch shift <= 5 cents from flat-bar measurement.
  - No buzz at three dynamic levels (soft / medium / loud).

### OP-400 — Frame assembly and bar mounting

- Machine: Bench
- Tool: Drivers, awl, scissors (paracord), tuner, mallets
- Workholding: Frame on workbench
- Datum: Frame centerline, end-cap reference
- Inputs: `assembly-manual.md`, `drawings/frame-layout.svg`, `drawings/mounting-detail.svg`
- Outputs: Assembled glockenspiel
- Checks:
  - All bars seated in grommet pockets.
  - Cord captures every bar at both node holes.
  - No metal-on-metal contact.
  - Stainless rod clears bars by at least 0.1 in.

### OP-500 — Final validation and release

- Machine: Bench
- Tool: Chromatic tuner, microphone, calipers, mallets (hard rubber default + brass upgrade), camera
- Workholding: Assembled instrument on stable stand
- Datum: Same support and strike datum used for every note
- Inputs: `validation.csv`, `photo-shotlist.md`
- Outputs: Updated `validation.csv`, process photos
- Checks:
  - Every framed bar within `+/- 5 cents` at soft dynamics.
  - No persistent buzz at soft / medium / loud dynamics on any bar.
  - Sustain consistent across the row to within 30%.

## Release Checks

- Every operation has a datum and workholding method.
- Every tool has a real machine available or an escalation note.
- All tuning-critical features include trim allowance.
- C5/A5/C7 pilot data is reviewed before cutting all 25 bars.
- Grommet durometer is selected from pilot data, not assumed.
- `validation.csv` receives measured data after the first prototype.
- K_eff is updated in `family-spec.csv` if it differs from workbook K by more than 5%.
