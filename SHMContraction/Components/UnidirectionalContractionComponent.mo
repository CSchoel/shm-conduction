within SHMContraction.Components;
partial model UnidirectionalContractionComponent
  import SHMContraction.Components.Connectors.{InstantInput, InstantOutput};
  InstantInput inp "input connector" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-100, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      ),
      iconTransformation(
        origin = {-108, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  InstantOutput outp "output connector" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {102, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      ),
      iconTransformation(
        origin = {108, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Ellipse(
          origin= {-100,100},
          lineThickness= 4,
          pattern= LinePattern.Solid,
          fillPattern= FillPattern.None,
          extent= {{2,-2},{198,-198}},
          rotation= 0.0
        )
      }
    )
  );
end UnidirectionalContractionComponent;
