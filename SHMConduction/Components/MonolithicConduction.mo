within SHMConduction.Components;
model MonolithicConduction "cardiac conduction system of the human heart adapted from the doctorate thesis of H. Seidel"
  input InstantSignal inp(start=false, fixed=true) "the sinus signal";
  output InstantSignal outp(start=false, fixed=true) "true when a contraction is triggered";
  parameter Modelica.SIunits.Duration d_refrac = 0.22 "refractory period that has to pass until a signal from the sinus node can take effect again";
  parameter Modelica.SIunits.Period av_period = 1.7 "av-node cycle duration";
  parameter Modelica.SIunits.Duration k_avc_t = 0.78 "sensitivity of the atrioventricular conduction time to the time passed since the last ventricular conduction";
  parameter Modelica.SIunits.Duration d_avc0 = 0.09 "base value for atrioventricular conduction time";
  parameter Modelica.SIunits.Duration tau_avc = 0.11 "reference time for atrioventricular conduction time"; //TODO find better description
  parameter Modelica.SIunits.Period initial_d_sinus_sinus = 1 "initial value for d_sinus_sinus";
  parameter Modelica.SIunits.Period initial_d_interbeat = 1 "initial value for d_interbeat";
  parameter Modelica.SIunits.Time initial_cont_last = 0 "initial value for last ventricular contraction time";
  parameter Modelica.SIunits.Duration initial_d_delay = 0.15 "initial value for atrioventricular conduction time";
  output Boolean av_contraction "true when the av-node triggers a contraction";
  output Boolean sinus_contraction "true when the sinus node triggers a contraction";
  output Boolean refrac_passed(start=false, fixed=true) "true when the refractory period has passed";
  discrete output Modelica.SIunits.Period d_sinus_sinus "time between the last two sinus signals that did trigger a contraction";
  discrete output Modelica.SIunits.Period d_interbeat "time between the last two contractions";
protected
  discrete Modelica.SIunits.Time cont_last "time of last contraction";
  discrete Modelica.SIunits.Duration d_delay "atrioventricular conduction time (delay for sinus signal to trigger contraction)";
  Modelica.SIunits.Duration since_cont "helper variable; time passed since last contraction";
  Boolean signal_received(start=false, fixed=true) "true, if a sinus signal has already been received since the last contraction";
  discrete Modelica.SIunits.Time sinus_last "time of last received sinus signal";
  Boolean contraction_event(start=false, fixed=true);
initial equation
  cont_last = initial_cont_last;
  sinus_last = 0;
  d_sinus_sinus = initial_d_sinus_sinus;
  d_interbeat = initial_d_interbeat;
  d_delay = initial_d_delay;
equation
  signal_received = sinus_last > cont_last;
  refrac_passed = since_cont > d_refrac;
  contraction_event = (av_contraction or sinus_contraction) and refrac_passed "contraction can come from av-node or sinus node";
  outp = edge(contraction_event);
  av_contraction = since_cont > av_period "av-node contracts when av_period has passed since last contraction";
  sinus_contraction = signal_received and time > sinus_last + d_delay "sinus node contracts when d_delay has passed since last sinus signal";
  since_cont = time - cont_last;
  //sinus signal is recognized if refractory period has passed and there is no other sinus signal already in effect
  when inp and pre(refrac_passed) and not pre(signal_received) then
    d_delay = d_avc0 + k_avc_t * exp(-since_cont / tau_avc) "schedules next sinus_contraction";
    sinus_last = time "record timestamp of recognized sinus signal";
    d_sinus_sinus = time - pre(sinus_last);
  end when;
  when pre(outp) then
    cont_last = time "record timestamp of contraction";
    d_interbeat = time - pre(cont_last);
  end when;
  annotation(Documentation(info = "<html>
  <p>Models the contraction of the heart as described in Seidel's thesis.</p>
  <p>The model takes into account the following effects:</p>
  <ul>
    <li>There is a refractory period of duration <b>d_refrac</b> after a contraction during which signals of the sinus node are ignored.
    <li>If no sinus-induced contraction occurs for a prolonged time span (namely <b>av_period</b>) the av-node initiates a contraction by itself.
    <li>When a sinus signal is received, the upper heart contracts pumping the blood from the atrium into the ventricles. The systole does only
    begin with the second contraction of the heart. The time period between these two events is called the &quot;atrioventricular conduction time&quot;.
  </ul>
  <p><i>Note: The formulas in this model differ from the formulas found in the c-implementation by Seidel because OpenModelica is currently
  not capable of handling discrete equation systems. Therefore it was necessary to introduce the continuous phases <b>av_phase</b>,
  <b>sinus_phase</b> and <b>refrac_countdown</b>, as well as the continuous variable condition <b>signal_received_cont</b>.</i></p>
</html>"));
end MonolithicConduction;
