// Glockenspiel OpenSCAD starter.
// Build-critical dimensions live in family-spec.csv and CAD CSV files.
// This starter is for visual/spacing review and CAM mock-ups, not final tuning.
//
// No arch undercut, no resonator tubes (per design.md). Bars are flat metal stock.

$fn = 48;

function inch(x) = x * 25.4;

// Default parameters (6061-T6 Aluminum, workbook defaults)
default_thickness_in = 0.25;
default_width_in = 1.0;
default_node_hole_in = 0.1875;

module bar(length_in, width_in, thickness_in, node_1_in, node_2_in, node_hole_in = default_node_hole_in) {
    length = inch(length_in);
    width = inch(width_in);
    thickness = inch(thickness_in);
    n1 = inch(node_1_in);
    n2 = inch(node_2_in);
    node_hole = inch(node_hole_in);

    difference() {
        cube([length, width, thickness], center=false);

        // Node hole 1
        translate([n1, width / 2, -1])
            cylinder(h = thickness + 2, d = node_hole, center=false);

        // Node hole 2
        translate([n2, width / 2, -1])
            cylinder(h = thickness + 2, d = node_hole, center=false);
    }
}

module frame_rail(length_in, depth_in, thickness_in, num_bars) {
    // Walnut rail with grommet pockets and stainless rod hole
    length = inch(length_in);
    depth = inch(depth_in);
    thickness = inch(thickness_in);
    rod_dia = inch(0.140); // 1/8" rod plus clearance

    difference() {
        cube([length, depth, thickness], center=false);

        // Stainless rod through-hole, ~1/3 from rail bottom
        translate([-1, depth / 2, thickness / 3])
            rotate([0, 90, 0])
                cylinder(h = length + 2, d = rod_dia, center=false);

        // Grommet pockets (one per bar) on rail top
        for (i = [0 : num_bars - 1]) {
            x = inch(1.0) + i * inch(1.25);
            translate([x, depth / 2, thickness - inch(0.15)])
                cylinder(h = inch(0.30), d = inch(0.45), center=false);
        }
    }
}

// Representative configurations: pilot bars C5, A5, C7
// Use cad/design-table-inputs.csv for the full chromatic configuration set.
translate([0, 0, 0])
    bar(9.883, 1.000, 0.250, 2.216, 7.667); // GLK-C5

translate([0, inch(2.0), 0])
    bar(7.621, 1.000, 0.250, 1.709, 5.912); // GLK-A5

translate([0, inch(4.0), 0])
    bar(4.941, 1.000, 0.250, 1.108, 3.834); // GLK-C7

// Front rail (naturals row, 15 bars)
translate([0, inch(8.0), 0])
    frame_rail(33.25, 2.5, 0.75, 15);

// Back rail (sharps/flats, 10 bars, raised on spacer)
translate([0, inch(11.5), inch(0.5)])
    frame_rail(33.25, 2.0, 0.75, 10);
