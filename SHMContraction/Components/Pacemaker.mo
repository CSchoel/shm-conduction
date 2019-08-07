within SHMContraction.Components;
model Pacemaker
  extends UnidirectionalContractionComponent;
  parameter Modelica.SIunits.Period T = 1 "pacemaker period";
  input InstantSignal reset "signal that resets the internal clock";
  // TODO maybe instrinsic would be better than autonomic (because ANS)
  InstantSignal autonomic_signal = time > pre(t_next) "signal generated by this pacemaker";
protected
  discrete Modelica.SIunits.Time t_next(start=T, fixed=true);
equation
  outp = inp or autonomic_signal;
  when autonomic_signal or reset then
    t_next = time + T;
  end when;
end Pacemaker;
