within SHMContraction.Components;
model Pacemaker
  extends UnidirectionalContractionComponent;
  parameter Modelica.SIunits.Period T = 1 "pacemaker period";
  input InstantSignal reset "signal that resets the internal clock";
  InstantSignal spontaneous_signal = time > pre(t_next)
    "signal generated spontaneously by this pacemaker";
protected
  discrete Modelica.SIunits.Time t_next(start=T, fixed=true);
equation
  outp.s = inp.s or spontaneous_signal;
  when spontaneous_signal or reset then
    t_next = time + T;
  end when;
end Pacemaker;
