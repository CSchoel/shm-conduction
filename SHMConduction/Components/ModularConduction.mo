within SHMConduction.Components;
model ModularConduction "modular version of the model of the cardiac conduction system by H. Seidel"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Heart;
  import SI = Modelica.SIunits;
  RefractoryGate refrac_av(d_refrac=0.364) "refractory component for AV node" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {6, 5.77316e-15},
        extent = {{-20, -20}, {20, 20}}, rotation = 0
      )
    )
  );
  Pacemaker pace_av(period=1.7) "pacemaker effect of AV node" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-52, 3.77476e-15},
        extent = {{-20, -20}, {20, 20}}, rotation = 0
      )
    )
  );
  AVConductionDelay delay_sa_v "total delay between SA node and ventricles" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {62, 3.55271e-15},
        extent = {{-20, -20}, {20, 20}}, rotation = 0
      )
    )
  );
  discrete SI.Duration d_interbeat(start=1, fixed=true) "duration of last heart cycle (interbeat interval)";
  discrete SI.Time cont_last(start=0, fixed=true) "time of last contraction";
equation
  connect(inp, pace_av.inp) annotation(
    Line(thickness = 1, points = {{-74, 0}, {-96, 0}, {-96, 0}, {-100, 0}})
  );
  connect(pace_av.outp, refrac_av.inp) annotation(
    Line(thickness = 1, points = {{-30, 0}, {-16, 0}, {-16, 0}, {-16, 0}})
  );
  connect(refrac_av.outp, pace_av.reset) annotation(
    Line(thickness = 1, points = {{28, 0}, {34, 0}, {34, -44}, {-52, -44}, {-52, -22}, {-52, -22}})
  );
  connect(refrac_av.outp, delay_sa_v.inp) annotation(
    Line(thickness = 1, points = {{28, 0}, {42, 0}, {42, 0}, {40, 0}})
  );
  connect(delay_sa_v.outp, outp) annotation(
    Line(thickness = 1, points = {{84, 0}, {102, 0}, {102, 0}, {102, 0}})
  );
  when outp then
    d_interbeat = time - pre(cont_last);
    cont_last = time;
  end when;
  annotation(
    Icon(
      graphics = {
        Line(
          origin = {-75, 5},
          points = {{-17, -5}, {17, 5}},
          arrow = {Arrow.None, Arrow.Open},
          thickness = 1,
          arrowSize = 5
        ),
        Line(
          origin = {75, -20},
          points = {{-19, -18}, {19, 18}},
          arrow = {Arrow.None, Arrow.Open},
          thickness = 1,
          arrowSize = 5
        )
      }
    )
  );
end ModularConduction;
