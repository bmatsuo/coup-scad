/*
 * Copyright 2015 Bryan Matsuo
 *
 * This work is licensed for use by others under Creative Commons (BY-SA).
 * */

/*
 * The interior box dimensions are 103mmx145mm.
 * */
BoxHeight = 25;
CardHeight = 103;
CardWidth = 65;
TrayWidth = 78.5;
Thickness = 2;

use <wedge/wedge.scad>;

translate([0, 0, CardHeight])
rotate([-90, 0, 0])
coup_tray2(wcard=CardWidth, size=[TrayWidth, CardHeight, BoxHeight-Thickness], t=Thickness, space=8);

module coup_tray2(wcard=1, size=[1, 1, 1], t=0.1, space=3) {
    d = 45;
    dcard = 43;
    dside = 30;
    dside2 = 0.1;
    wrim = size[0]-(size[2]-space)*tan(dcard);
    difference() {
    union() {
        translate([0, size[1], 0])
        mirror([0, 1, 0])
        translate([wrim,0,size[2]+t])
        rotate([0, 0, 90])
        rotate([0, 90-d, 0])
        rotate([-90, 0, 0])
        wedge(r=2*(size[2]+t), h=wrim, d=d+1);

        translate([wrim,0,size[2]+t])
        rotate([0, 0, 90])
        rotate([0, 90-d, 0])
        rotate([-90, 0, 0])
        wedge(r=2*(size[2]+t), h=wrim, d=d+1);

        translate([0,0,size[2]+t])
        rotate([0, 90-dside, 0])
        rotate([-90, 0, 0])
        wedge(r=2*(size[2]+t), h=size[1], d=dside+1);

        translate([wrim, 0, size[2]+t])
        rotate([0, 90-dcard, 0])
        rotate([-90, 0, 0])
        translate([0, 0, -0.5])
        wedge(r=2*(size[2]+t), h=size[1]+1, d=dside2+dcard);

        difference() {
            union() {
                translate([size[0], 0, 0])
                cube([wcard+0.1, size[1], t+space]);

                translate([0, 0, -1])
                cube([size[0]+wcard, size[1], t+1]);
            }

            translate([size[0] + wcard, size[1]/2, -0.5])
            cylinder(r=min(size[0]/2, size[1]/4), h=t+space+1, $fn=4);
        }
    }
    translate([-50, -50, -3*size[2]])
    cube([size[0]+wcard+100, size[1]+100, 3*size[2]]);

    translate([-0.5, -size[1], -0.5])
    cube([size[0]+wcard+1, size[1], size[2]+t+1]);
    translate([-0.5, size[1], -0.5])
    cube([size[0]+wcard+1, size[1], size[2]+t+1]);

    translate([-size[0]-wcard-1, -0.5, -0.5])
        cube([size[0]+wcard+1, size[1]+1, size[2]+t+1]);
    }
}

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
