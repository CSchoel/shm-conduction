within SHMContraction.Components.PVC;
model AVConductionDelayX "resettable variant of AVConductionDelay (resetting cancels delayed signals)"
  extends ConductionDelayX;
  parameter Modelica.SIunits.Duration k_avc_t = 0.78 "maximum increase in delay duration";
  parameter Modelica.SIunits.Duration T_avc0 = 0.09 "minimal delay duration";
  parameter Modelica.SIunits.Duration tau_avc = 0.11 "reference time for delay duration";
  parameter Modelica.SIunits.Duration initial_T_avc = 0.15 "initial value for delay duration";
initial equation
  duration = initial_T_avc;
equation
  when inp and pre(delay_passed) then
    duration = T_avc0 + k_avc_t * exp(-T/tau_avc);
  end when;
  annotation(
    Icon(
      coordinateSystem(
        preserveAspectRatio= false,
        extent= {{-100,-100},{100,100}}
      ),
      graphics= {
        Text(
          origin= {-100,100},
          lineThickness= 0.56,
          fontName= sans-serif,
          extent= {{18.76,-87.62},{75.20,-115.84}},
          pattern= LinePattern.Solid,
          textString= "AVN",
          fontSize= 79.9999996978,
          lineColor= {0,0,0},
          horizontalAlignment= TextAlignment.Left,
          rotation= 0
        )
      }
    )
  );
end AVConductionDelayX;
