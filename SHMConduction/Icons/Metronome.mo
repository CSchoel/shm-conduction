within SHMConduction.Icons;
model Metronome "metronome icon for pacemaker"
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Line(
          origin= {-100,100},
          pattern= LinePattern.Solid,
          rotation= 0,
          points= {{98.41, -140.61}, {160.53, -33.61}},
          thickness= 2
        ),
        Polygon(
          origin= {-100,100},
          lineThickness= 2,
          pattern= LinePattern.Solid,
          points= {{82.31, -34.98}, {115.02, -34.98}, {147.73, -152.74}, {49.60, -152.74}},
          fillPattern= FillPattern.None,
          rotation= 0
        ),
        Ellipse(
          origin= {-100,100},
          lineThickness= 2,
          pattern= LinePattern.Solid,
          endAngle= 179.999997341,
          fillPattern= FillPattern.Solid,
          fillColor= {255,255,255},
          extent= {{74.88,-117.33},{122.44,-164.88}},
          startAngle= 0.0,
          rotation= 0
        ),
        Polygon(
          origin= {-100,100},
          lineThickness= 2,
          pattern= LinePattern.None,
          points= {{143.95, -55.42}, {149.79, -58.93}, {159.31, -49.78}, {147.56, -42.71}},
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          rotation= 0
        )
      }
    )
  );
end Metronome;
