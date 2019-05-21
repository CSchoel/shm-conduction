within SHMContraction.Components;
model ModularContraction
  extends UnidirectionalContractionComponent;
  RefractoryGate refrac;
  Pacemaker pace;
  AVConductionDelay cdelay;
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  connect(cdelay.outp, outp);
end ModularContraction;
