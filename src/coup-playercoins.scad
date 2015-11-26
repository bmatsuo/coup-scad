CoinSide=12;

intersection() {
    player_coins(side=CoinSide, t=2);
    cube(size=103, center=true);
}

module player_coins(side=CoinSide, stack=4, nstack=3, t=1) {
    r = (side/2)/sin(22.5);
    w = 2*(r*cos(22.5));
    translate([-(nstack/2-0.5)*(side + 2*side*cos(45)), 0, 0])
    difference() {
        union() {
            difference() {
                _player_coins(side=side, wcoin=w, stack=stack, t=t, nstack=3);

                translate([-100, -100, side*cos(45)-2])
                cube(size=[200, 200, 200]);
            }

            _player_coins(side=side, wcoin=w, stack=stack, t=0, nstack=3);
        }
        translate([0, 0, -side*cos(45)+2.2])
        _player_coins(side=side, wcoin=w, stack=stack, t=0, nstack=3, fudge=0.3);
    }
}

module _player_coins(side=CoinSide, wcoin=26, stack=4, nstack=3, t=1, fudge=0.125) {
    stack_size = stack * 2;
    r = (wcoin/2)/sin(22.5);
    for (i = [0:nstack-1]) {
        translate([i * (side + 2*side*cos(45)), 0, 0])
        difference() {
            translate([0, 0, -r*sin(22.5) - side])
            rotate([90, 0, 0])
            translate([0, 0, -(stack_size+2*t)/2])
            rotate([0, 0, 22.5])
            cylinder(r=r, h=stack_size+2*t, $fn=8);

            translate([0, (stack_size+2*fudge)/2, wcoin/2])
            rotate([90, 0, 0])
            coin(w=wcoin, t=stack_size+2*fudge);

            cube(size=[side, stack_size+fudge, 100], center=true);

            translate([0, 0, -100])
            cube(size=200, center=true);
        }
    }
}

module coin(w=26, t=2) {
    r = (w/2)/cos(22.5);
    rotate([0, 0, 22.5])
    cylinder(r=r, h=t, $fn=8);
}
