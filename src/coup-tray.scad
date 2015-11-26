/*
 * The interior box dimensions are 103mmx146mm.  Approximately 24mm (of 146mm)
 * are needed for the player coin trays.
 * */
BoxHeight = 25;
CardHeight = 103;
CardWidth = 65;
TrayWidth = 57;
Thickness = 1;

coup_tray(wcard=CardWidth, size=[TrayWidth, CardHeight, BoxHeight], t=Thickness);

module coup_tray(wcard=1, size=[1, 1, 1], t=0.1) {
    union() {
        cup_cube(size=size, t=t);

        translate([TrayWidth-0.1, 0, BoxHeight])
        rotate([-90, 0, 0])
        prism_right_iso(s=7, h=size[1]);

        translate([size[0]/2, 0, t])
        rotate([-90, 0, 0])
        cylinder(r=t, h=size[1]);

        difference() {
            cube([size[0]+wcard, size[1], t]);
            translate([size[0] + wcard, size[1]/2, -0.5])
            cylinder(r=min(size[0]/2, size[1]/4), h=t+1);
        }
    }
}

module cup_cube(size=[1,1,1], t=0.1) {
    difference() {
        cube(size=size);

        translate([t, t, t])
        cube(size=[size[0]-2*t, size[1]-2*t, size[2]]);
    }
}

// prism with right isosoles footprint.
module prism_right_iso(s, h) {
    points = [[0, 0], [s, 0], [0, s]];
    paths = [[0,1,2,0]];
    linear_extrude(height=h)
    polygon(points=points, paths=paths);
}
