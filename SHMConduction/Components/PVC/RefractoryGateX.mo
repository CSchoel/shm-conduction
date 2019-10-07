within SHMConduction.Components.PVC;
model RefractoryGateX "resettable variant of RefractoryGate"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Gate;
  extends SHMConduction.Icons.Constant;
  extends Resettable; // resets internal clock
  parameter Modelica.SIunits.Time t_first = 0 "time of first signal";
  parameter Modelica.SIunits.Duration T_refrac = 1 "refractory period";
  Boolean refrac_passed = time - pre(t_last) > T_refrac "true if component is ready to receive a signal";
protected
  Modelica.SIunits.Time t_last(start=t_first, fixed=true) "time of last output";
equation
  outp = inp and refrac_passed;
  when outp or reset then
    t_last = time;
  end when;
end RefractoryGateX;
