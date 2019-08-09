within SHMContraction.Icons;
model Hourglass "hourglass icon for delay"
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Polygon(
          origin= {-100,100},
          lineThickness= 2,
          pattern= LinePattern.Solid,
          points= {{60.25, -28.44}, {139.75, -28.44}, {60.25, -171.56}, {139.75, -171.56}},
          fillPattern= FillPattern.None,
          rotation= 0
        ),
        Polygon(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          points= {{78.80, -61.84}, {121.20, -61.84}, {100, -100}},
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          rotation= 0
        ),
        Polygon(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          points= {{60.25, -171.56}, {100, -155.65}, {139.75, -171.56}},
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          extent= {{98.41,-112.72},{101.59,-115.90}},
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          extent= {{98.41,-123.85},{101.59,-127.03}},
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          extent= {{98.41,-134.98},{101.59,-138.16}},
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 1,
          pattern= LinePattern.None,
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          extent= {{98.41,-146.11},{101.59,-149.29}},
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 2,
          pattern= LinePattern.Solid,
          fillPattern= FillPattern.None,
          extent= {{119.02,-75.87},{167.28,-124.13}},
          rotation= 0
        ),
        Line(
          origin= {-100,100},
          pattern= LinePattern.Solid,
          rotation= 0,
          points= {{142.07, -85.85}, {142.07, -103.68}, {154.70, -103.68}},
          thickness= 2
        )
      }
    )
  );
end Hourglass;
