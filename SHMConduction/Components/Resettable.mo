within SHMConduction.Components;
partial model Resettable "base class for all components that need a reset input"
  import SHMConduction.Components.Connectors.InstantInput;
  InstantInput reset "signal that resets internal variables" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-2, -98},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      ),
      iconTransformation(
        origin = {0, -108},
        extent = {{-10, -10}, {10, 10}}, rotation = 90
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
        Line(
          origin= {-100,100},
          pattern= LinePattern.Solid,
          thickness= 1.5,
          arrowSize= 5,
          points= {{82.25, -192.58}, {114.50, -192.58}, {114.50, -180.64}, {81.84, -180.64}},
          arrow= {Arrow.None, Arrow.Open},
          rotation= 0
        )
      }
    )
  );
end Resettable;
