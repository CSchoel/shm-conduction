within SHMContraction.Components;
model Pacemaker
  extends UnidirectionalContractionComponent;
  extends SHMContraction.Icons.Metronome;
  extends Resettable; // resets internal clock
  parameter Modelica.SIunits.Period T = 1 "pacemaker period";
  InstantSignal spontaneous_signal = time > pre(t_next)
    "signal generated spontaneously by this pacemaker";
protected
  discrete Modelica.SIunits.Time t_next(start=T, fixed=true);
equation
  outp.s = inp.s or spontaneous_signal;
  when spontaneous_signal or reset.s then
    t_next = time + T;
  end when;
end Pacemaker;
