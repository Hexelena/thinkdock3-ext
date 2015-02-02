// Main geometry of the wedge
wedge_length = 188;		// measured 
wedge_width = 75;		// measured
heigth_front = 4;		// measured
heigth_back = 21;		// measured
wedge_angle = 5.2;		// found by trial and error

// Mounting part
mount_length = 70;		// enough so the whole right support structure is surrounded
mount_width = 18;		// only half of that is really standing out
mount_height = 2.25;	// finetuned for better stability

// distance between the back and 1st socket(from the back)
dist_back_1 = 2;		// not exact measurements but the necessary ones for the 3D printer

// hole 1 dimensions
hole1_length = 12;		// not exact measurements but the necessary ones for the 3D printer
hole1_width = 5.5;		// not exact measurements but the necessary ones for the 3D printer
hole1_height = mount_height + 1;	// + 1 for clear cutout

// distance between the 1st and 2nd socket(from the back)
dist_1_2 = 2.5;			// not exact measurements but the necessary ones for the 3D printer

// hole 2 dimensions
hole2_length = 9.5;		// not exact measurements but the necessary ones for the 3D printer
hole2_width = 4.75;		// not exact measurements but the necessary ones for the 3D printer
hole2_height = mount_height + 1;	// + 1 for clear cutout

// distance between the 2nd and 3rd socket(from the back)
dist_2_3 = 12;			// not exact measurements but the necessary ones for the 3D printer

// hole 3 dimensions
hole3_length = 21;		// not exact measurements but the necessary ones for the 3D printer
hole3_width = 5.25;		// not exact measurements but the necessary ones for the 3D printer
hole3_height = mount_height + 1;	// + 1 for clear cutout

// Some output for quick measuring (in german)
// has some stupid spacing alignment
echo(str ("Abstand Loch 1 zum hinteren Ende :", dist_back_1));
echo(str ("Länge Loch 1                                   : ", hole1_length));
echo(str ("Abstand Loch 2 zu Loch 1                : ", dist_1_2));
echo(str ("Länge Loch 2                                   : ", hole2_length));
echo(str ("Abstand Loch 2 zu Loch 3                : ", dist_2_3));
echo(str ("Länge Loch 3                                   : ", hole3_length));
echo(str ("Rest                                                 : ", 
	 mount_length - dist_back_1 - hole1_length - dist_1_2 - hole2_length - dist_2_3 - hole3_length));


 

// rotate it so it's resting on it's top
// rotate([0,180,0])

// rotate it so it's even on the ground
// rotate([-wedge_angle, 0, 0])

difference() {
	// whole wedge with mount
	union() {
		// generates the main wedge (use ́́'́́́́́́́́́́́#' to see the different parts)
		difference() {
			// main cube which is reduced bit by bit
			cube(size = [wedge_width, wedge_length, heigth_back + mount_height], center = false);
			// taking away from the top and the back to get the shape of the 
			// original dock(plus some height for the mount)
			union() {
				// subtraction of the upper pitch
				// x : -0.5 for clear cutout
				// z : offset since it has some heigth in the front + the heigth of the mount
				translate([-0.5, 0, heigth_front + mount_height])
					rotate([wedge_angle, 0, 0])
						// x : + 1 for clear cutout
						// y : + 5 just to be sure
						// z : 25 just to be sure
						cube(size = [wedge_width + 1, wedge_length + 5, 25], center = false);
				// subtraction of the back pitch
				// x : -0.5 for clear cutout
				// y : to start at the back end of the wedge
				translate([-0.5, wedge_length, 0])
					rotate([wedge_angle, 0, 0])
						// x : + 1 for clear cutout
						// y : 5 just to be sure 
						// z : 25 just to be sure
						cube(size = [wedge_width + 1 , 5, 25], center = false);
			}
		}
		// generates the mount (use ́́'́́́́́́́́́́́#' to see the different parts)
		difference() {
			// orientation
			rotate([wedge_angle, 0, 0])
				// x : the lower left edge is the anchor so this is the necessary offset
				// y : 0.775 by trial and error. it is necessary since there is
				// a pitch at the back so the beginning of the mount is slightly off 
				// to the bottom end. could be done with tangens - was too lazy
				// z : heigth offset since the wedge has a blunt end(best understood when changde)
				translate([- (mount_width / 2), wedge_length - mount_length - 0.775, heigth_front])
					// mount dimensions
					cube(size = [mount_width, mount_length, mount_height]);
			
			// holes and cutouts in the mount
			union() {
				// first hole
				rotate([wedge_angle, 0, 0])
					// orientation from the left edge
					// x : 3 mm on the left
					// y : the hole anchor is at the bottom front left corner so 
					// we need the length - 0775(see above) - length of the parts
					// z : - 0.5 for clear cutouts
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - (hole1_length + dist_back_1), heigth_front - 0.5])
						// hole dimensions
						cube(size = [hole1_width, hole1_length, hole1_height]);
				// second hole		
				rotate([wedge_angle, 0, 0])
					// x : 3 mm on the left
					// y : the hole anchor is at the bottom front left corner so 
					// we need the length - 0775(see above) - length of the parts
					// z : - 0.5 for clear cutouts
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + hole2_length + dist_1_2), heigth_front - 0.5])
						// hole dimensions
						cube(size = [hole2_width, hole2_length, hole2_height]);
				// third hole
				rotate([wedge_angle, 0, 0])
					// x : 3 mm on the left
					// y : the hole anchor is at the bottom front left corner so 
					// we need the length - 0775(see above) - length of the parts
					// z : - 0.5 for clear cutouts
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 0.5])
						// hole dimensions
						cube(size = [hole3_width, hole3_length, hole3_height]);
				// cutout for better fitting on the socket
				// see stl or pictures for better understanding
				rotate([wedge_angle, 0, 0])
					// shall cover all holes  (use ́́'́́́́́́́́́́́#' to see it)
					// z : - 2 -> begin it beneath the mount
					translate([-(mount_width / 2 - 3), wedge_length - 0.775 - ((hole1_length + dist_back_1) + (hole2_length + dist_1_2) + hole3_length + dist_2_3), heigth_front - 2])
						cube(size = [hole1_width, hole1_length + dist_1_2 + hole2_length + dist_2_3 + hole3_length, 3.25]);
			}
		}
	}
	// taking away unneccesary parts
	union() {
		// cut in the front
		// x : - 0.5 for clear cutout / mount_width/2 to cut the mount as well
		// y : - 0.5 for clear cutout
		// z : - 0.5 for clear cutout
		translate([-(0.5 +mount_width / 2), -0.5, -0.5])
			// x : +1 for clear cutout / mount_width/2 to cut the mount as well
			// y :  
			// z :  20 just to be sure
			cube([wedge_width + mount_width / 2 + 1,wedge_length - mount_length - 1, 20 ]);
		
		// cut on the right
		// x : 57 measured (for T530)
		// y : - 2 for clear cutout
		// z : - 0.5 for clear cutout
		translate([57, wedge_length - mount_length - 2, -0.5])
			// x : 57 measured / 0.5 for clear cutout
			// y : mount length is the wedge length since it's only needed to be that long
			// z : 25 just to be sure
			cube([wedge_width - 57 + 0.5, mount_length + 10, 25]);
	}

}

// part on top of the wedge (too complicated too print the whole thing in one part)
// could be redone more elaborate with an identation so the right part of the 
// laptop can't be moved back and forth.
translate([wedge_width + 10, wedge_length, 0])
	// dimensions by trial and error
	cube([24,24,4]);
