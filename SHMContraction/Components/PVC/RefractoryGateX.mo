within SHMContraction.Components.PVC;
model RefractoryGateX
  extends UnidirectionalContractionComponent;
  parameter Real t_first = 0 "time of first signal";
  parameter Real T_refrac = 1 "refractory period";
  Boolean refrac_passed = time - pre(t_last) > T_refrac "true if component is ready to receive a signal";
  input Boolean reset "signal that resets internal clock";
protected
  Real t_last(start=t_first) "time of last output";
equation
  outp = inp and refrac_passed;
  when outp or reset then
    t_last = time;
  end when;
end RefractoryGateX;
