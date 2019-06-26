use <uhk-rough.scad>
module UhkCover(depth = 2, margin = 0) {
    outsideCoverBottomPoints = [
        [-depth - margin, -depth - margin],
        [110 + depth + margin, -depth - margin],
        [128 + depth + margin, 102 + depth + margin],
        [128 + depth + margin, 176 + depth + margin],
        [110 + depth + margin, 285 + depth + margin],
        [-depth - margin, 285+ depth + margin]
    ];

    baseCasePoints = [
        [ -margin, -margin, 0], // 0
        [ 110 + margin, -margin, 0 ], // 1
        [ 128 + margin, 102 + margin, 0 ], // 2
        [ 128 + margin, 176 + margin, 0 ], // 3
        [ 110 + margin, 285 + margin, 0 ], // 4
        [ -margin, 285 + margin, 0 ] // 5
    ];

    topCasePoints = [
        [ -margin, -margin, 30 + margin], // 6
        [ 110 + margin, -margin, 30 + margin ], // 7
        [ 128 + margin, 102 + margin, 35 + margin ], // 8
        [ 128 + margin, 176 + margin, 35 + margin ], // 9
        [ 110 + margin, 285 + margin, 30 + margin ], // 10
        [ -margin, 285 + margin, 30 + margin ] // 11
    ];
    points = concat(baseCasePoints, topCasePoints);

    caseBottom = [ 0, 1, 2, 3, 4, 5 ];
    caseTop = [ 6, 7, 8 , 9, 10, 11 ];
    leftSide = [ 0, 1, 7, 6 ];
    rightSide = [ 4, 5, 11, 10 ];
    frontSide = [ 0, 5, 11, 6];
    backSideA = [ 1, 2, 8, 7 ];
    backSideB = [ 2, 3, 9, 8 ];
    backSideC = [ 3, 4, 10, 9 ];

    difference() {
      color("#A5ACAF") linear_extrude(30 + depth + margin)
          polygon(outsideCoverBottomPoints);
      translate([0, 0, -10]) linear_extrude(15)
          polygon(basePoints());
      UhkRough();
      translate([100, 102 - margin, - 10])
          cube([138 - 110 + margin, 176 - 102 + 2 * margin, 40 + margin]);
    }
}

UhkCover();

translate([200, 0, 0])
  UhkCover(4, 2);
