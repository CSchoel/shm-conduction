within SHMContraction.Components;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
  Real duration;
  Real T(start=0, fixed=true);
  Real t_last(start=0, fixed=true);
  Real t_next(start=-1, fixed=true);
  Boolean delay_passed = time > t_next;
equation
  outp = edge(delay_passed);
  when inp and pre(delay_passed) then
    T = time - pre(t_last);
    t_next = time + duration;
  end when;
  when outp then
    t_last = time;
  end when;
end ConductionDelay;
