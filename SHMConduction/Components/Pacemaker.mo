within SHMConduction.Components;
model Pacemaker "pacemaker that can elicit spontaneous signals and transmit incoming signals"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Metronome;
  extends SHMConduction.Icons.Constant;
  extends Resettable(reset.fixed=true); // resets internal clock
  import SI = Modelica.SIunits;
  parameter SI.Period period = 1 "pacemaker period";
protected
  discrete SI.Time t_next(start=period, fixed=true) "scheduled time of next spontaneous beat";
  InstantSignal spontaneous_signal = time > pre(t_next)
    "signal generated spontaneously by this pacemaker";
equation
  outp = inp or spontaneous_signal;
  when spontaneous_signal or pre(reset) then
    t_next = time + period;
  end when;
end Pacemaker;
