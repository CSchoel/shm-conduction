within SHMConduction.Icons;
model Constant "small box with a C in upper right corner"
    annotation(
        Icon(
            coordinateSystem(
                preserveAspectRatio= false,
                extent= {{-100,-100},{100,100}}
            ),
            graphics= {
                Polygon(
                    origin= {-100,100},
                    lineThickness= 0.56,
                    pattern= LinePattern.None,
                    points= {{163.21, -24.39}, {163.21, -2.15}, {196.78, -2.15}, {196.78, -36.36}, {174.62, -36.36}},
                    fillPattern= FillPattern.Solid,
                    fillColor= {0,0,0},
                    rotation= 0
                ),
                Text(
                    origin = {81, 84},
                    lineColor = {255, 255, 255},
                    extent = {{-11, 22}, {11, -22}},
                    textString = "c"
                )
            }
        )
    );
end Constant;
