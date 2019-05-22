within SHMContraction.Components;
model RefractoryGate
  extends UnidirectionalContractionComponent;
  parameter Modelica.SIunits.Time t_first = 0 "time of first signal";
  parameter Modelica.SIunits.Period T_refrac = 1 "refractory period";
  Boolean refrac_passed = time - pre(t_last) > T_refrac "true if component is ready to receive a signal";
protected
  Real t_last(start=t_first) "time of last output";
equation
  outp = inp and refrac_passed;
  when outp then
    t_last = time;
  end when;
end RefractoryGate;
