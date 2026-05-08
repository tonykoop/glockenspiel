# Supplier RFQ - Glockenspiel C5-C7 Build

## Scope

Request quotes for one 25-bar C5-C7 chromatic glockenspiel prototype build, with optional materials for a 10-bar pentatonic art-fair variant. Prices, stock, and lead times are intentionally not assumed in this repo; verify current facts before purchasing.

## Bar Stock - Aluminum (Primary)

Please quote 6061-T6 aluminum flat bar suitable for tuned percussion bars.

Required:

- Dimensions: `0.250 in x 1.000 in` flat bar.
- Length: minimum 18 ft total per build (chromatic + pentatonic + pilot scrap).
- Temper: `T6` strongly preferred for consistent K constant.
- Surface: free of deep scratches in playing area.

Please return:

- Mill / mill lot identifier (so the K-calibration record stays traceable across rebuilds).
- Available temper variants and their K-constant impact, if known.
- Cutting service availability (longest single bar needed is 11 in cut from 12-ft stock).
- Mill cert availability for E and rho (used to recompute K_metal independently).

## Bar Stock - Alternate Metals (Optional)

Please quote alternate flat-bar options at the same `0.250 in x 1.000 in` cross-section, in lengths sufficient for one 25-bar build per metal:

| Metal | Spec | Use Case |
| --- | --- | --- |
| Brass C260 | Yellow brass C260 flat bar | Premium warm tone variant |
| Steel 1018 | Cold-rolled 1018 flat bar | Loud / sharp tone variant |
| 304 Stainless | 304 stainless steel flat bar | Outdoor / weather-resistant variant |
| Phosphor Bronze | C510 or C544 phosphor bronze flat bar | Best-sustain premium variant |

Each metal alters the K constant materially; the user will regenerate `family-spec.csv` from the workbook before cutting.

## Frame Hardwood

Please quote Black Walnut frame stock suitable for CNC-routed glockenspiel frames.

Required:

- Black Walnut, 4/4 dressed to `0.750 in` thick.
- Clear straight-grain stock; no checks in finished area.
- Minimum dimensions: enough for two rails (about `36 in x 3 in` finished) plus end caps and an optional accidental row.
- Quantity: enough for one frame plus 1 spare rail.

Acceptable substitutes (functionally equivalent for tuning purposes; aesthetics differ):

- Hard maple
- Cherry

## Hardware

Please quote:

- 550 paracord or low-stretch braided nylon cord, 4 mm diameter.
- Rubber grommets, `0.1875 in` ID, available in Shore 30A / 50A / 70A durometers (sample of three durometers required for pilot).
- 1/8 in 304 stainless steel rod in 36 in lengths (qty 2 minimum per build).
- Self-adhesive 1/2 in rubber feet (qty 4 per frame).
- Frame fastener kit: wood screws, threaded inserts, washers; prefer removable.

## Mallets

Please quote at least two pairs from the following:

- Hard rubber head (default), 1.0 in head dia, 8-10 in handle.
- Brass head (orchestral upgrade), 0.75 in head dia, 8-10 in handle.
- Lexan or Delrin head (alternate), 0.75-1.0 in head dia, 8-10 in handle.

## CNC and Bar Tooling

Please quote:

- 1/4 in carbide downcut spiral router bit, hardwood-capable.
- 1/8 in carbide upcut spiral router bit, hardwood-capable.
- 1/8 in V-bit (60 deg) for optional inlay.
- 3/16 in HSS or carbide drill bit for aluminum (brad-point or jobber).
- 80T or 100T carbide chop-saw blade for non-ferrous metals.

Include shank diameter, cut length, recommended feed/speed range, and replacement availability.

## Measurement

Please quote:

- Chromatic tuner or strobe with reliable readout up to 2.5 kHz (must read C7 = 2093 Hz). Peterson StroboClip HD or equivalent.

## Response Format

Please return:

```text
item
supplier part number
material/spec
actual dimensions / temper / lot id
quantity available
unit price
lead time
shipping estimate
notes/substitution risks
```
