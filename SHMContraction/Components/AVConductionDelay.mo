within SHMContraction.Components;
model AVConductionDelay
  extends ConductionDelay;
  parameter Real k_avc_t = 0.78 "maximum increase in delay duration";
  parameter Real T_avc0 = 0.09 "minimal delay duration";
  parameter Real tau_avc = 0.11 "reference time for delay duration";
  parameter Real initial_T_avc = 0.15 "initial value for delay duration";
initial equation
  duration = initial_T_avc;
equation
  when inp and pre(delay_passed) then
    duration = T_avc0 + k_avc_t * exp(-T/tau_avc);
  end when;
end AVConductionDelay;
