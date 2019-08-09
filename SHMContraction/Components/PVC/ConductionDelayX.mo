within SHMContraction.Components.PVC;
partial model ConductionDelayX
  extends UnidirectionalContractionComponent;
  extends SHMContraction.Icons.Hourglass;
  Modelica.SIunits.Duration duration "delay duration";
  Modelica.SIunits.Period T(start=0, fixed=true) "time between last output and following signal";
  Modelica.SIunits.Time t_last(start=0, fixed=true) "time of last output";
  Modelica.SIunits.Time t_next(start=-1, fixed=true) "time where next output is scheduled";
  Boolean delay_passed(start=false, fixed=true) = time > t_next or t_next > 1e99 "if false, there is still a signal currently put on hold";
  input InstantSignal reset "reset signal that cancels a signal that is currently on hold";
equation
  outp.s = edge(delay_passed);
  when reset or (inp.s and pre(delay_passed)) then
    T = time - pre(t_last);
  end when;
  when reset then
    t_next = 1e100;
  elsewhen inp.s and pre(delay_passed) then
    t_next = time + duration;
  end when;
  when outp.s or reset then
    t_last = time;
  end when;
end ConductionDelayX;
