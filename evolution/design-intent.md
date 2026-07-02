# Design Intent — glockenspiel rev A

- Master CAD: `cad/glockenspiel-master.scad` (sha256: 6bb210bba8452f248684d01d71052a385e7ed5c14e3fd130ca833ccd071a694d), driven by `glockenspiel-design-table.xlsx` (sha256: 0a42e519640701522017ba7fabde0a9fcf048d87f90b3904651a0452c12441e3)
- Function: 25-bar chromatic (C5-C7) free-free metal-beam idiophone with a 10-bar C-major pentatonic art-fair variant. 6061-T6 aluminum flat bars (0.25 in x 1.00 in) mounted node-to-node with cord/grommet suspension on a CNC-routed walnut piano-keyboard frame; struck bars, no arch undercut, no resonator (design.md Project Intent).
- Environment: struck idiophone, indoor use; bar pitch depends on stock lot's effective K constant, which is not yet pilot-calibrated (risks.md Bar pitch misses workbook prediction).
- Target qty: 1 (prototype, pilot-first: cut only C5/A5/C7 before the full 25-bar set). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Bar length (per note) | e.g. GLK-C5 9.883 in | cut long +0.25 in, trim to pitch | pitch accuracy | family-spec.csv predicted_length_in (design_table_backed, K not yet pilot-calibrated) |
| K constant (6061-T6 Aluminum) | 204431 | +/-5% pilot calibration gate | pitch model accuracy | design.md Governing Model; risks.md Bar pitch risk |
| Bar thickness / width | 0.250 in / 1.000 in | stock tolerance | pitch model input (`f ~= K*t/L^2`) | design.md Design Intake, family-spec.csv |
| Node hole positions | 22.4% / 77.6% of L | sustain/pitch-shift gate (<=5 cents) | mount without damping fundamental | design.md Mounting; risks.md Mounting damps fundamental |
| Grommet durometer | TBD (Shore 30A/50A/70A pilot candidates) | sustain >=3s (C5), >=1.5s (A5), >=0.8s (C7) | sustain, pitch stability | risks.md Mounting damps fundamental or kills sustain |

## Incidental (free for DFM)

- Frame cosmetic styling (walnut grain selection, finish); striker material choice (documented trade-off, not a structural gate per risks.md Striker hardness).

## Must-nots (DFM may never violate)

- Do not cut the full 25-bar set before the C5/A5/C7 pilot bars produce a measured K_eff within 5% of the workbook K (design.md, risks.md Bar pitch risk).
- Node holes must stay at the free-free model's 22.4%/77.6% positions — any support contact away from the node line is a sustain-killing defect (risks.md Mounting damps fundamental).
- Do not apply flute, Helmholtz, or cantilever empirical corrections to this free-free metal-beam model (README Design Overview).
- Drilling must use a backer board and deburr both faces to avoid cracked bars (risks.md Drilling node holes splits or burrs the aluminum).

## Material intent

- Preferred: 6061-T6 aluminum bar stock; black walnut frame; stainless support rod; rubber grommets (durometer TBD pending pilot test) — see bom.csv/sourcing.csv.
- Acceptable subs: brass, steel, stainless, phosphor bronze bar alternatives documented in design.md material matrix.
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable.
