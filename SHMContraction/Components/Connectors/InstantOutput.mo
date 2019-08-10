within SHMContraction.Components.Connectors;
connector InstantOutput = output InstantSignal "output with Kronecker delta behavior"
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Polygon(
          origin= {-100,100},
          lineThickness= 5,
          pattern= LinePattern.None,
          points= {{200, -100}, {91.55, 0}, {0, 0}, {0, -200}, {91.55, -200}, {200, -100}},
          fillPattern= FillPattern.Solid,
          fillColor= {0,0,0},
          rotation= 0
        )
      }
    )
  )
;
