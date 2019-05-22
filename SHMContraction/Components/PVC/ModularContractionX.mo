within SHMContraction.Components.PVC;
model ModularContractionX
  extends UnidirectionalContractionComponent;
  RefractoryGateX refrac(T_refrac=0.364);
  Pacemaker pace(T=1.7);
  AVConductionDelayX cdelay;
  RefractoryGate vref(T_refrac=0.2);
  discrete Real T(start=1, fixed=true) "duration of last heart cycle";
  discrete Real cont_last(start=0, fixed=true) "time of last contraction";
  input Boolean pvc;
  Boolean pvc_upward = pre(pvc) and pre(outp) "true if we have PVC that travels upward";
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
