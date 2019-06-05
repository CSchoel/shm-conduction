within SHMContraction.Components.PVC;
model ModularContractionX
  extends UnidirectionalContractionComponent(outp.fixed=true);
  RefractoryGateX refrac(T_refrac=0.364) "refractory component for AV node";
  Pacemaker pace(T=1.7) "pacemaker effect of AV node";
  AVConductionDelayX cdelay "delay from atrial side of AV node to ventricular side";
  RefractoryGate vref(T_refrac=0.2) "refractory component for ventricles";
  discrete Modelica.SIunits.Period T(start=1, fixed=true) "duration of last heart cycle";
  discrete Modelica.SIunits.Time cont_last(start=0, fixed=true) "time of last contraction";
  input InstantSignal pvc(fixed=true) "trigger signal for a PVC";
  InstantSignal pvc_upward = pre(pvc) and pre(outp) "true if we have PVC that travels upward";
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, cdelay.inp);
  vref.inp = pvc or cdelay.outp;
  connect(vref.outp, outp);
  pace.reset = pvc_upward or refrac.outp;
  connect(pvc_upward, refrac.reset);
  connect(pvc_upward, cdelay.reset);
  when outp then
    T = time - pre(cont_last);
    cont_last = time;
  end when;
end ModularContractionX;
