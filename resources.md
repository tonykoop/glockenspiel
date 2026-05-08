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
