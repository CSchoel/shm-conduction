within SHMContraction.Components;
partial model Resettable
  import SHMContraction.Components.Connectors.InstantInput;
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
end Resettable;
