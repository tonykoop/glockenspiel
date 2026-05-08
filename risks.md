# Glockenspiel Risk Register

## Acoustic Risks

### Bar pitch misses workbook prediction (K-constant variance)

- Risk: Selected 6061-T6 aluminum stock has a different effective K than the workbook value of 204431. Heat-treat condition (T6 vs T4 vs annealed), extrusion vs sawn flat-bar, cold-work history, and dimensional tolerance all shift effective K by 5-10%.
- Impact: Every bar cut to `predicted_length_in` lands sharp or flat by a consistent amount; without trim allowance the entire batch is scrap.
- Test: Cut C5, A5, C7 pilot bars cut-long by 0.25 in. Mount on foam at nodes. Compute `K_eff = f * L^2 / t` from measured Hz.
- Pass criterion: Pilot K_eff differs from workbook K by less than 5%, or the workbook K is updated to match before the remaining 22 bars are cut.
- Mitigation: Always cut bars at predicted length + 0.25 in. Tune by removing material from both ends. Update `family-spec.csv` and workbook B21 with the calibrated K.

### Mounting damps fundamental or kills sustain

- Risk: Rubber grommet durometer, cord tension, or stainless support rod contact damps the free-free first mode. Free-free bars require contact only at the nodes; any contact away from the node line shortens sustain.
- Impact: Bars sound dead, sustain drops below 1 second, or pitch shifts flat under load.
- Test: Pilot each grommet candidate (Shore 30A, 50A, 70A) on C5/A5/C7. Measure sustain to first 6 dB drop after a moderate strike.
- Pass criterion: Sustain >= 3 s for C5 fundamental, >= 1.5 s for A5, >= 0.8 s for C7. Pitch shift under mounting <= 5 cents from flat-bar measurement.
- Mitigation: Soften grommets, increase node-hole diameter, or relocate the support rod so it does not contact the bar between nodes.

### Striker hardness produces unwanted timbre

- Risk: Brass strikers on aluminum bars produce a harsh, ear-piercing attack at C7 frequencies (above 2 kHz).
- Impact: Player or audience experiences listening fatigue; instrument is unpleasant in small rooms.
- Test: Strike each pilot bar with brass, hard rubber, and lexan strikers. Record perceived timbre and decay.
- Pass criterion: At least one striker option produces a tone judged "musical" rather than "harsh" by two listeners in the build space.
- Mitigation: Ship the instrument with hard-rubber strikers as the default and brass as an optional upgrade; document the trade-off in the assembly manual.

## Structural Risks

### Drilling node holes splits or burrs the aluminum

- Risk: Drilling 3/16 in holes through 1/4 in flat bar without proper backing causes burr-up, edge tear-out, or work-hardening.
- Impact: Cracked bar, rough hole, asymmetric mounting, audible buzz at the node.
- Test: Drill sample holes in offcut aluminum with the intended bit and backing board. Inspect for clean entry/exit and freedom from burrs.
- Pass criterion: Clean holes, no visible burrs after deburring, no cracks visible under magnification.
- Mitigation: Use a sharp HSS or carbide bit, peck-drill through hardwood backer, deburr both faces, lubricate with cutting fluid.

### Bar-to-stainless-rod metal contact buzz

- Risk: 1/8 in stainless support rod contacts the underside of a bar between the cord supports, causing audible buzz at moderate-to-loud strike intensity.
- Impact: Metallic rattle on every strike; instrument is unusable for performance.
- Test: Strike each bar at three dynamic levels (soft, medium, loud) on the assembled frame.
- Pass criterion: No audible rattle or buzz at any dynamic.
- Mitigation: Lower the stainless rod relative to the bar, add a continuous foam strip on top of the rod, or remove the rod and rely on cord-only mounting.

## Ergonomic Risks

### Frame too wide for player reach

- Risk: 25-bar chromatic frame is about 33 in wide. With sharps in a back row offset 0.5 in higher, the playing surface depth approaches 4 in.
- Impact: Player cannot reach center bars without leaning; mallet strikes lose accuracy at the edges.
- Test: Tape a full-size bar layout on a bench and have the intended player reach every bar from a normal stance.
- Pass criterion: All 25 bars reachable without shoulder strain in less than 1 second per note.
- Mitigation: Reduce range to two octaves (C5-C6, 13 bars), use the pentatonic 10-bar variant, or split the chromatic into a stacked / curved frame.

### Mallet handle length wrong for table-height frame

- Risk: Stock 8-10 in mallet handles assume the frame sits at standing-shop-bench height (~36 in). A seated player at a 30 in table will overshoot strikes.
- Impact: Inconsistent attack; player cannot control dynamics.
- Test: Strike each bar at the intended playing surface height; measure mallet head trajectory.
- Pass criterion: Mallet head can land flat on the bar center without forearm strain.
- Mitigation: Provide both handle lengths, or specify the intended playing surface height in the BOM.

## Supply Risks

### Aluminum stock lot variation

- Risk: Different mill lots of 6061-T6 1/4 in x 1 in flat bar carry slightly different temper and effective K. A second build using a new lot can produce systematically different pitches.
- Impact: Second-batch instrument plays out of tune relative to first.
- Test: Each new aluminum lot triggers a fresh K-calibration pilot (C5/A5/C7 only).
- Pass criterion: Each lot's K_eff is documented in `validation.csv` and `family-spec.csv` is updated before the run.
- Mitigation: Treat K as a per-lot parameter. Buy enough stock for a complete instrument from one mill lot.

### Walnut frame stock availability

- Risk: Clear straight-grain Black Walnut for the CNC-routed frame may be expensive or out of stock locally.
- Impact: Build delay or fall-back to a less attractive frame wood.
- Test: Quote walnut, hard maple, cherry from local hardwood dealers before committing.
- Pass criterion: Selected wood available within the build's lead-time budget at acceptable cost.
- Mitigation: Hard maple is an acceptable substitute for the frame; cherry works if walnut is unavailable. None of these affect bar tuning.

### Metal supplier substitution risk (alternative metals)

- Risk: If the user switches from aluminum to brass / steel / stainless / phosphor bronze, the K constant changes by up to 30%. Reusing a packet computed for aluminum produces wildly wrong lengths.
- Impact: Whole-batch scrap.
- Test: Verify `material` and `k_constant` columns in `family-spec.csv` match the actual metal before any cutting.
- Pass criterion: Metal name and K constant match.
- Mitigation: Regenerate `family-spec.csv` from the workbook with the new K value before cutting. Document the swap in `validation.csv` notes.

## Fit And Finish Risks

### Clear-coat finish detunes bars

- Risk: Lacquer or clear coat on aluminum adds mass and damping; pitch can drop 3-10 cents and sustain can shorten.
- Impact: Bars finished after tuning play flat.
- Test: Apply finish to one offcut and one tuned sacrificial bar. Measure Hz before and after.
- Pass criterion: Pitch shift predictable within +/- 5 cents and within final tuning allowance.
- Mitigation: Use a thin finish, tune after finish, or leave bars raw with periodic light polish.

### Frame buzz from loose hardware

- Risk: Wood screws, threaded inserts, washers, or rubber feet rattle against the frame at moderate-to-loud strikes.
- Impact: Buzz on every strike; instrument fails final validation.
- Test: Strike every bar at soft / medium / loud dynamics on the fully assembled frame; listen for any non-bar sound source.
- Pass criterion: No audible buzz at any dynamic.
- Mitigation: Add thread-locker, soft washers, or felt pads under hardware. Replace rubber feet if they shed grip on the playing surface.
