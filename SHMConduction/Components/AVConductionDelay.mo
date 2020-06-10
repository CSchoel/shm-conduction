within SHMConduction.Components;
model AVConductionDelay "conduction delay between start of AV node and ventricles"
  extends ConductionDelay;
  parameter Modelica.SIunits.Duration k_avc_t = 0.78 "maximum increase in delay duration";
  parameter Modelica.SIunits.Duration d_avc0 = 0.09 "minimal delay duration";
  parameter Modelica.SIunits.Duration tau_avc = 0.11 "reference time for delay duration";
  parameter Modelica.SIunits.Duration initial_d_avc = 0.15 "initial value for delay duration";
initial equation
  d_delay = initial_d_avc;
equation
  when inp and pre(delay_passed) then
    d_delay = d_avc0 + k_avc_t * exp(-d_outp_inp/tau_avc);
  end when;
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Text(
          origin = {-55, 1},
          extent = {{-21, 19}, {27, -23}},
          textString = "AVN"
        )
      }
    )
  );
end AVConductionDelay;
