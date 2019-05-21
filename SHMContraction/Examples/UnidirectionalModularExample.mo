within SHMContraction.Examples;
model UnidirectionalModularExample
  SHMContraction.Components.ModularContraction mc;
  SHMContraction.Components.Contraction c;
  Real count_mc(start=0, fixed=true);
  Real count_c(start=0, fixed=true);
equation
  mc.inp = c.signal;
  if time < 5 then
    c.signal = sample(0,1);
  elseif time < 15 then
    c.signal = sample(0,3);
  elseif time < 20 then
    // during Afib, atrial impulses occur at up to 600/min => with distance 0.1s
    // source: https://my.clevelandclinic.org/health/diseases/16765-atrial-fibrillation-afib
    c.signal = sample(0,0.05);
  elseif time < 30 then
    c.signal = sample(0,0.8);
  elseif time < 40 then
    c.signal = sample(0,0.2);
  else
    c.signal = sample(0,1.8);
  end if;
  when c.contraction then
    count_c = pre(count_c) + 1;
  end when;
  when mc.outp then
    count_mc = pre(count_mc) + 1;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end UnidirectionalModularExample;
