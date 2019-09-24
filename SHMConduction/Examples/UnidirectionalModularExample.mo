within SHMConduction.Examples;
// TODO: add ontolgy links with annotation(__Ontology(foo="bar"))
model UnidirectionalModularExample "experiment to compare Conduction and ModularConduction"
  SHMConduction.Components.ModularConduction modC "modular contraction model";
  SHMConduction.Components.MonolithicConduction monC "original monolithic contraction model";
equation
  modC.inp = monC.signal;
  if time < 5 then
    monC.signal = sample(0,1);
  elseif time < 15 then
    monC.signal = sample(0,3);
  elseif time < 20 then
    // during Afib, atrial impulses occur at up to 600/min => with distance 0.1s
    // source: https://my.clevelandclinic.org/health/diseases/16765-atrial-fibrillation-afib
    monC.signal = sample(0,0.05);
  elseif time < 30 then
    monC.signal = sample(0,0.8);
  elseif time < 40 then
    monC.signal = sample(0,0.2);
  else
    monC.signal = sample(0,1.8);
  end if;
  annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end UnidirectionalModularExample;
