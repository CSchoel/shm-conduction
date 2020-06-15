within SHMConduction.Components.PVC;
partial model ConductionDelayX "resettable variant of ConductionDelay (resetting cancels delayed signals)"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Hourglass;
  extends Resettable(reset.fixed=true); // cancels a signal that is currently on hold
  import SI = Modelica.SIunits;
  discrete SI.Duration d_delay "delay duration";
  Boolean delay_passed(start=false, fixed=true) = time > t_next or t_next > 1e99 "if false, there is still a signal currently put on hold";
protected
  discrete SI.Duration d_outp_inp(start=0, fixed=true) "time between last output and following signal";
  discrete SI.Time t_last(start=0, fixed=true) "time of last output";
  discrete SI.Time t_next(start=-1, fixed=true) "scheduled time of next output";
equation
  outp = edge(delay_passed);
  when pre(reset) or (inp and pre(delay_passed)) then
    d_outp_inp = time - pre(t_last);
  end when;
  when pre(reset) then
    t_next = 1e100;
  elsewhen inp and pre(delay_passed) then
    t_next = time + d_delay;
  end when;
  when outp or reset then
    t_last = time;
  end when;
end ConductionDelayX;
