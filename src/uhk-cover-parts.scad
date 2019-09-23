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
  union () {
    difference() {
      rawRightSide(depth, margin, extraSpaceDepth, name);
      // take away some of the matter to place the joiners
      translate([0, 125, 15 ])
        half_joiner_clear(orient=ORIENT_Y);
      translate([128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(orient=ORIENT_Y);
      translate([extraSpaceDepth + 128 + depth + margin, margin + depth + 176, 15 ])
        half_joiner_clear(orient=ORIENT_Y);
    }
    translate([-margin, 125, 15 ])
      half_joiner(w=depth + margin, guides=true, orient=-ORIENT_Y);
    translate([128 + depth , margin + depth + 176, 15])
      half_joiner2(w = depth * 2 + margin, guides = true, orient=-ORIENT_Y);
    translate([extraSpaceDepth + 128 + depth, margin + depth + 176, 15])
      half_joiner2(w = depth + margin, guides = true, orient=-ORIENT_Y);
  }
}

module leftSide (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  union () {
    difference () {
      rawLeftSide(depth, margin, extraSpaceDepth, name);
    }
  }
}

module topPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  union () {
    difference () {
      rawTopPiece(depth, margin, extraSpaceDepth, name);
    }
  }
}

mirror ([0,0,1]) {

  rightSide();

  translate([0, -200,0])
    leftSide();

  translate([200, -200,0])
    topPiece();
}


