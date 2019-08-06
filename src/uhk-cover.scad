use <uhk-rough.scad>
use <../fonts/Hasklug Black Nerd Font Complete Mono.otf>
module clipInShape(lenght, margin, depth) {
  rotate([0, 90, 90])
  color("#00FF00")
  translate([-(margin + depth), 0,  0])
  linear_extrude(lenght) polygon([
    [0,0],
    [depth + margin, depth + margin],
    [0, depth + margin]
  ]);
}

module clipOpenner(depth) {
  translate([-depth + .1, 5, 30/2])
    rotate([90, 0, 0])
    difference() {
      cylinder(10, 5, 5, true);
      translate([depth-.1, -50, -50])
      cube([100, 100, 100]);
    }
  translate([-depth - 5, 0, 0])
    cube([5, 10, depth]);
  translate([- 2 * depth - 5, 0, 0])
    cube([depth, 10, 30]);
}

module clipOpenning(depth, margin) {
  translate([-10, -2, -5])
    cube([20, 2, 15]);
  translate([-10, 10, -5])
    cube([20, 2, 15]);
  translate([-depth + 1.5, 0, depth + margin])
    cube([10, 10, 10]);
}

module UhkCover(depth = 2, margin = 0, extraSpaceDepth = 35, name = "<|leojpod|>") {
    outsideCoverBottomPoints = [
        [-depth - margin, -depth - margin],           // 0
        [110 + depth + margin, -depth - margin],      // 1
        [128 + depth + margin, 102 + depth + margin], // 2
        [128 + depth + margin, 176 + depth + margin], // 3
        [110 + depth + margin, 285 + depth + margin], // 4
        [-depth - margin, 285+ depth + margin]        // 5
    ];

    extraSpacePointsA =
        [ for (p = outsideCoverBottomPoints) if (p[0] != (-depth -margin)) p];
    extraSpacePointsBtemp =
        [ for (p = outsideCoverBottomPoints) if (p[0] != (- margin - depth)) [p[0] + extraSpaceDepth, p[1]] ];
    extraSpacePointsB =
        [ extraSpacePointsBtemp[3], extraSpacePointsBtemp[2], extraSpacePointsBtemp[1], extraSpacePointsBtemp[0]];

    extraSpacePoints = concat(
        extraSpacePointsA,
        extraSpacePointsB
    );

    extraSpacePointsInside = [
        [extraSpacePointsA[0].x + depth + margin, extraSpacePointsA[0].y + depth + margin],
        [extraSpacePointsA[1].x + depth + margin, extraSpacePointsA[1].y],
        [extraSpacePointsA[2].x + depth + margin, extraSpacePointsA[2].y],
        [extraSpacePointsA[3].x + depth + margin, extraSpacePointsA[3].y - depth - margin],
        [extraSpacePointsB[0].x - depth - margin, extraSpacePointsB[0].y - depth - margin],
        [extraSpacePointsB[1].x - depth - margin, extraSpacePointsB[1].y],
        [extraSpacePointsB[2].x - depth - margin, extraSpacePointsB[2].y],
        [extraSpacePointsB[3].x - depth - margin, extraSpacePointsB[3].y + depth + margin],
    ];
    echo(extraSpacePointsInside);

    cableHolePoints = [
      extraSpacePointsInside[2],
      extraSpacePointsInside[3],
      extraSpacePointsInside[4],
      extraSpacePointsInside[5]
    ];

    difference() {
      union() {
        difference() {
          union() {
              color("#A5ACAF") linear_extrude(30 + depth + margin)
                  polygon(outsideCoverBottomPoints);
              color("#69BE28") linear_extrude(30 + depth + margin)
                  polygon(extraSpacePoints);
          }
          //make sure we dig low enough
          translate([0, 0, -10]) linear_extrude(15)
              polygon(basePoints());
          //make sure we clear space for the keyboard itself
          UhkRough();
          //clear space for the cable between the halves
          translate([100, 102 - margin, - 10])
              cube([138 - 110 + margin, 176 - 102 + 2 * margin, 40 + margin]);
          //clear space for the USB-cable
          translate([100, 172 + 70, - 1 - margin])
              cube([extraSpaceDepth, 38 - 24, 15 + margin]);
          //dig a hole to hide the cable in
          translate([0, 0, depth + margin]) linear_extrude(30 - 2 * depth - 2 * margin)
              polygon(extraSpacePointsInside);
          //open it so we can put it in easily
          translate([0, 0, -10]) linear_extrude(15)
              polygon(cableHolePoints);
          //make 2 small indents to be able to lift the screen on it
          translate([depth - margin, - depth - margin, 30]) rotate([0, -60, 0])
              cube([10, 285 + 2 * depth + 2 * margin, 10]);
          translate([128 + extraSpaceDepth - depth + margin, - depth - margin, 30]) rotate([0, -30, 0])
              cube([10, 285 + 2 * depth + 2 * margin, 10]);
        }
        // put some "angle stuff" to "click" the keyboard in
        translate([margin + depth, 90, 0])
          clipInShape(10, margin, depth);
        translate([margin + depth, 175, 0])
          clipInShape(10, margin, depth);
        translate([110 - margin - depth + 45*(128-110)/(102-0), 45, 0])
          rotate([0, 0, 180-atan((128-110)/(102 - 0))])
          clipInShape(30, margin, depth);
        translate([110 - margin - depth + 45*(128-110)/(285-176), 285-45, 0])
          rotate([0, 0, 180+atan((128-110)/(285 - 176))])
          clipInShape(30, margin, depth);
        // put the "levers"
        translate([0, 90, 0])
          clipOpenner(depth);
        translate([0, 175, 0])
          clipOpenner(depth);
        // if that doesn't work then we'll need to make room for an alternative fix
      }
      // then dig out some to make the clickable part a bit more flexible
      translate([0, 90, 0])
        clipOpenning(depth, margin);
      translate([0, 175, 0])
        clipOpenning(depth, margin);
      // add signature
      translate([2 * depth + 2 * margin, 285/2 + depth + margin, 30 + depth + margin - .5])
        rotate([0,0,-90])
        linear_extrude(10) text(name, font="Hasklug Nerd Font:style=bold", halign="center",valign="bottom");
    }
}
UhkCover();

translate([200, 0, 0])
  UhkCover(4, 2);
