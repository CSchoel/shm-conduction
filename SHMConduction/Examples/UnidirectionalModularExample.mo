within SHMConduction.Examples;
// TODO: add ontolgy links with annotation(__Ontology(foo="bar"))
model UnidirectionalModularExample "experiment to compare Contraction and ModularContraction"
  SHMConduction.Components.ModularContraction mc "modular contraction model";
  SHMConduction.Components.Contraction c "original monolithic contraction model";
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
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end UnidirectionalModularExample;
