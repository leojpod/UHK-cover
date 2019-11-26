use <uhk-cover.scad>
include <../BOSL/constants.scad>
use <../BOSL/joiners.scad>

module rawRightSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    // now cut some stuff out
    translate([-depth - margin + 90 ,-10,-20])
      cube([200, 10 + depth + margin + 176, 200]);
    translate([-10,-10,-20])
      cube([200, 10 + 125, 200]);
    translate([-depth - margin + 30,-10,-20])
      cube([30, 10 + depth + margin + 176, 200]);
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}

module rawLeftSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 176,-20])
      cube([200,200,200]);
    rawRightSide(depth, margin, extraSpaceDepth, name);
    // now cut the top
    translate([60, depth + margin + 110, -10 -depth - margin])
      cube([200, 20, 10+ 15 + margin + depth ]);
    translate([90, -margin - depth - 10, -10 - depth - margin])
      cube([200, 200, 10 + 5 + margin + depth]);
    medallionHoles(depth, margin, extraSpaceDepth);
  }
}


module rawTopPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 176,-20])
      cube([200,200,200]);
    translate([-20 - depth - margin , -20 ,-20])
      cube([20 + depth + margin + 90,200,200]);
    rawLeftSide(depth, margin, extraSpaceDepth, name);
  }
}

module rightSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  joinerWidth = depth * 2 + margin;
  smallJoinerWidth = depth + margin;
  union () {
    difference() {
      rawRightSide(depth, margin, extraSpaceDepth, name);
      // take away some of the matter to place the joiners
      translate([- depth - margin + smallJoinerWidth * .5, 125, 15 ])
        #half_joiner_clear(w = smallJoinerWidth, orient=ORIENT_Y);
      translate([128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(w = joinerWidth, orient=ORIENT_Y);
      translate([extraSpaceDepth + 128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(w = smallJoinerWidth, orient=ORIENT_Y);
    }
    translate([-margin - depth + smallJoinerWidth * .5, 124, 50 + 15 ])
      mirror([0, 1, 0])
      half_joiner(w= smallJoinerWidth, guides=true, orient=ORIENT_Y);
    /* translate([128 + depth , margin + depth + 176, 15]) */
      /* half_joiner2(w = joinerWidth, guides = true, orient=-ORIENT_Y); */
    /* translate([extraSpaceDepth + 128 + depth, margin + depth + 176, 15]) */
      /* half_joiner2(w = smallJoinerWidth, guides = true, orient=-ORIENT_Y); */
  }
}

module leftSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  union () {
    difference () {
      rawLeftSide(depth, margin, extraSpaceDepth, name);
      translate([0, 125, 15])
        half_joiner_clear(orient=ORIENT_Y);
      translate([128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(orient=ORIENT_Y);
      translate([extraSpaceDepth + 128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(orient=ORIENT_Y);
    }
    translate([-margin, 125, 15 ])
      half_joiner2(w=depth + margin, guides=true, orient=ORIENT_Y);
    translate([128 + depth , margin + depth + 176, 15])
      half_joiner(w = depth * 2 + margin, guides = true, orient=ORIENT_Y);
    translate([extraSpaceDepth + 128 + depth, margin + depth + 176, 15])
      half_joiner(w = depth + margin, guides = true, orient=ORIENT_Y);
  }
}

module topPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  union () {
    difference () {
      rawTopPiece(depth, margin, extraSpaceDepth, name);
    }
  }
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
module screw_hole(w = 10, h = 20, screwsize = 2) {
  translate([w/2, 0, h/2])
    rotate([0, 90, 0])
      cylinder(h = w, r = screwsize /2, center = true, $fn = 10);
}

module joiner_in(w = 10, h = 20, guides = true, screwsize = 2) {
  difference() {
    joiner_block(w, h);

    // put the screw hole in place
    screwhole(w, h, screwsize);
  }
}
module joiner_out(w = 10, h = 20, guides = true, screwsize = 2) {
  difference() {
    joiner_clear(w, h);
    joiner_block(w, h);

    // put the screw hole in place
    screw_hole(w, h, screwsize);
  }
}

module cover_joiner (x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, width = 6) {
  union() {
    difference() {
      union () {
        children();
      }
      translate([x, y, z])
        rotate([rx, ry, rz])
          joiner_clear(w = width);
    }
    translate([x, y, z])
      rotate([rx, ry, rz])
        joiner_in(w = width, guides = true, screwsize = 2);
  }
}
module cover_joiner_2 (x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, width = 6) {
  union() {
    difference() {
      union () {
        children();
      }
      translate([x, y, z])
        rotate([rx, ry, rz])
          joiner_clear(w = width);
    }
    translate([x, y, z])
      rotate([rx, ry, rz])
        joiner_out(w = width, guides = true, screwsize = 2);
  }
}
!cover_joiner_2(0, 0, 0) cube(20, 0);


mirror ([0,0,1]) {

  rightSide();

  translate([0, -200,0])
    leftSide();

  translate([200, -200,0])
    topPiece();

  translate([100, -100, 0])
    medallion();
}


