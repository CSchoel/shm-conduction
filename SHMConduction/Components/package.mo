within SHMConduction;
package Components "contains individual modules"
  type InstantSignal = Boolean(quantity="sum of Kronecker deltas")
    "signal that is only true for exact time instants (i.e. that behaves as a sum of Kronecker deltas)";
annotation(Documentation(info="<html>
  <p>Contains component models used in the examples.</p>
</html>"));
end Components;
