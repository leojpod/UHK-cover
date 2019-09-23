use <uhk-cover.scad>

module rightSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
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

module leftSide(depth = 2, margin = 0, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 176,-20])
      cube([200,200,200]);
    rightSide(depth, margin, extraSpaceDepth, name);
    // now cut the top
    translate([60, depth + margin + 110, -10 -depth - margin])
      cube([200, 20, 10+ 15 + margin + depth ]);
    translate([90, -margin - depth - 10, -10 - depth - margin])
      cube([200, 200, 10 + 5 + margin + depth]);
  }
}


module topPiece (depth = 2, margin = 2, extraSpaceDepth = 30, name = "<| leojpod |>") {
  difference() {
    UhkCover(depth, margin, extraSpaceDepth, name);
    translate([-20 , depth + margin + 176,-20])
      cube([200,200,200]);
    translate([-20 - depth - margin , -20 ,-20])
      cube([20 + depth + margin + 90,200,200]);
    leftSide(depth, margin, extraSpaceDepth, name);
  }
}



mirror ([0,0,1]) {

  rightSide();

  translate([0, -200,0])
    leftSide();

  translate([200, -200,0])
    topPiece();
}


