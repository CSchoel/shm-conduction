within SHMContraction.Components;
partial model ConductionDelay
  extends UnidirectionalContractionComponent;
  discrete Real duration "delay duration";
  discrete Real T(start=0, fixed=true) "time between last output and following signal";
  discrete Real t_last(start=0, fixed=true) "time of last output";
  discrete Real t_next(start=-1, fixed=true) "time where next output is scheduled";
  Boolean delay_passed = time > t_next "if false, there is still a signal currently put on hold";
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
