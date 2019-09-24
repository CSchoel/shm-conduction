within SHMConduction.Components;
model Pacemaker "pacemaker that can elicit spontaneous signals and transmit incoming signals"
  extends UnidirectionalContractionComponent;
  extends SHMConduction.Icons.Metronome;
  extends Resettable(reset.fixed=true); // resets internal clock
  parameter Modelica.SIunits.Period T = 1 "pacemaker period";
  InstantSignal spontaneous_signal = time > pre(t_next)
    "signal generated spontaneously by this pacemaker";
protected
  discrete Modelica.SIunits.Time t_next(start=T, fixed=true);
equation
  outp = inp or spontaneous_signal;
  when spontaneous_signal or pre(reset) then
    t_next = time + T;
  end when;
end Pacemaker;
