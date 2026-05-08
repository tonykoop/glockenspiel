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
