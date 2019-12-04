use <uhk-cover.scad>
include <../BOSL/constants.scad>
use <../BOSL/joiners.scad>

module rawRightSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    // now cut some stuff out
    translate([-depth - margin + 90 ,-10,-20])
      cube([200, 10 + depth + margin + 172, 200]);
    translate([-10,-10,-20])
      cube([200, 10 + 125, 200]);
    translate([-depth - margin + 30,-10,-20])
      cube([30, 10 + depth + margin + 172, 200]);
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}

module rawLeftSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 172,-20])
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


module rawTopPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 172,-20])
      cube([200,200,200]);
    translate([-20 - depth - margin , -20 ,-20])
      cube([20 + depth + margin + 90,200,200]);
    rawLeftSide(depth, margin, extraSpaceDepth, name);
    translate([-20 - depth - margin , -20 ,15])
      cube([200,200,200]);
  }
}

module rightSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;

  difference () {
    cover_joiner([-depth - margin , 125, 5], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
    cover_joiner_2([128 + depth*2 + margin*2 - joinerWidth, margin + depth + 172, 5], [0, 0, 0], joinerWidth, extraScrewClearing = 10)
    cover_joiner_2([extraSpaceDepth + 128 + depth + margin - smallJoinerWidth, margin + depth + 172, 5], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
      rawRightSide(depth, margin, extraSpaceDepth, name);
    translate([128 + depth*2 + margin*2, margin + depth + 172, -10])
      cube([extraSpaceDepth - depth*2 - margin*2, 5, 20]);
  }
}

module leftSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;

  cover_joiner_2([-depth - margin , 125, 5], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
  cover_joiner([128 + depth*2 + margin*2 - joinerWidth, margin + depth + 172, 5], [0, 0, 0], joinerWidth, extraScrewClearing = 10)
  cover_joiner([extraSpaceDepth + 128 + depth + margin - smallJoinerWidth, margin + depth + 172, 5], [0, 0, 0], smallJoinerWidth, extraScrewClearing = 10)
  cover_joiner([128 + depth*2 + margin*2 , 110 + margin + depth, 15], [90, 0, 180], joinerWidth, extraScrewClearing = 10)
  cover_joiner_2([extraSpaceDepth + 128 + depth + margin , 110 + margin + depth, 15 ], [90, 0, 180], smallJoinerWidth, extraScrewClearing = 10)
  cover_joiner_2([110 + depth*3 + margin*3 + (extraSpaceDepth/2) + 2, 0, 15], [90, 0, -90], smallJoinerWidth, extraScrewClearing = 10)
    rawLeftSide(depth, margin, extraSpaceDepth, name);
}

module topPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;

  cover_joiner_2([128 + depth*2 + margin*2 , 110 + margin + depth, 15], [90, 0, 180], joinerWidth, extraScrewClearing = 10)
  cover_joiner([extraSpaceDepth + 128 + depth + margin , 110 + margin + depth, 15 ], [90, 0, 180], smallJoinerWidth, extraScrewClearing = 10)
  cover_joiner([110 + depth*3 + margin*3 + (extraSpaceDepth/2) + 2, 0, 15], [90, 0, -90], smallJoinerWidth, extraScrewClearing = 10)
    rawTopPiece(depth, margin, extraSpaceDepth, name);
}

module medallion (depth = 2, margin = 2, extraSpaceDepth = 30) {
  halfWidth = (2 * margin + 2 * depth + 285) / 2;
  halfHeight = (2 * margin + 2 * depth + 128 + extraSpaceDepth) / 2;
  difference () {
    translate ([halfHeight, halfWidth, 30 + depth + margin]) {
      cylinder(depth, r1 = halfHeight * .75, r2= halfHeight * .70);
    }
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}

module medallionHoles (depth = 2, margin = 2, extraSpaceDepth = 30) {
  halfWidth = (2 * margin + 2 * depth + 285) / 2;
  halfHeight = (2 * margin + 2 * depth + 128 + extraSpaceDepth) / 2;
  translate([halfHeight, halfWidth, 0]) {
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


module joiner_clear(w = 10, h = 20) {
  rotate([90, 0, 90])
    linear_extrude(w)
      polygon([ [0,0], [5,h/3], [5,2*h/3], [0,h], [-5,2*h/3], [-5,h/3]]);
}

module joiner_block(w = 10, h = 20, guides = true) {
  inWidth = w/3;
  halfInWidth = inWidth/2;
  depth = h/2;

  translate([inWidth,0,0])
    union() {
      rotate([90, 0, 90])
        linear_extrude(inWidth)
          polygon([ [0,0], [5,h/3], [5,2*h/3], [0,h], [-5,2*h/3], [-5,h/3]]);
      translate([halfInWidth,  depth/2, h/2])
        rotate([90, 0, 0])
          linear_extrude(depth)
            polygon([ [halfInWidth,-h/6], [inWidth,0], [halfInWidth,h/6],[-halfInWidth,h/6], [-inWidth,0], [-halfInWidth,-h/6] ]);
      if (guides) {
        translate([halfInWidth,  0, h/4])
          rotate([0, 0, 0])
            scale([0.6, 0.5, 1])
              linear_extrude(depth)
                polygon([ [halfInWidth,-h/6], [inWidth,0], [halfInWidth,h/6],[-halfInWidth,h/6], [-inWidth,0], [-halfInWidth,-h/6] ]);
      }
    }
}
module screw_hole(w = 10, h = 20, screw_size = 5, extraScrewClearing = 0) {
  translate([w/2, 0, h/2])
    rotate([0, 90, 0])
      cylinder(h = w + extraScrewClearing, r = screw_size /2, center = true, $fn = 10);
}

module joiner_in(w = 10, h = 20, guides = true, screw_size = 5, extraScrewClearing = 0) {
  difference() {
    joiner_block(w, h);

    // put the screw hole in place
    screw_hole(w, h, screw_size, extraScrewClearing);
  }
}
module joiner_out(w = 10, h = 20, guides = true, screw_size = 5, extraScrewClearing = 0) {
  difference() {
    joiner_clear(w, h);
    joiner_block(w, h);

    // put the screw hole in place
    screw_hole(w, h, screw_size, extraScrewClearing);
  }
}

module cover_joiner (position = [0, 0, 0], rotation = [0, 0, 0], width = 6, extraScrewClearing = 0) {
  union() {
    difference() {
      union () {
        children();
      }
      translate(position)
        rotate(rotation)
          joiner_clear(w = width);
    }
    translate(position)
      rotate(rotation)
        joiner_in(w = width, guides = true, screw_size = 5, extraScrewClearing = extraScrewClearing);
  }
}
module cover_joiner_2 (position = [ 0, 0, 0 ], rotation = [ 0, 0, 0 ], width = 6, extraScrewClearing = 0) {
  union() {
    difference() {
      union () {
        children();
      }
      translate(position)
        rotate(rotation)
          joiner_clear(w = width);
    }
    translate(position)
      rotate(rotation)
        joiner_out(w = width, guides = true, screw_size = 5, extraScrewClearing = extraScrewClearing);
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

mirror ([0,0,1]) {

  rightSide();

  translate([0, -200,0])
    leftSide();

  translate([200, -200,0])
    topPiece();

  translate([100, -100, 0])
    medallion();
}

translate([-20, 0, 0]) {
  screw(screw_length = 4);
  translate([10, 0, 0]) screw(with_dig = true, headHeigh = 3, screw_length = 4);
  translate ([0, 10, 0]) screw(screw_length = 6);
}

