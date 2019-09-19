# SHM-Contraction

This repository contains a modular model of the human cardiac conduction system written in [Modelica](https://www.modelica.org/) as well as an extension of this model that introduces a trigger for [premature ventricular contractions (PVCs)](https://en.wikipedia.org/wiki/Premature_ventricular_contraction).
It is based on the Seidel-Herzel Model (SHM) of the human baroreflex that was first published by Henrik Seidel in his PhD thesis \[[1]\].

The monolithic version of the conduction system model is based on a previous translation of the whole SHM from C to Modelica \[[2]\].
This modular version and the PVC extension where developed as an example how a language that is modular, hybrid (supporting multiple formalisms), human-readable, open-source, declarative, and graphical can facilitate model reuse.
This will be discussed in detail in an upcoming paper of our research group \[[3]\].

## Project structure

The main parts of this project can be found in the following files:

* `SHMContraction/package.mo` contains a full description of the models in this project.
* `SHMContraction/Components/Contraction.mo` contains the monolithic version of the contraction model.
* `SHMContraction/Components/ModularContraction.mo` is the main file for the modular version binding all submodules together.
* `SHMContraction/Components/PVC/ModularContractionX.mo` is the main file for the extended modular version with PVCs.
* `SHMContraction/Examples/UnidirectionalModularExample.mo` contains a simulation example that compares the monolithic `Contraction.mo` with the modular `ModularContraction.mo`.
* `SHMContraction/Examples/PVCExample.mo` contains a simulation example that tests the PVC extension for plausibility.

## Reproduction of plots from the paper

If you want to reproduce the plots in \[[3]\], you can do so in the following steps:

1. Download and install [OpenModelica](https://openmodelica.org/).
2. Clone or download this repository.
3. Start OMEdit and open the folder `SHMContraction` with File ➡️ Load Library....

For Figure 1:

* Open the model `SHMContraction/Examples/UnidirectionalModularExample` (select from navigation window on the left side with a double click).
* Select the simulate button from the tool bar, leave all settings at their default values, and click on "simulate".

For Figure 2:

* Open the model `SHMContraction/Examples/PVCExample` (select from navigation window on the left side with a double click).
* In the parameter view select `with_sinus` either to be `true` to produce the left subfigure or `false` for the right subfigure.
* Select the simulate button from the tool bar, leave all settings at their default values, and click on "simulate".

## References

[1]: #seidel1997
[2]: #schoelzel2015
[3]: #schoelzel2019

\[<a name="seidel1997">1</a>\] H. Seidel, “Nonlinear dynamics of physiological rhythms,” PhD thesis, Technische Universität Berlin, Berlin, Germany, 1997.

\[<a name="schoelzel2015">2</a>] C. Schölzel, A. Goesmann, G. Ernst, and A. Dominik, “Modeling biology in Modelica: The human baroreflex,” in Proceedings of the 11th International Modelica Conference, Versailles, France, 2015, pp. 367–376.

\[<a name="schoelzel2019">3</a>] C. Schölzel, V. Blesius, G. Ernst and A. Dominik, “Required characteristics for modeling languages in systems biology: A software engineering perspective,” unpublished.

