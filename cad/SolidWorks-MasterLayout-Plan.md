# SolidWorks MasterLayout Plan — Glockenspiel

## Goal

Capture the build-table-and-equation contract for a future native SolidWorks model of the C5-C7 chromatic glockenspiel. No native SW files are committed yet; this document plus `cad/sw-global-variables.csv` and `cad/design-table-inputs.csv` are the contract Tony uses to build the SW model.

## Pillars

Per `references/solidworks-integration.md`, the SW model rests on three pillars:

1. **Global equations** — driven from `cad/sw-global-variables.csv`. Variables that are constant across all bars (K constant, thickness, node ratios, hole diameter) live as global equations.
2. **Design table** — driven from `cad/design-table-inputs.csv`. One row per configuration (one configuration per chromatic note), with member_id, length, width, node positions, and target Hz.
3. **Master sketch** — `Master_Bar` part with a top-down sketch driven by the design-table dimensions, plus a `Frame_MasterLayout` sketch defining rail centerlines, bar spacing, and player-side datum.

## Parts

| Part | Purpose | Driven by |
| --- | --- | --- |
| `Master_Bar.SLDPRT` | One configuration per chromatic note (25 configs); generates per-bar STEP/SVG via design-table iteration. | `design-table-inputs.csv` |
| `Master_Frame_Rail.SLDPRT` | Front and back rails as configurations; differs in depth and grommet-pocket count. | Global variables + bar count parameter |
| `Master_Frame_Endcap.SLDPRT` | End cap with stainless-rod hole and rail joinery. | Global variables |
| `Glockenspiel_Assembly.SLDASM` | Top-level assembly referencing 25 bars + 2 rails + 2 end caps + cord/grommet/rod hardware. | Master parts and design table |

## Mate / Reference Discipline

- Every bar configuration is mated to its node positions on the front or back rail's centerline sketch.
- Naturals (15 configs) → front rail; sharps/flats (10 configs) → back rail offset 0.5 in.
- Cord, grommets, and stainless rod are simplified geometry (single `cord_path` sketch) — not modeled per-bar to keep the assembly light.

## Equations

```text
"D@thickness"@Master_Bar = 0.25
"D@width"@Master_Bar = 1.0
"D@K_constant"@Master_Bar = 204431
"D@bar_spacing"@Frame_MasterLayout = 1.25
"D@accidental_offset"@Frame_MasterLayout = 0.5
```

The bar `length_in` and `node_1_in`/`node_2_in` are NOT global equations; they are design-table-driven per configuration.

## Macro Hooks

- `Extract_Dimensions.swp` (per `references/solidworks-integration.md`) can dump dimension values to `cad/sw-extracted-dimensions.csv` for round-trip validation against `family-spec.csv` via `scripts/ingest_dimension_csv.py`.
- `scripts/generate_sw_design_table.py` can emit a fresh `cad/sw-design-table.xlsx` from `family-spec.csv` whenever the K constant or scale changes.

## Open Questions

- Whether to model the cord and grommets as simplified geometry or skip them entirely in the SW assembly.
- Whether to commit STEP exports from the design-table iteration (one STEP per configuration) or produce them on demand.
- Whether the alternate-metal variants (Brass, Steel, SS, Phosphor Bronze) get distinct top-level assemblies or share the chromatic master with a different K global value.
