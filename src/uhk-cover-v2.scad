use <uhk-rough.scad>
use <../fonts/Hasklug Black Nerd Font Complete Mono.otf>

function outside_cover_bottom_points(depth = 2, margin = 0)
  = [[-depth - margin, -depth - margin],           // 0
      [110 + depth + margin, -depth - margin],      // 1
      [128 + depth + margin, 102 + depth + margin], // 2
      [128 + depth + margin, 176 + depth + margin], // 3
      [110 + depth + margin, 285 + depth + margin], // 4
      [-depth - margin, 285+ depth + margin]        // 5
  ];

function extra_space_points(depth = 2, margin = 0, extraSpaceDepth = 35)  =
  let(extraSpacePointsA =
        [ for (p = outside_cover_bottom_points(depth, margin)) if (p[0] != (-depth -margin)) p],
      extraSpacePointsBtemp =
        [ for (p = outside_cover_bottom_points(depth, margin)) if (p[0] != (- margin - depth)) [p[0] + extraSpaceDepth, p[1]] ],
    extraSpacePointsB =
        [ extraSpacePointsBtemp[3], extraSpacePointsBtemp[2], extraSpacePointsBtemp[1], extraSpacePointsBtemp[0]])
  concat(extraSpacePointsA, extraSpacePointsB);

function extra_space_points_inside(depth = 2, margin = 0, extraSpaceDepth = 35)  =
  let(extraSpacePointsA =
        [ for (p = outside_cover_bottom_points(depth, margin)) if (p[0] != (-depth -margin)) p],
      extraSpacePointsBtemp =
        [ for (p = outside_cover_bottom_points(depth, margin)) if (p[0] != (- margin - depth)) [p[0] + extraSpaceDepth, p[1]] ],
    extraSpacePointsB =
        [ extraSpacePointsBtemp[3], extraSpacePointsBtemp[2], extraSpacePointsBtemp[1], extraSpacePointsBtemp[0]])
    [ [extraSpacePointsA[0].x + depth + margin, extraSpacePointsA[0].y + depth + margin],
        [extraSpacePointsA[1].x + depth + margin, extraSpacePointsA[1].y],
        [extraSpacePointsA[2].x + depth + margin, extraSpacePointsA[2].y],
        [extraSpacePointsA[3].x + depth + margin, extraSpacePointsA[3].y - depth - margin],
        [extraSpacePointsB[0].x - depth - margin, extraSpacePointsB[0].y - depth - margin],
        [extraSpacePointsB[1].x - depth - margin, extraSpacePointsB[1].y],
        [extraSpacePointsB[2].x - depth - margin, extraSpacePointsB[2].y],
        [extraSpacePointsB[3].x - depth - margin, extraSpacePointsB[3].y + depth + margin],
    ];


module UhkCover(depth = 2, margin = 0, extraSpaceDepth = 35, name = "<|leojpod|>") {
    outsideCoverBottomPoints = outside_cover_bottom_points(depth, margin);

    extraSpacePoints = extra_space_points(depth, margin, extraSpaceDepth);

    extraSpacePointsInside = extra_space_points_inside(depth, margin, extraSpaceDepth);

    translate([depth + margin, depth + margin, -3 * depth])
      difference() {
        mirror ([0,0,1])
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
                cube([extraSpaceDepth, 38 - 24, 25 + margin]);
            //dig a hole to hide the cable in
            translate([0, 0, 30])
                mirror([0, 0, 1])
                linear_extrude(40)
                polygon(extraSpacePointsInside);
            //make 2 small indents to be able to lift the screen on it
            translate([depth - margin, - depth - margin, 30]) rotate([0, -60, 0])
                cube([10, 285 + 2 * depth + 2 * margin, 10]);
            translate([128 + extraSpaceDepth - depth + margin, - depth - margin, 30]) rotate([0, -30, 0])
                cube([10, 285 + 2 * depth + 2 * margin, 10]);
          }
          // close the stuff
          translate([0, 0, -3*depth])
              linear_extrude(3*depth)
              polygon(outsideCoverBottomPoints);
          translate([0, 0, -3*depth])
              linear_extrude(3*depth)
              polygon(extraSpacePoints);
        }
        // add signature
        translate([2 * depth + 2 * margin, 285/2 + depth + margin, 30 + depth + margin - .5])
          rotate([0,0,-90])
          linear_extrude(10) text(name, font="Hasklug Nerd Font:style=bold", halign="center",valign="bottom");
      }
}
UhkCover();

translate([200, 0, 0])
  UhkCover(4, 2);
