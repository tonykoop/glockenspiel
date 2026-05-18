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
- `visual-output-register.csv` (visual authority chain)
- `authority-ledger.csv` (bar/node/metallurgy/tuning evidence gates)
