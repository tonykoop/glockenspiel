(* Glockenspiel free-free metal beam model package.
   Source: workbook §5 "Executable Cells" (rows 152-156).
   Skill: instrument-maker-v4 v4.3.

   This package gives kMetal[E,rho], lBar[f,t,K], a Manipulate over material
   and dimensions, and a validation plot scaffold. All formulas use imperial
   K (t and L in inches, f in Hz). E in Pa, rho in kg/m^3.
*)

BeginPackage["Glockenspiel`"];

kMetal::usage = "kMetal[E_, rho_] gives the imperial K constant for a free-free beam in mode 1, with E in Pa and rho in kg/m^3.";
lBar::usage = "lBar[f_, t_, K_] gives the predicted bar length in inches for target frequency f (Hz), thickness t (inches), and material constant K.";
fBar::usage = "fBar[L_, t_, K_] gives the predicted first-mode frequency in Hz for bar length L (in), thickness t (in), and material constant K.";
centsError::usage = "centsError[measured_, target_] returns the cents error of measured frequency vs target.";
nodePositions::usage = "nodePositions[L_] returns {0.2242 L, 0.7758 L}.";

Begin["`Private`"];

kMetal[E_, rho_] := (4.730^2 / (2 Pi)) * Sqrt[E / (12 rho)] / 0.0254

lBar[f_, t_, K_] := Sqrt[K t / f]

fBar[L_, t_, K_] := K t / L^2

centsError[measured_, target_] := 1200 * Log[2, measured / target]

nodePositions[L_] := {0.2242 L, 0.7758 L}

End[];
EndPackage[];

(* ----- Material library (workbook rows 14-20) ----- *)

materials = <|
  "6061-T6 Aluminum" -> <| "E" -> 68.9 10^9, "rho" -> 2700, "K" -> Glockenspiel`kMetal[68.9 10^9, 2700] |>,
  "Brass C260" -> <| "E" -> 110 10^9, "rho" -> 8530, "K" -> Glockenspiel`kMetal[110 10^9, 8530] |>,
  "Steel 1018" -> <| "E" -> 200 10^9, "rho" -> 7850, "K" -> Glockenspiel`kMetal[200 10^9, 7850] |>,
  "304 Stainless" -> <| "E" -> 193 10^9, "rho" -> 8000, "K" -> Glockenspiel`kMetal[193 10^9, 8000] |>,
  "Phosphor Bronze" -> <| "E" -> 110 10^9, "rho" -> 8860, "K" -> Glockenspiel`kMetal[110 10^9, 8860] |>
|>;

(* Sanity check vs workbook K table *)
Print["Material K sanity check (compare to workbook D16-D20):"];
KeyValueMap[
  Function[{name, props}, Print[name, " K = ", Round[props["K"], 1]]],
  materials
];

(* ----- Manipulate: explore length vs frequency over material + thickness ----- *)

Manipulate[
  Module[{K = materials[mat]["K"], L},
    L = Glockenspiel`lBar[freq, thick, K];
    Column[{
      Row[{"K = ", Round[K, 1], " (imperial)"}],
      Row[{"target freq = ", freq, " Hz"}],
      Row[{"bar length = ", NumberForm[L, {6, 3}], " in"}],
      Row[{"node positions = ", NumberForm[Glockenspiel`nodePositions[L], {6, 3}], " in"}]
    }]
  ],
  {{mat, "6061-T6 Aluminum", "Material"}, Keys[materials]},
  {{freq, 880, "Frequency (Hz)"}, 200, 3000, 1},
  {{thick, 0.25, "Thickness (in)"}, 0.125, 0.5, 0.0625}
]

(* ----- Validation plot scaffold ----- *)

(* Once validation.csv has measured data, plot predicted vs measured: *)

ImportValidation[path_String] := Module[{data},
  data = Import[path, "CSV"];
  data
];

PlotPredictedVsMeasured[validationData_] := Module[{rows, points},
  rows = Select[validationData, (Length[#] >= 7 && #[[6]] =!= "" && #[[5]] === "post_trim") &];
  points = Map[{ToExpression[#[[3]]], ToExpression[#[[6]]]} &, rows];
  ListPlot[points,
    AxesLabel -> {"Target Hz", "Measured Hz"},
    PlotLabel -> "Glockenspiel: target vs measured at post_trim",
    Epilog -> {Line[{{200, 200}, {2500, 2500}}]}
  ]
];

(* Audio preview (uses Wolfram's MIDI synthesis as a placeholder; real bar tone is bell-like) *)

PreviewChromatic[] := Sound[
  Table[
    SoundNote["MIDI", midi, 0.5],
    {midi, 72, 96}
  ]
];

PreviewPentatonic[] := Sound[
  Table[
    SoundNote["MIDI", midi, 0.5],
    {midi, {72, 74, 76, 79, 81, 84, 86, 88, 91, 93}}
  ]
];

(* CreateDocument entry point for an interactive notebook *)

CreateGlockenspielNotebook[] := CreateDocument[{
  TextCell["Glockenspiel — Free-Free Metal Beam Explorer", "Title"],
  TextCell["Interactive: change material, frequency, thickness; see length and node positions.", "Subtitle"],
  ExpressionCell[
    Manipulate[
      Module[{K = materials[mat]["K"], L = Glockenspiel`lBar[freq, thick, materials[mat]["K"]]},
        Column[{
          Row[{"K = ", Round[K, 1]}],
          Row[{"length = ", NumberForm[L, {6, 3}], " in"}],
          Row[{"nodes = ", NumberForm[Glockenspiel`nodePositions[L], {6, 3}]}]
        }]
      ],
      {{mat, "6061-T6 Aluminum"}, Keys[materials]},
      {{freq, 880}, 200, 3000, 1},
      {{thick, 0.25}, 0.125, 0.5, 0.0625}
    ],
    "Input"
  ]
}];

(* ===== CloudDeploy entry point: bare, self-contained Manipulate ===== *)
(* This is the FINAL top-level expression so Get[]/CloudDeploy yields a   *)
(* Manipulate object directly. It reuses the package functions            *)
(* Glockenspiel`lBar and Glockenspiel`nodePositions plus the Global       *)
(* `materials` association, and ships them via SaveDefinitions -> True.    *)
(* All outputs are EMPIRICAL ESTIMATES from the free-free beam model.      *)

Manipulate[
  Module[
    {K = materials[mat]["K"], L, nodes},
    L = Glockenspiel`lBar[freq, thick, K];
    nodes = Glockenspiel`nodePositions[L];
    Column[{
      Style["Glockenspiel bar — EMPIRICAL ESTIMATES (free-free beam model)", Bold],
      Grid[
        {
          {"Material", mat},
          {"Material constant K (imperial)", Round[K, 1]},
          {"Target frequency (Hz)", freq},
          {"Bar thickness (in)", thick},
          {"Estimated bar length (in)", NumberForm[L, {6, 3}]},
          {"Estimated node positions (in)", NumberForm[nodes, {6, 3}]}
        },
        Alignment -> Left,
        Frame -> All,
        Spacings -> {2, 1}
      ],
      Style["Estimates only — confirm by measurement and trim-to-tune.", Italic, Gray]
    }]
  ],
  {{mat, "6061-T6 Aluminum", "Material"}, Keys[materials]},
  {{freq, 880, "Target frequency (Hz)"}, 200, 3000, 1},
  {{thick, 0.25, "Thickness (in)"}, 0.125, 0.5, 0.0625},
  ControlPlacement -> Left,
  SaveDefinitions -> True
]
