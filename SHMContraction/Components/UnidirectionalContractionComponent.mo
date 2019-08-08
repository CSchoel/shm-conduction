within SHMContraction.Components;
partial model UnidirectionalContractionComponent
  input InstantSignal inp "input connector";
  output InstantSignal outp "output connector";
  annotation(
        Icon(
            coordinateSystem(
                preserveAspectRatio= false,
                extent= {{-100,-100},{100,100}}
            ),
            graphics= {
                Ellipse(
                    origin= {-100,100},
                    lineThickness= 3.95480225989,
                    pattern= LinePattern.Solid,
                    fillPattern= FillPattern.None,
                    extent= {{2,-2},{198,-198}},
                    rotation= 0.0
                )
            }
        )
    );
end UnidirectionalContractionComponent;
