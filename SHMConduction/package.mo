package SHMConduction "modular and monolithic models of the human cardiac conduction system based on the PhD thesis of H. Seidel"
annotation(
  uses(Modelica(version="3.2.3")),
  version="1.1.1",
  Documentation(info="<html>
  <p>Contains a modular version of the cardiac conduction system in the
  Seidel-Herzel-model (SHM).</p>

  <p>The SHM is a macro-level model of the human baroreflex that was
  originally written by Henrik Seidel in his PhD thesis in the language C
  <a href=\"#ref1\">[1]</a>.
  One part of this model is the cardiac conduction system that transfers
  signals from the sinus node to the ventricles where they trigger a
  ventricular contraction and thus the switch from diastole to systole.
  The cardiac conduction system is mainly controlled by the AV node that
  propagates sinus signals to the ventricles.</p>

  <p>The cardiac conduction submodel incorporates the following physiological
  effects.</p>

  <ul>
    <li><b>Refractory effect</b>: The atrioventricular (AV) node that reveives
    signals from the sinus node has a refractory period during which no
    excitation of the AV node can take place.</li>
    <li><b>Pacemaker effect</b>: If the sinus node does not send any signals
    for a prolonged time period, the AV node sends a signal on its own.</li>
    <li><b>Delay effect</b>: Signals traveling through the AV node are delayed.
    The duration of the delay depends on the time that has passed since the
    last signal has left the AV node.</li>
  </ul>

  <p>This package contains a monolithic version of the original model of the
  cardiac conduction system that was translated to Modelica, a modular version
  with small structural differences and an extension of this modular version
  that features a trigger for premature ventricular contractions (PVCs).</p>

  <p>The structural differences between the monolithic and modular versions
  are the following:</p>

  <table>
    <tr>
      <th>Monolithic version</th><th>Modular version</th>
    </tr>
    <tr>
      <td>Refractory time starts right after the contraction</td>
      <td>Refractory time starts right after sinus signal</td>
    </tr>
    <tr>
      <td>Pacemaker timer is reset after contraction</td>
      <td>Pacemaker timer is reset when sinus signal is received and AV node
      is not refractory</td>
    </tr>
    <tr>
      <td>Compares scheduled time stamps for next contraction that would be
      triggered by a delayed sinus signal or an intrinsic AV signal</td>
      <td>Every connection between components carries an actual signal;
      no scheduled time stamps are required</td>
    </tr>
  </table>

  <p>The Modelica version of the SHM model is described in detail in
  <a href=\"#ref2\">[2]</a>.
  The modular versions will be published in an upcoming paper
  <a href=\"#ref3\">[2]</a>.</p>

  <p><a name=\"ref1\">[1]</a> H. Seidel, &ldquo;Nonlinear dynamics of physiological
  rhythms,&rdquo; PhD thesis, Technische Universität Berlin, Berlin, Germany, 1997.
  </p>

  <p><a name=\"ref2\">[2]</a> C. Schölzel, A. Goesmann, G. Ernst, and A. Dominik,
  &ldquo;Modeling biology in Modelica: The human baroreflex,&rdquo; in Proceedings of the
  11th International Modelica Conference, Versailles, France, 2015, pp.
  367–376.</p>

  <p><a name=\"ref3\">[3]</a> C. Schölzel, V. Blesius, G. Ernst and
  A. Dominik, &ldquo;Required characteristics for modeling languages in systems
  biology: A software engineering perspective,&rdquo; unpublished.</p>
</html>"));
end SHMConduction;
