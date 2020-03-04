use <uhk-cover-v2.scad>
use <uhk-cover-parts.scad>

module fullArmRests(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  flat_guide([10,(depth + margin) * .5,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide([130,(depth + margin) * .5,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_joiner([80,(depth + margin) * 0,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide([10,(depth + margin) + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_joiner([80 + 10,(depth + margin) * 2 + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
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
  flat_guide_2([20,(depth + margin) * 1,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
  flat_guide_2([140,(depth + margin) * 1,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
  bumpy_joiner_2([80,(depth + margin) * 0,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_joiner_2([80 + 10,(depth + margin) * 2 + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
  bumpy_lever([80, 0, 0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  bumpy_lever([80 + 10, (depth + margin) * 2 + 285, 0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 180])
  flat_guide_2([10,(depth + margin) + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide_2([130,(depth + margin) + 285,0], (depth + margin) * .5, [0, 1, 1], 10, 25)
  flat_guide_2([(depth + margin), 20,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin), 50,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin), 100,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin), 258,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin), 228,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin), 178,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, 90])
  flat_guide_2([(depth + margin) * 2 + 128, 115 + 10,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, -90])
  flat_guide_2([(depth + margin) * 2 + 128, 142 + 10,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, -90])
  flat_guide_2([(depth + margin) * 1 + 128 + extraSpaceDepth, 115 + 10,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, -90])
  flat_guide_2([(depth + margin) * 1 + 128 + extraSpaceDepth, 142 + 10,0], (depth + margin) * .5, [0, 1, 1], 10, 25, [0, 0, -90])

  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-10, -10, -13])
      cube([400, 400, 400]);
    // make the indent on the outside
    translate([- depth * .5, 285 + 2 * margin + depth * 1.5, -15])
      cube([210 + depth + 2 * margin, depth, 10]);
    translate([- depth * .5, - depth * .5, -15])
      cube([210 + depth + 2 * margin, depth, 10]);
    translate([- depth * .5, - depth * .5, -15])
      cube([depth, 400, 10]);
    // some dents matching the other side
    translate([110 + 2 * (depth + margin), -depth, -15])
      cube([100, 20 + depth, 15]);
    translate([110 + 2 * (depth + margin), 50, -15])
      cube([100, 30, 15]);
    translate([110 + 2 * (depth + margin), 285 - 20, -15])
      cube([100, 50, 15]);
    translate([110 + 2 * (depth + margin), 285 - 100, -15])
      cube([100, 50, 15]);
    translate([110 + 2 * (depth + margin), -depth, -15])
      cube([30, 400, 15]);
  }
}

module rawRightSide(depth = 2, margin = 1, extraSpaceDepth = 35, name = "<| leojpod |>") {
  difference() {
    laptopRest(depth, margin, extraSpaceDepth, name);
    // now cut some stuff out
    translate([-depth - margin + 90 ,-10,-50])
      cube([200, 10 + depth + margin + 172, 200]);
    translate([-10,-10,-50])
      cube([200, 10 + 125, 200]);
    translate([-depth - margin + 30,-10,-50])
      cube([30, 10 + depth + margin + 172, 200]);
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}

module rawLeftSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    laptopRest(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 172,-50])
      cube([200,200,200]);
    rawRightSide(depth, margin, extraSpaceDepth, name);
    // now cut the top
    translate([60, depth + margin + 110, -10 -depth - margin])
      cube([200, 20, 10+ 15 + margin + depth ]);
    translate([90, -margin - depth - 10, -10 - depth - margin])
      cube([200, 200, 10 + 5 + margin + depth]);
    translate([110 + depth*2 + margin*2, -10 - depth - margin, -10 - depth - margin])
      cube([extraSpaceDepth - depth*2 - margin*2, 15, 20 + 5 + margin + depth]);
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}

module rightSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;

  difference () {
    cover_joiner([0, 125, -35], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
    cover_joiner_2([128 + (depth + margin) * 3 - joinerWidth, margin + depth + 172, -35], [0, 0, 0], joinerWidth, extraScrewClearing = 10)
    cover_joiner_2([extraSpaceDepth + 128 - smallJoinerWidth + (depth + margin) * 2, margin + depth + 172, -35], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
      rawRightSide(depth, margin, extraSpaceDepth, name);
    translate([128 + depth*2 + margin*2, margin + depth + 172, -10])
      cube([extraSpaceDepth - depth*2 - margin*2, 5, 20]);
  }
}

module leftSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;

  cover_joiner_2([0, 125, -35], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
  cover_joiner([128 + (depth + margin) * 3 - joinerWidth, margin + depth + 172, -35], [0, 0, 0], joinerWidth, extraScrewClearing = 10)
  cover_joiner([extraSpaceDepth + 128 - smallJoinerWidth + (depth + margin) * 2, margin + depth + 172, -35], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
    rawLeftSide(depth, margin, extraSpaceDepth, name);
}


module medallion (depth = 2, margin = 2, extraSpaceDepth = 30) {
  halfWidth = (2 * margin + 2 * depth + 285) / 2;
  halfHeight = (2 * margin + 2 * depth + 128 + extraSpaceDepth) / 2;
  mirror([0, 0, 1])
  difference () {
    translate ([halfHeight, halfWidth, 30 + depth + margin]) {
      cylinder(depth, r1 = halfHeight * .75, r2= halfHeight * .70);
    }
    medallionHoles(depth, margin, extraSpaceDepth);
    translate([halfHeight, halfWidth, 30 + depth + margin + 5])
      translate([halfHeight * .9, - halfHeight * .9, 0])
      rotate([0, 0, 180])
      mirror([0, 1, 0])
      tangramRocket(halfHeight * 1.5);
  }
}

module medallionHoles (depth = 2, margin = 2, extraSpaceDepth = 30) {
  halfWidth = (2 * margin + 2 * depth + 285) / 2;
  halfHeight = (2 * margin + 2 * depth + 128 + extraSpaceDepth) / 2;
  translate([halfHeight, halfWidth, -50]) {
    rotate([0,0,5]) {
      translate([0, halfHeight * .6, 0]) {
        cylinder(200, r = 2.5);
      }
      rotate ([0, 0, 120])
      translate([0, halfHeight * .6, 0]) {
        cylinder(200, r = 2.5);
      }
      rotate([0, 0, -120])
      translate([0, halfHeight * .6, 0]) {
        cylinder(200, r = 2.5);
      }
    }
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

module flat_guide_2(position= [0,0,0], depth = 2, orientation= [0, 0, 0], width = 10, length = 15, rotation = [0, 0, 0]) {
  difference () {
    union() {
      children();
    }
    translate(position)
      rotate(rotation)
      mirror(orientation)
        translate([0, 0, - 1 * depth]) {
          translate([0, 0, 0])
            /* mirror([0,0,1]) */
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

module bumpy_joiner_2(position = [0, 0, 0], depth = 2, orientation = [ 0, 0, 0 ], width = 10, length = 15, rotation = [0, 0, 0]) {
  difference () {
    union() {
      children();
    }
    translate(position)
      rotate(rotation)
      mirror(orientation)
        translate([0, 0, - .7 * depth]) {
          translate([0, 0, 0])
            mirror([0,0,1])
            cube([width, length + 3, 10 + depth]);
          translate([0, length - 5, -3])
            cube([width, 5, 3 + 2 * depth]);
        }
  }
}

module bumpy_lever(position = [0, 0, 0], depth = 2, orientation = [0, 0, 0], width = 10, length = 15, rotation = [0, 0, 0]) {
  union () {
    children();
    translate(position)
      rotate(rotation)
      mirror(orientation)
      translate([0, 0, -1 * depth]) {
        translate([1, length - 2 * depth, 5* depth])
          rotate([0, 90, 0])
          linear_extrude(width -2)
          polygon([[0,0], [0, 4 * depth ], [4 * depth, 0]]);
        translate([0, length -3 * depth, 4.5 * depth])
          cube([width, length - 4 * depth, depth]);
        translate([0, 2* length - 8 * depth - .3 * width, 4.5*depth - width])
          cube([width, width * .4, width]);
      }
  }
}

module screw (headSize = 8, headHeigh = 1, screw_size = 5, screw_length = 5, with_dig = false) {
  union() {
    if (with_dig) {
      cylinder(h= headHeigh/2, r1 = headSize / 2, r2 = headSize/2 * 0.875, center = false, $fn = 8);
      translate([0,0, headHeigh/2])
        cylinder(h= headHeigh/2, r2 = headSize / 2, r1 = headSize/2 * 0.875, center = false, $fn = 8);
    } else {
      cylinder(h= headHeigh, r = headSize / 2, center = false, $fn = 8);
    }
    translate([0, 0, headHeigh])
      cylinder(h = screw_length, r = screw_size / 2, center = false, $fn = 10);
  }
}


module tangramRocket(size) {
  halfSize = size * .5;
  quarter = size * .25;
  eighth = size * .125;
  translate([halfSize, halfSize, -4])
    rotate([0, 0, -45]) {
      difference() {
        union() {
          cube([quarter, quarter, 5]);
          translate([0, 0, 0])
            linear_extrude(5)
            polygon([[0, quarter + 1], [quarter, quarter + 1], [eighth, quarter + eighth + 1]]);

          translate([0, 0, 0]) {
            linear_extrude(5)
            polygon([[eighth - 1, -1], [0, -1], [eighth * .5 - .5, -1 - (eighth * .5 - .5)]]);
            linear_extrude(5)
            polygon([[eighth + 1, -1], [quarter, -1], [eighth * 1.5 + .5, -1 - (eighth * .5 - .5)]]);
            translate([eighth, -1, 0])
            rotate([0, 0, 225])
              cube([quarter * sqrt(2)/4, quarter * sqrt(2)/4, 5]);
          }

          translate([0, 0, 0]) {
            linear_extrude(5)
            polygon([[quarter + 1, 0], [quarter + 1 + (eighth * .5 - .5), eighth * .5 -.5],
                     [quarter + 1 + (eighth * .5 - .5), eighth * 1.5 - 1.5 ], [ quarter + 1, eighth - 1 ]]);
            linear_extrude(5)
            polygon([[quarter + 1, eighth + 1], [quarter + 1, quarter], [quarter + 1 + (eighth * .5 - .5), eighth * 1.5 + .5]]);
            linear_extrude(5)
            polygon([[quarter + eighth + 1, eighth], [quarter + eighth * .5 + 1.5, eighth - eighth * .5 + .5], [quarter + 1.5 + eighth * .5, eighth * 1.5 - .5]]);
          }

          translate([0, 0, 0]) {
            translate([- eighth, 0, 0])
              cube([eighth - 1, eighth -1, 5]);
            linear_extrude(5)
              polygon([[-1, eighth + 1], [ -1, quarter - .5], [ - eighth + .5, eighth + 1]]);
            linear_extrude(5)
              polygon([[- eighth, eighth + 1.5], [ -1.5, quarter], [ - eighth, quarter]]);
          }

          translate([0, 0, 0]) {
            linear_extrude(5)
            polygon([[.5 -quarter, 0], [ .5 - quarter, quarter ], [ .5 - eighth , eighth ]]);
            translate([ - quarter, quarter - (eighth * .5) -1, 0])
            rotate([0, 0, 90])
            linear_extrude(5)
            polygon([[0, 0], [0 + (eighth * .5 + .5), eighth * .5 +.5],
                     [0 + (eighth * .5 + .5), eighth * 1.5 - .5 ], [ 0, eighth - 1 ]]);
            translate([- quarter - eighth * .5 - .5,  eighth * .5 + 1.5, 0])
            rotate([0, 0, -90])
            linear_extrude(5)
              polygon([[0, 0], [ 0, eighth * .5 + .5], [ eighth * .5 + .5, 0]]);
            translate([- quarter - eighth * .5 - 1.5,  1, 0])
            rotate([0, 0, 90])
            linear_extrude(5)
              polygon([[0, 0], [ 0, eighth * .5 + .5], [ eighth * .5 + .5, 0]]);
          }
        }
        translate([eighth, eighth, 0])
          rotate([0, 0, -90])
          linear_extrude(7)
          text("12", font="Hasklug Nerd Font:style=bold", halign="center", valign="center", size= eighth);
      }
  }
}

/* translate([-400, 0, 0]) */
  /* fullArmRests(); */


translate ([0, -100, 0])
  leftArmRests();
translate ([0, 100, 0])
  rightArmRests();

/* laptopRest();  */

translate([300, -100, 0])
  leftSide();

translate([300, 100, 0])
  rightSide();

translate([300, 100, 0])
  medallion();

translate([-20, 0, 0]) {
  screw(screw_length = 4);
  translate([10, 0, 0]) screw(with_dig = true, headHeigh = 3, screw_length = 4);
  translate ([0, 10, 0]) screw(screw_length = 6);
}

/* tangramRocket(50); */
