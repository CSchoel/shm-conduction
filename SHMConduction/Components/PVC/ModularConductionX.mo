within SHMConduction.Components.PVC;
model ModularConductionX "cardiac conduction system with trigger for PVCs"
  extends UnidirectionalConductionComponent(outp.fixed=true);
  extends SHMConduction.Icons.Heart;
  import SHMConduction.Components.Connectors.InstantInput;
  // outp is used in a when equation, so we need an initial value
  RefractoryGateX refrac_av(T_refrac=0.364) "refractory component for AV node" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-20, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  Pacemaker pace_av(T=1.7) "pacemaker effect of AV node" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-60, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  AVConductionDelayX delay_sa_v "total delay between SA node and ventricles" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {20, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  RefractoryGate refrac_v(T_refrac=0.2) "refractory component for ventricles" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {60, 0},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  discrete Modelica.SIunits.Period T(start=1, fixed=true) "duration of last heart cycle";
  discrete Modelica.SIunits.Time cont_last(start=0, fixed=true) "time of last contraction";
  InstantInput pvc(fixed=true) "trigger signal for a PVC" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {76, -76},
        extent = {{-10, -10}, {10, 10}}, rotation = 135
      ),
      iconTransformation(
        origin = {76, -76},
        extent = {{-10, -10}, {10, 10}}, rotation = 135
      )
    )
  );
  Modelica.Blocks.Logical.Or vcont annotation(
    Placement(
      visible = true,
      transformation(
        origin = {42, -36},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  Modelica.Blocks.Logical.Or rpace annotation(
    Placement(
      visible = true,
      transformation(
        origin = {-60, -38},
        extent = {{-10, -10}, {10, 10}}, rotation = 0
      )
    )
  );
  Modelica.Blocks.Logical.And pvc_upward "true if we have PVC that travels upward" annotation(
    Placement(
      visible = true,
      transformation(
        origin = {20, -72},
        extent = {{10, -10}, {-10, 10}}, rotation = 0
      )
    )
  );
equation
  connect(inp, pace_av.inp) annotation(
    Line(points = {{-100, 0}, {-72, 0}, {-72, 0}, {-70, 0}})
  );
  connect(pace_av.outp, refrac_av.inp) annotation(
    Line(points = {{-50, 0}, {-30, 0}, {-30, 0}, {-30, 0}})
  );
  connect(refrac_av.outp, delay_sa_v.inp) annotation(
    Line(points = {{-10, 0}, {10, 0}, {10, 0}, {10, 0}})
  );
  connect(delay_sa_v.outp, vcont.u1) annotation(
    Line(points = {{30, 0}, {34, 0}, {34, -22}, {16, -22}, {16, -36}, {30, -36}, {30, -36}})
  );
  connect(refrac_av.outp, rpace.u2) annotation(
    Line(points = {{-10, 0}, {-6, 0}, {-6, -58}, {-78, -58}, {-78, -46}, {-72, -46}, {-72, -46}})
  );
  connect(vcont.y, refrac_v.inp) annotation(
    Line(points = {{54, -36}, {60, -36}, {60, -12}, {42, -12}, {42, 0}, {50, 0}, {50, 0}}, color = {255, 0, 255})
  );
  connect(refrac_v.outp, outp) annotation(
    Line(points = {{70, 0}, {98, 0}, {98, 0}, {102, 0}})
  );
  connect(outp, pvc_upward.u1) annotation(
    Line(points = {{102, 0}, {84, 0}, {84, -54}, {50, -54}, {50, -72}, {32, -72}, {32, -72}})
  );
  connect(pvc, pvc_upward.u2) annotation(
    Line(points = {{76, -76}, {50, -76}, {50, -80}, {32, -80}, {32, -80}})
  );
  connect(pvc_upward.y, refrac_av.reset) annotation(
    Line(points = {{10, -72}, {-20, -72}, {-20, -10}, {-20, -10}}, color = {255, 0, 255})
  );
  connect(pvc_upward.y, delay_sa_v.reset) annotation(
    Line(points = {{10, -72}, {2, -72}, {2, -18}, {20, -18}, {20, -10}, {20, -10}}, color = {255, 0, 255})
  );
  connect(pvc_upward.y, rpace.u1) annotation(
    Line(points = {{10, -72}, {-84, -72}, {-84, -38}, {-72, -38}, {-72, -38}}, color = {255, 0, 255})
  );
  connect(rpace.y, pace_av.reset) annotation(
    Line(points = {{-48, -38}, {-44, -38}, {-44, -16}, {-60, -16}, {-60, -10}, {-60, -10}}, color = {255, 0, 255})
  );
  connect(pvc, vcont.u2) annotation(
    Line(points = {{76, -76}, {70, -76}, {70, -50}, {16, -50}, {16, -44}, {30, -44}})
  );
  when outp then
    T = time - pre(cont_last);
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
        ),
        Line(
          origin = {60, -64},
          points = {{6, 0}, {-6, 0}},
          arrow = {Arrow.None, Arrow.Open},
          thickness = 1,
          arrowSize = 5
        )
      }
    )
  );
end ModularConductionX;
