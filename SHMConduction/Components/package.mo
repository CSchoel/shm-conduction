within SHMConduction;
package Components "contains individual modules"
  type InstantSignal = Boolean(quantity="InstantSignal")
    "signal that is only true for infinitesimal time instants (i.e. that behaves as Kronecker delta)";
annotation(Documentation(info="<html>
  <p>Contains component models used in the examples.</p>
</html>"));
end Components;