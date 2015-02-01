// Main geometry of the wedge
wedge_length = 188;
wedge_width = 75;
heigth_front = 4;
heigth_back = 21;
wedge_angle = 5.2;		// found by trial and error

// Mounting part
mount_length = 70;
mount_width = 18;
mount_height = 2.25;

// distance between the back and 1st socket(from the back)
dist_back_1 = 2;

// hole 1 dimensions
hole1_length = 12;
hole1_width = 5.5;
hole1_height = mount_height + 1;

// distance between the 1st and 2nd socket(from the back)
dist_1_2 = 2.5;

// hole 2 dimensions
hole2_length = 9.5;
hole2_width = 4.75;
hole2_height = mount_height + 1;

// distance between the 2nd and 3rd socket(from the back)
dist_2_3 = 12;

// hole 3 dimensions
hole3_length = 21;
hole3_width = 5.25;
hole3_height = mount_height + 1;

// Some output for quick measuring (in german)
// plus some stupid spacing alignment
echo(str ("Abstand Loch 1 zum hinteren Ende :", dist_back_1));
echo(str ("Länge Loch 1                                   : ", hole1_length));
echo(str ("Abstand Loch 2 zu Loch 1                : ", dist_1_2));
echo(str ("Länge Loch 2                                   : ", hole2_length));
echo(str ("Abstand Loch 2 zu Loch 3                : ", dist_2_3));
echo(str ("Länge Loch 3                                   : ", hole3_length));
echo(str ("Rest                                                 : ", 
	 mount_length - dist_back_1 - hole1_length - dist_1_2 - hole2_length - dist_2_3 - hole3_length));


// wedge : 

// rotate it so it's resting on it's top
//rotate([0,180,0])

// rotate it so it's even on the ground
//rotate([-wedge_angle, 0, 0])

difference() {
	union() {
		difference() {
			// main cube which is reduced bit by bit
			cube(size = [wedge_width, wedge_length, heigth_back + mount_height], center = false);
			// 
			union() {
				// subtraction of the upper pitch
				// x : -0.5 for clear edges
				// z : offset since it has some heigth in the front + the heigth of the mount
				translate([-0.5, 0, heigth_front + mount_height])
					rotate([wedge_angle, 0, 0])
						// x : + 1 for clear edges
						// y : + 5 just to be sure
						// z : 25 just to be sure
						cube(size = [wedge_width + 1, wedge_length + 5, 25], center = false);
				// subtraction of the back pitch
				// x : -0.5 for clear edges
				// y : to start at the back end of the wedge
				translate([-0.5, wedge_length, 0])
					rotate([wedge_angle, 0, 0])
						// x : + 1 for clear edges
						// y : 5 just to be sure 
						// z : 25 just to be sure
						cube(size = [wedge_width + 1, 5, 25], center = false);
			}
		}

		difference() {
			rotate([wedge_angle, 0, 0])
				translate([- (mount_width / 2), wedge_length - mount_length - 0.775, heigth_front])
					cube(size = [mount_width, mount_length, mount_height]);
			union() {

				rotate([wedge_angle, 0, 0])
					//translate([-(hole1_width + 1), wedge_length - 0.775 - (hole1_length + 2), heigth_front - 0.5])
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - (hole1_length + dist_back_1), heigth_front - 0.5])
						cube(size = [hole1_width, hole1_length, hole1_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + hole2_length + dist_1_2), heigth_front - 0.5])
						cube(size = [hole2_width, hole2_length, hole2_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 0.5])
						cube(size = [hole3_width, hole3_length, hole3_height]);
				rotate([wedge_angle, 0, 0])
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 2])
						cube(size = [hole1_width, hole1_length + dist_1_2 + hole2_length + dist_2_3 + hole3_length, 3.25]);
			}
		}
	}
	union() {
		// Abschneiden vorne
				translate([-(0.5 +mount_width / 2), -0.5, -0.5])
					cube([wedge_width + mount_width / 2 + 1,wedge_length - mount_length - 1, 20 ]);
				// Abschneiden rechts
				//translate([mount_width / 2, wedge_length - mount_length - 2, -0.5])
					//cube([wedge_width + 0.5, mount_length + 10, 25]);
				translate([57, wedge_length - mount_length - 2, -0.5])
					cube([wedge_width - 57 + 0.5, mount_length + 10, 25]);
	}

}
// part on top of the wedge (too complicated too print the whole thing in one part)
// could be redone more elaborate with an identation so the right part of the 
// laptop can't be moved back and forth.
translate([wedge_width + 10, wedge_length, 0])
	// dimensions by trial and error
	cube([24,24,4]);
