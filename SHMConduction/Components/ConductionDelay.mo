within SHMConduction.Components;
partial model ConductionDelay "cardiac conduction delay that depends on previous cycle duration"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Hourglass;
  import SI = Modelica.SIunits;
  discrete SI.Duration d_delay "delay duration";
  Boolean delay_passed(start=false, fixed=true) = time > t_next "if false, there is still a signal currently put on hold";
  discrete SI.Duration d_outp_inp(start=0, fixed=true) "time between last output and following signal";
  discrete SI.Time t_last(start=0, fixed=true) "time of last output";
  discrete SI.Time t_next(start=-1, fixed=true) "scheduled time of next output";
equation
  outp = edge(delay_passed);
  when inp and pre(delay_passed) then
    d_outp_inp = time - pre(t_last);
    t_next = time + d_delay;
  end when;
  when outp then
    t_last = time;
  end when;
end ConductionDelay;
