within SHMConduction.Examples;
model PVCExample "experiment to test response of ModularConductionX to PVCs"
  SHMConduction.Components.PVC.ModularConductionX con;
  import SI = Modelica.SIunits;
  discrete SI.Time sig_last(start=0, fixed=true) "time where last SA/AV signal was received";
  Integer count_sig(start=0, fixed=true) "counts SA/AV signals";
  parameter Boolean with_sinus = true "if true, a sinus signal is applied, otherwise only the AV node is active";
  parameter SI.Period normal_interval = if with_sinus then 0.8 else con.pace_av.period "normal cycle duration without PVC";
  discrete SI.Duration t_since_sig = time - pre(sig_last) "time since last signal from SA/AV node";
  Boolean pvc_a = pre(count_sig) == 5 and t_since_sig > con.delay_sa_v.d_avc0 / 2
    "timer for PVC a): while 6th beat is delayed";
  Boolean pvc_b = pre(count_sig) == 12 and t_since_sig > con.refrac_av.d_refrac / 2
    "timer for PVC b): after 12th beat within refractory period";
  Boolean pvc_c = pre(count_sig) == 19 and t_since_sig > normal_interval / 2
    "timer for PVC c): between 19th and 20th beat (after refractory period)";
  Boolean pvc_d = pre(count_sig) == 26 and
    t_since_sig > normal_interval - con.delay_sa_v.d_avc0 / 2
    "timer for PVC d): just before the 27th beat was signalled";
  Boolean trigger(start=false, fixed=true) = pvc_a or pvc_b or pvc_c or pvc_d "pvc trigger signal";
equation
  con.pvc = edge(trigger);
  if with_sinus then
    con.inp = sample(0, normal_interval) "undisturbed normal sinus rhythm";
  else
    con.inp = false "no sinus, only AV node";
  end if;
  when con.refrac_av.outp then
    count_sig = pre(count_sig) + 1;
    sig_last = time;
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 55, Tolerance = 1e-6, Interval = 0.002),
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl")
  );
end PVCExample;
