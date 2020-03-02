use <uhk-cover-v2.scad>
use <uhk-cover-parts.scad>

module fullArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  flat_guide([10,(depth + margin) * .5,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide([130,(depth + margin) * .5,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_joiner([80,(depth + margin) * 0,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide([10,(depth + margin) + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_joiner([80,(depth + margin) * 2 + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
  flat_guide([130,(depth + margin) + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide([(depth + margin), 20,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin), 50,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin), 100,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin), 258,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin), 228,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin), 178,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin) * 2 + 128, 115,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin) * 2 + 128, 142,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin) * 1.5 + 128 + extraSpaceDepth, 115,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide([(depth + margin) * 1.5 + 128 + extraSpaceDepth, 142,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])

  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    // now just remove what looks like the bottom half away
    // we will later split that into 2 parts to use that as armrests
    translate([-10, -10, -15])
      mirror([0,0, 1])
      cube([400, 400, 400]);
    // make a small indent on the inside so that it becomes easier to fit the case together
    translate([depth * .5 + depth + margin, depth * .5 + margin + depth, -13])
      mirror([0, 0, 1])
      resize([128 + depth + 2 * margin, 285 + depth + 2 * margin, 0 ]) {
        linear_extrude(10)
        polygon(outside_cover_bottom_points(depth, margin));
      };
    // make a few more dents to make the other half stable
    translate([140, 285 - 20 - 30, -13])
      mirror([0, 0, 1])
      cube([60, 30, 10]);
    translate([140, 20, -13])
      mirror([0, 0, 1])
      cube([60, 30, 10]);
    translate([140, 285 - 100 - 30, -13])
      mirror([0, 0, 1])
      cube([60, 30, 10]);
    translate([140, 80, -13])
      mirror([0, 0, 1])
      cube([60, 30, 10]);
  }
}

module leftArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  flat_joiner([40, 132, 0], depth)
  flat_joiner_2([60, 132, 0], depth)
  flat_joiner_2([100, 132, 0], depth)
  flat_joiner([120, 132, 0], depth)
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

module rightArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  orientation = [0, 1, 0];
  flat_joiner_2([40, 132, 0], depth, orientation)
  flat_joiner([60, 132, 0], depth, orientation)
  flat_joiner([100, 132, 0], depth, orientation)
  flat_joiner_2([120, 132, 0], depth, orientation)
  difference() {
    fullArmRests(depth, margin, extraSpaceDepth, name);
    // first cut it so it has the proper length
    translate([-10, 132, 10])
      mirror([0,1,1])
      cube([300, 300, 300]);
    // make a small clearing so that the case buttons are still easy to press
    translate([0, 132, -3])
      rotate([3, -6, 0])
      translate([-50, -50, 0])
      cube([100, 100, 100]);
  }
}

module laptopRest(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    #translate([-10, -10, -13])
      cube([400, 400, 400]);
    // make the indent on the outside

  }
}

module flat_joiner(position= [0,0,0], depth = 2, orientation = [0, 0, 0], width = 10, length = 15) {
  union () {
    children();
    translate(position)
      mirror(orientation)
        translate([0, 0, - 2 * depth]) {
          translate([0, 0, 0])
            cube([width, length, depth]);
          translate([0, length - 5, 0])
            cube([width, 5, 2 * depth]);
        }
  }
}

module flat_joiner_2(position= [0,0,0], depth = 2, orientation= [0, 0, 0], width = 10, length = 15) {
  difference () {
    union() {
      children();
    }
    translate(position)
      mirror(orientation)
        mirror([0,1,0])
        translate([0, 0, - 2 * depth]) {
          translate([0, -3, -10])
            cube([width, length + 3, 10 + depth]);
          translate([0, length - 5, 0])
            cube([width, 5, 3 + 2 * depth]);
        }
  }
}

module flat_guide(position= [0,0,0], depth = 2, orientation = [0, 0, 0], width = 10, length = 15, rotation = [0, 0, 0]) {
  union () {
    children();
    translate(position)
      rotate(rotation)
      mirror(orientation)
        translate([0, 0, -depth]) {
          translate([0, 0, 0])
            cube([width, length, depth]);
        }
  }
}

module flat_guide_2(position= [0,0,0], depth = 2, orientation= [0, 0, 0], width = 10, length = 15) {
  difference () {
    union() {
      children();
    }
    translate(position)
      mirror(orientation)
        mirror([0,1,0])
        translate([0, 0, - 2 * depth]) {
          translate([0, -3, -10])
            cube([width, length + 3, 10 + depth]);
        }
  }
}

module bumpy_joiner(position = [0, 0, 0], depth = 2, orientation = [0, 0, 0], width = 10, length = 15, rotation = [0, 0, 0]) {

  union () {
    children();
    translate(position)
      rotate(rotation)
      mirror(orientation)
        translate([0, 0, - 2 * depth]) {
          translate([0, 0, 0])
            cube([width, length, depth]);
          translate([0, length - depth , depth])
            rotate([0, 90, 0])
            cylinder(h = width, r = depth, $fn = 10);
        }
  }
}



/* translate([-400, 0, 0]) */
  /* fullArmRests(); */


translate ([0, -100, 0])
  leftArmRests();
translate ([0, 100, 0])
  rightArmRests();

/* laptopRest(); */
