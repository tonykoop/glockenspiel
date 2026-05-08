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
