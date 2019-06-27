use <uhk-rough.scad>
module UhkCover(depth = 2, margin = 0, extraSpaceDepth = 35) {
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
    echo(cableHolePoints);
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
      translate([100, 172 + 70, - 10])
          cube([extraSpaceDepth, 38 - 24, 15 + margin]);
      //dig a hole to hide the cable in
      translate([0, 0, depth + margin]) linear_extrude(30 - 2 * depth - 2 * margin)
          polygon(extraSpacePointsInside);
      //open it so we can put it in easily
      translate([0, 0, -10]) linear_extrude(15)
        polygon(cableHolePoints);
    }
}

UhkCover();

translate([200, 0, 0])
  UhkCover(4, 2);
