module UhkRough() {
    basePoints = [
        [0, 0, 0], // 0
        [110, 0, 0], // 1
        [128, 102, 0], // 2
        [110, 106, 0], // 3
        [110, 172, 0], // 4
        [128, 176, 0], // 5
        [110, 285, 0], // 6
        [0, 285, 0] // 7
    ];
    
    topPoints = [
        [0, 0, 20], // 8
        [110, 0, 20], // 9
        [128, 102, 24], // 10
        [110, 106, 25], // 11
        [110, 172, 25], // 12
        [128, 176, 24], // 13
        [110, 285, 20], // 14
        [0, 285, 20] // 15
    ];
    
    points = concat(basePoints, topPoints);
    bottom = [ 0, 1, 2, 3, 4, 5, 6, 7];
    top = [ 8, 9, 10, 11, 12, 13, 14, 15];
    leftSide = [ 0, 1, 9, 8];
    rightSide = [ 6, 7, 15, 14];
    frontSide = [0, 7, 15, 8];
    backSideA = [1, 2, 10, 9];
    backSideB = [ 2, 3, 11, 10];
    backSideC = [3, 4, 12, 11];
    backSideD = [4, 5, 13, 12];
    backSideE = [5, 6, 14, 13];
    faces = [ bottom, top, leftSide, rightSide, frontSide, backSideA, backSideB, backSideC, backSideD, backSideE];
    
    polyhedron(points, faces);
}

UhkRough();