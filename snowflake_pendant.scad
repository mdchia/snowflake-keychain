// Tiny Snowflake
// by Ming-Dao Chia

// Settings
height=1.4; // Total thickness of keychain
circle_res=20; // Resolution of circles
keyring=4; // Size of keyring hole in mm
thickness=1.6; // Line width

module sf_round_line(length, thickness, height){
    union(){
        // start of line
        cylinder(d=thickness,h=height, $fn=circle_res);
        // main length
        translate([0,-thickness/2,0])
        cube([length,thickness,height]);
        // end of line
        translate([length,0,0])
        cylinder(d=thickness,h=height, $fn=circle_res);
    }
}

module sf_ring(){
    translate([0,0,height/2]) // raise to the level of the rest of model
    difference(){
        cylinder(d=keyring+2,h=height, $fn=circle_res, center=true);
        cylinder(d=keyring,h=height, $fn=circle_res, center=true);
    }
}

module sf_arm(){
    translate([3,0,0])
    union(){
        // center line
        sf_round_line(10, thickness, height);
        // arms
        translate([6,0,0]) // upper right
        rotate([0,0,45])
        sf_round_line(4, thickness, height);
        translate([6,0,0]) // upper left
        rotate([0,0,-45])
        sf_round_line(4, thickness, height);
        translate([2,0,0]) // lower right
        rotate([0,0,45])
        sf_round_line(4, thickness, height);
        translate([2,0,0]) // lower right
        rotate([0,0,-45])
        sf_round_line(4, thickness, height);
        // center ring
        translate([0,0,0]) // right 
        rotate([0,0,-120])
        sf_round_line(3, thickness, height);
        translate([0,0,0]) // left
        rotate([0,0,120])
        sf_round_line(3, thickness, height);
    }
}

module sf_arms(num){
    function angle(i,num)=i*(360/num); // evenly spread arms in a circle
    for(i=[1:num]){
        // add an arm each rotation
        rotate([0,0,angle(i,num)])
        sf_arm();
    }
}

module snowflake(){
    sf_arms(6); // modify this for number of arms
    // keyring
    translate([14+keyring/2,0,0])
    sf_ring();
}

//sf_arm(); // use to see just one arm at a time
snowflake();
