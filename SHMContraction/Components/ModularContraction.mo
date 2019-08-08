within SHMContraction.Components;
model ModularContraction
  extends UnidirectionalContractionComponent;
  RefractoryGate refrac(T_refrac=0.364) "refractory component for AV node";
  Pacemaker pace(T=1.7) "pacemaker effect of AV node";
  AVConductionDelay cdelay "delay from atrial side of AV node to ventricular side";
  discrete Modelica.SIunits.Period T(start=1, fixed=true) "duration of last heart cycle";
  discrete Modelica.SIunits.Time cont_last(start=0, fixed=true) "time of last contraction";
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  connect(cdelay.outp, outp);
  when outp.s then
    T = time - pre(cont_last);
    cont_last = time;
  end when;
end ModularContraction;
