within SHMConduction.Components.PVC;
partial model ConductionDelayX "resettable variant of ConductionDelay (resetting cancels delayed signals)"
  extends UnidirectionalConductionComponent;
  extends SHMConduction.Icons.Hourglass;
  extends Resettable(reset.fixed=true); // cancels a signal that is currently on hold
  Modelica.SIunits.Duration duration "delay duration";
  Modelica.SIunits.Period T(start=0, fixed=true) "time between last output and following signal";
  Modelica.SIunits.Time t_last(start=0, fixed=true) "time of last output";
  Modelica.SIunits.Time t_next(start=-1, fixed=true) "time where next output is scheduled";
  Boolean delay_passed(start=false, fixed=true) = time > t_next or t_next > 1e99 "if false, there is still a signal currently put on hold";
equation
  outp = edge(delay_passed);
  when pre(reset) or (inp and pre(delay_passed)) then
    T = time - pre(t_last);
  end when;
  when pre(reset) then
    t_next = 1e100;
  elsewhen inp and pre(delay_passed) then
    t_next = time + duration;
  end when;
  when outp or reset then
    t_last = time;
  end when;
end ConductionDelayX;
