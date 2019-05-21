within SHMContraction.Components;
model ModularContraction
  extends UnidirectionalContractionComponent;
  RefractoryGate refrac;
  Pacemaker pace;
  AVConductionDelay cdelay;
  discrete Real T(start=initial_T, fixed=true) "duration of last heart cycle";
  discrete Real cont_last(start=initial_cont_last, fixed=true) "time of last contraction";
  parameter Real initial_T = 1 "initial value for duration of last heart cycle";
  parameter Real initial_cont_last = 0 "initial value for time of last contraction";
equation
  connect(inp, pace.inp);
  connect(pace.outp, refrac.inp);
  connect(refrac.outp, pace.reset);
  connect(refrac.outp, cdelay.inp);
  connect(cdelay.outp, outp);
  when outp then
    T = time - pre(cont_last);
    cont_last = time;
  end when;
end ModularContraction;
