within SHMConduction.Components;
model RefractoryGate "refractory gate that can block or transmit signals"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Gate;
  extends SHMConduction.Icons.Constant;
  import SI = Modelica.SIunits;
  parameter SI.Time t_first = 0 "time of first signal";
  parameter SI.Duration d_refrac = 1 "duration of refractory period";
  Boolean refrac_passed = time - pre(t_last) > d_refrac "true if component is ready to receive a signal";
protected
  discrete SI.Time t_last(start=t_first, fixed=true) "time of last output";
equation
  outp = inp and refrac_passed;
  when outp then
    t_last = time;
  end when;
end RefractoryGate;
