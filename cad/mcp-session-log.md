<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# MCP / External-Tool Session Log

V5 provenance record for artifacts generated or modified by external tools.
Required before claiming any artifact came from OpenSCAD, Blender,
Illustrator, Photoshop, Fusion, SketchUp, or similar tooling.

This file did not exist prior to the 2026-07-01 V5 refresh, even though
fabrication-authority artifacts (`glockenspiel-design-table.xlsx`,
`family-spec.csv`, `cad/glockenspiel-master.scad`,
`cad/SolidWorks-MasterLayout-Plan.md`) already existed in the repo from
earlier rounds. This log backfills provenance for those pre-existing
artifacts and records the 2026-07-01 refresh pass.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
|---|---|---|---|---|---|---|---|
| pre-2026-07-01-backfill | unknown (pre-V5-refresh round) | design.md governing model (free-free beam, `f ~= K*t/L^2`) | glockenspiel-design-table.xlsx, family-spec.csv, cad/glockenspiel-master.scad, cad/SolidWorks-MasterLayout-Plan.md | cad_authoring | pending_measurement | self_checked | Backfilled provenance row for artifacts authored before this log existed. Bar schedule and OpenSCAD starter reviewed against design.md; no bar has been cut or measured. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | glockenspiel-design-table.xlsx, family-spec.csv, design.md | cad/glockenspiel-master.scad | cad_authoring | pending_measurement | self_checked | Kept existing parametric master unchanged (no rewrite per V5 idiophones addendum — existing `cad/*-master.scad` satisfies the parametric CAD source requirement). OpenSCAD render check: pass (openscad -o STL, exit 0). |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | glockenspiel-design-table.xlsx | glockenspiel-design-table.xlsx, family-spec.csv, bom.csv, sourcing.csv, cut-list.csv, validation.csv | packet_refresh | fabrication | self_checked | V5 refresh pass: added this provenance log; reviewed tabular packet data against design-table baseline; no dimension changes made. Row added to satisfy V5 fabrication-artifact logging requirement. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | design.md | wolfram/glockenspiel-wolfram-model.wl, glockenspiel-starter.wl | analysis_source | derived_preview | unreviewed | Pre-existing Wolfram source verified present and registered; not executed; source-only evidence at L2. |
