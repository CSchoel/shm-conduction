within SHMContraction.Components;
model Pacemaker
  extends UnidirectionalContractionComponent;
  parameter Real T = 1 "pacemaker period";
  input Boolean reset;
protected
  Real t_next(start=T, fixed=true);
equation
  outp = inp or time > pre(t_next);
  when outp or reset then
    t_next = time + T;
  end when;
end Pacemaker;
