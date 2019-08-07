within SHMContraction.Components;
model Contraction "cardiac conduction system of the human heart adapted from the doctorate thesis of H. Seidel"
  parameter Modelica.SIunits.Duration T_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Modelica.SIunits.Period T_av = 1.7 "av-node cycle duration";
  parameter Modelica.SIunits.Duration k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Modelica.SIunits.Duration T_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Modelica.SIunits.Duration tau_avc = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  parameter Modelica.SIunits.Period initial_T = 1 "initial value for T";
  parameter Modelica.SIunits.Period initial_T_cont = 1 "initial value for T_cont";
  parameter Modelica.SIunits.Time initial_cont_last = 0 "initial value for last ventricular contraction time";
  parameter Modelica.SIunits.Duration initial_T_avc = 0.15 "initial value for atrioventricular conduction time";
  discrete Modelica.SIunits.Time cont_last "time of last contraction";
  discrete Modelica.SIunits.Duration T_avc "atrioventricular conduction time (delay for sinus signal to trigger contraction)";
  input InstantSignal signal(start=false, fixed=true) "the sinus signal";
  output InstantSignal contraction(start=false, fixed=true) "true when a contraction is triggered";
  output Boolean av_contraction "true when the av-node triggers a contraction";
  output Boolean sinus_contraction "true when the sinus node triggers a contraction";
  output Boolean refrac_passed(start=false, fixed=true) "true when the refractory period has passed";
  discrete output Modelica.SIunits.Period T "time between the last two sinus signals that did trigger a contraction";
  discrete output Modelica.SIunits.Period T_cont "time between the last two contractions";
  Modelica.SIunits.Duration T_passed "helper variable; time passed since last contraction";
  Boolean signal_received(start=false, fixed=true) "true, if a sinus signal has already been received since the last contraction";
  discrete Modelica.SIunits.Time sinus_last "time of last received sinus signal";
protected
  Boolean contraction_event(start=false, fixed=true);
initial equation
  cont_last = initial_cont_last;
  sinus_last = 0;
  T = initial_T;
  T_cont = initial_T_cont;
  T_avc = initial_T_avc;
equation
  signal_received = sinus_last > cont_last;
  refrac_passed = T_passed > T_refrac;
  contraction_event = (av_contraction or sinus_contraction) and refrac_passed "contraction can come from av-node or sinus node";
  contraction = edge(contraction_event);
  av_contraction = T_passed > T_av "av-node contracts when T_av has passed since last contraction";
  sinus_contraction = signal_received and time > sinus_last + T_avc "sinus node contracts when T_avc has passed since last sinus signal";
  T_passed = time - cont_last;
  //sinus signal is recognized if refractory period has passed and there is no other sinus signal already in effect
  when signal and pre(refrac_passed) and not pre(signal_received) then
    T_avc = T_avc0 + k_avc_t * exp(-T_passed / tau_avc) "schedules next sinus_contraction";
    sinus_last = time "record timestamp of recognized sinus signal";
    T = time - pre(sinus_last);
  end when;
  when pre(contraction) then
    cont_last = time "record timestamp of contraction";
    T_cont = time - pre(cont_last);
  end when;
  annotation(Documentation(info = "<html>
  <p>Models the contraction of the heart as described in Seidel's thesis.</p>
  <p>The model takes into account the following effects:</p>
  <ul>
    <li>There is a refractory period of duration <b>T_refrac</b> after a contraction during which signals of the sinus node are ignored.
    <li>If no sinus-induced contraction occurs for a prolonged time span (namely <b>T_av</b>) the av-node initiates a contraction by itself.
    <li>When a sinus signal is received, the upper heart contracts pumping the blood from the atrium into the ventricles. The systole does only
    begin with the second contraction of the heart. The time period between these two events is called the &quot;atrioventricular conduction time&quot;.
  </ul>
  <p><i>Note: The formulas in this model differ from the formulas found in the c-implementation by Seidel because OpenModelica is currently
  not capable of handling discrete equation systems. Therefore it was necessary to introduce the continuous phases <b>av_phase</b>,
  <b>sinus_phase</b> and <b>refrac_countdown</b>, as well as the continuous variable condition <b>signal_received_cont</b>.</i></p>
</html>"));
end Contraction;
