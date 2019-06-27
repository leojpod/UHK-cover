// add the case
function basePoints() = [
    [0, 0],     // 0
    [110, 0],   // 1
    [128, 102], // 2
    [110, 106], // 3
    [110, 172], // 4
    [128, 176], // 5
    [110, 285], // 6
    [0, 285]    // 7
];


module UhkRough() {
    union() {
      difference(){
        color("#69BE28") linear_extrude(25)
          polygon(basePoints());
        translate([-10, -10, 20]) cube([115, 295, 30]);
        translate([0, 0, 20]) rotate([atan(5/106), 0, 0]) cube([200, 200, 30]);
        translate([0, 172, 25]) rotate([-atan(5/(285-172)), 0, 0]) cube([200, 200, 30]);
      }
      // then add the keys
      translate([11, 7, 20])
        cube([95, 275, 10]);
    }
}

UhkRough();
