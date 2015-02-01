// Main geometry of the wedge
wedge_length = 188;
wedge_width = 75;
heigth_front = 4;
heigth_back = 21;
wedge_angle = 5.2;

// Mounting part
halterung_length = 70;
halterung_width = 18;
halterung_height = 2.25;

// hole 1
hole1_length = 12;
hole1_width = 5.5;
hole1_height = halterung_height + 1;

dist_back_1 = 2;
dist_1_2 = 2.5;
dist_2_3 = 12;

hole2_length = 9.5;
hole2_width = 4.75;
hole2_height = halterung_height + 1;

hole3_length = 21;
hole3_width = 5.25;
hole3_height = halterung_height + 1;

echo(str ("Abstand Loch 1 zum hinteren Ende :", dist_back_1));
echo(str ("Länge Loch 1                                   : ", hole1_length));
echo(str ("Abstand Loch 2 zu Loch 1                : ", dist_1_2));
echo(str ("Länge Loch 2                                   : ", hole2_length));
echo(str ("Abstand Loch 2 zu Loch 3                : ", dist_2_3));
echo(str ("Länge Loch 3                                   : ", hole3_length));
echo(str ("Rest                                                 : ", 70 - dist_back_1 - hole1_length - dist_1_2 - hole2_length - dist_2_3 - hole3_length));


// Schräge
rotate([0,180,0])
rotate([-wedge_angle, 0, 0])
difference() {
	union() {
		difference() {
			cube(size = [wedge_width, wedge_length, heigth_back + halterung_height], center = false);
			union() {
				// Schräge oben
				translate([-0.5, 0, heigth_front + halterung_height])
					rotate([wedge_angle, 0, 0]) 
						cube(size = [wedge_width + 1, wedge_length + 5, 25], center = false);
				// Schräge hinten
				translate([-0.5, wedge_length, 0])
					rotate([wedge_angle, 0, 0])
						cube(size = [wedge_width + 1, 5, 25], center = false);
			}
		}

		difference() {
			rotate([wedge_angle, 0, 0])
				translate([- (halterung_width / 2), wedge_length - halterung_length - 0.775, heigth_front])
					cube(size = [halterung_width, halterung_length, halterung_height]);
			union() {

				rotate([wedge_angle, 0, 0])
					//translate([-(hole1_width + 1), wedge_length - 0.775 - (hole1_length + 2), heigth_front - 0.5])
					translate([-(halterung_width / 2 - 3), wedge_length - 0.775 - (hole1_length + dist_back_1), heigth_front - 0.5])
						cube(size = [hole1_width, hole1_length, hole1_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(halterung_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + hole2_length + dist_1_2), heigth_front - 0.5])
						cube(size = [hole2_width, hole2_length, hole2_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(halterung_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 0.5])
						cube(size = [hole3_width, hole3_length, hole3_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(halterung_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 2])
						cube(size = [hole1_width, hole1_length + dist_1_2 + hole2_length + dist_2_3 + hole3_length, 3.25]);
			}
		}
	}
	union() {
		// Abschneiden vorne
				translate([-(0.5 +halterung_width / 2), -0.5, -0.5])
					cube([wedge_width + halterung_width / 2 + 1,wedge_length - halterung_length - 1, 20 ]);
				// Abschneiden rechts
				//translate([halterung_width / 2, wedge_length - halterung_length - 2, -0.5])
					//cube([wedge_width + 0.5, halterung_length + 10, 25]);
				translate([57, wedge_length - halterung_length - 2, -0.5])
					cube([wedge_width - 57 + 0.5, halterung_length + 10, 25]);
	}

}
// Aufsatz
//cube([24,24,4]);
