use <uhk-cover-v2.scad>
use <uhk-cover-parts.scad>

module fullArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    // now just remove what looks like the bottom half away
    // we will later split that into 2 parts to use that as armrests
    translate([-10, -10, -25])
      mirror([0,0, 1])
      cube([400, 400, 400]);
  }
}

module rawLeftArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  difference() {
    fullArmRests(depth, margin, extraSpaceDepth, name);
    // first cut it so it has the proper length
    translate([-10, 132, 10])
      mirror([0, 0, 1])
      cube([300, 300, 300]);
    // make a small clearing so that the case buttons are still easy to press
    translate([0, 132, -3])
      rotate([-3, -6, 0])
      translate([-50, -50, 0])
      cube([100, 100, 100]);
  }
}

module leftArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  flat_joiner([40, 132, 0], depth)
  flat_joiner_2([60, 132, 0], depth)
  flat_joiner_2([100, 132, 0], depth)
  flat_joiner([120, 132, 0], depth)
    rawLeftArmRests(depth, margin, extraSpaceDepth, name);
}

module flat_joiner(position= [0,0,0], depth = 2, width = 10, length = 15) {
  union () {
    children();
    translate(position)
      translate([0, 0, - 2 * depth]) {
        translate([0, 0, 0])
          cube([width, length, depth]);
        translate([0, length - 5, 0])
          cube([width, 5, 2 * depth]);
      }
  }
}

module flat_joiner_2(position= [0,0,0], depth = 2, width = 10, length = 15) {
  difference () {
    union() {
      children();
    }
    translate(position)
      mirror([0,1,0])
      translate([0, 0, - 2 * depth]) {
        translate([0, -3, -10])
          cube([width, length + 3, 10 + depth]);
        translate([0, length - 5, 0])
          cube([width, 5, 3 + 2 * depth]);
      }
  }
}



/* translate([-400, 0, 0]) */
  /* fullArmRests(); */


leftArmRests();

