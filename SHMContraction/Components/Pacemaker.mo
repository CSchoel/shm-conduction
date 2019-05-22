within SHMContraction.Components;
model Pacemaker
  extends UnidirectionalContractionComponent;
  parameter Real T = 1 "pacemaker period";
  input Boolean reset;
  Boolean autonomic_signal = time > pre(t_next);
protected
  Real t_next(start=T, fixed=true);
equation
  outp = inp or autonomic_signal;
  when autonomic_signal or reset then
    t_next = time + T;
  end when;
end Pacemaker;
