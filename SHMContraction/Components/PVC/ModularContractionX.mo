within SHMContraction.Components.PVC;
model ModularContractionX
  extends UnidirectionalContractionComponent(outp.s.fixed=true);
  // outp.s is used in a when equation, so we need an initial value
  // TODO check if reasoning is correct
  RefractoryGateX refrac(T_refrac=0.364) "refractory component for AV node";
  Pacemaker pace(T=1.7) "pacemaker effect of AV node";
  AVConductionDelayX cdelay "delay from atrial side of AV node to ventricular side";
  RefractoryGate vref(T_refrac=0.2) "refractory component for ventricles";
  discrete Modelica.SIunits.Period T(start=1, fixed=true) "duration of last heart cycle";
  discrete Modelica.SIunits.Time cont_last(start=0, fixed=true) "time of last contraction";
  input InstantSignal pvc(start=false, fixed=true) "trigger signal for a PVC";
  InstantSignal pvc_upward = pre(pvc) and pre(outp.s) "true if we have PVC that travels upward";
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, cdelay.inp);
  vref.inp.s = pvc or cdelay.outp.s;
  connect(vref.outp, outp);
  pace.reset = pvc_upward or refrac.outp.s;
  connect(pvc_upward, refrac.reset);
  connect(pvc_upward, cdelay.reset);
  when outp.s then
    T = time - pre(cont_last);
    cont_last = time;
  end when;
end ModularContractionX;
