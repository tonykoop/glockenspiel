# Glockenspiel

Root-mode v4.3 public-review build packet for a 25-bar chromatic
glockenspiel / metallophone, C5 to C7, with a smaller C-major pentatonic
art-fair variant. The design uses 6061-T6 aluminum flat bars on a CNC-routed
walnut frame with cord-and-grommet free-free suspension.

Part of the [tonykoop/instrument-maker](https://github.com/tonykoop/instrument-maker)
catalogue. Sister repos: [xylophone](https://github.com/tonykoop/xylophone),
[tubular-bells](https://github.com/tonykoop/tubular-bells),
[cajon](https://github.com/tonykoop/cajon), and
[rainstick](https://github.com/tonykoop/rainstick).

## Status

This repo is an L2 design and sourcing handoff, not a build-ready L3 packet.
The bar schedule, frame plan, CAD/CNC handoffs, sourcing tables, validation
workflow, capstone deck, print packet, and static site are present for human
review. No bar has been cut, struck, mounted, or measured yet; all pitch values
are predictions until `validation.csv` contains pilot data.

The first physical pass should cut only three pilot bars: C5, A5, and C7. Cut
them long, measure them on soft node supports, compute effective K for the
actual stock lot, then update the family table before cutting the full set.

## Design Overview

- **Family:** 25 chromatic bars from C5 to C7 plus a 10-bar C-major pentatonic
  variant for short workshop or art-fair builds.
- **Governing model:** free-free metal beam in the first flexural mode,
  `f ~= K * t / L^2`, with node holes at 22.4 percent and 77.6 percent of bar
  length.
- **Primary material:** 6061-T6 aluminum, 0.250 in thick by 1.000 in wide.
  Brass, steel, stainless, and phosphor bronze alternatives are documented in
  `design.md`.
- **Frame:** black-walnut piano-keyboard layout with naturals forward, sharps
  raised behind, and stainless support rods as travel restraints.
- **Mounting:** paracord or low-stretch nylon through drilled node holes,
  supported on rubber grommets. Grommet durometer remains a pilot-build test.
- **Tuning:** cut long, measure, recalibrate K if needed, then trim ends
  symmetrically to pitch. Do not apply flute, Helmholtz, or cantilever
  empirical corrections to this free-free metal-beam model.

## Packet Map

| File / folder | What it is |
|---|---|
| `glockenspiel-design-table.xlsx` | Parametric workbook source for the active family. |
| `design.md` | Governing model, material matrix, bar schedule, frame layout, validation plan, and assumptions. |
| `family-spec.csv` | 25-bar chromatic schedule plus 10-bar pentatonic variant. |
| `bom.csv`, `sourcing.csv`, `cut-list.csv` | Build bill of materials, supplier-ready specs, and cut operations. |
| `validation.csv` | Pilot and full-family measurement workflow for flat, drilled, mounted, and framed phases. |
| `assembly-manual.md` | Step-by-step fabrication and assembly notes. |
| `supplier-rfq.md` | RFQ draft for bar stock, frame stock, grommets, cord, rods, and mallets. |
| `drawing-brief.md`, `visual-bom-brief.md` | Drawing and visual BOM requirements. |
| `wolfram-starter.wl` | Parametric notebook starter for bar length, node, and validation plots. |
| `risks.md` | Red-team review of tuning, mounting, sourcing, safety, and release risks. |
| `jig-decision.md`, `resources.md` | v4.3 manufacturing-decision adjuncts and public-safe references. |
| `cad/` | OpenSCAD starter, SolidWorks master-layout plan, and design-table inputs. |
| `cnc/` | CNC operation graph and setup sheet for the walnut frame and fixtures. |
| `drawings/` | First-cut SVG sheets for bars, frame, mounting, family overview, and visual BOM. |
| `capstone-deck.md` / `.pptx` | Recruiter-facing slide deck. |
| `print-packet.md` / `.html` / `.pdf` | Shop-printable packet. |
| `site/` | Static build-log site draft. |

## L2 Review Evidence

- `git diff --check` is expected to pass for the Round 3 packet branch.
- `python3 /home/tony/.codex/skills/instrument-maker-v4/scripts/validate_packet.py . --mode root`
  is the root-mode gate before merge review.
- Existing generated binaries (`capstone-deck.pptx` and `print-packet.pdf`)
  are included as review artifacts, but they are not evidence of measured
  tuning or build readiness.

Deferred gates:

- empirical bar K calibration from C5/A5/C7 pilot cuts
- grommet-durometer sustain comparison
- final framed tuning within the cents band in `validation.csv`
- SolidWorks-native release drawing review
- live supplier price, stock, and lead-time verification

## License

[CC BY 4.0](LICENSE) - see LICENSE for details.
