# SHM-Conduction

[![Run tests](https://github.com/CSchoel/shm-conduction/actions/workflows/test.yml/badge.svg)](https://github.com/CSchoel/shm-conduction/actions/workflows/test.yml)

This repository contains a modular model of the human cardiac conduction system written in [Modelica](https://www.modelica.org/) as well as an extension of this model that introduces a trigger for [premature ventricular contractions (PVCs)](https://en.wikipedia.org/wiki/Premature_ventricular_contraction).
It is based on the Seidel-Herzel Model (SHM) of the human baroreflex that was first published by Henrik Seidel in his PhD thesis \[[1]\].

The monolithic version of the conduction system model is based on a previous translation of the whole SHM from C to Modelica \[[2]\].
This modular version and the PVC extension where developed as an example how a language that is modular, hybrid (supporting multiple formalisms), human-readable, open-source, declarative, and graphical can facilitate model reuse.
This will be discussed in detail in an upcoming paper of our research group \[[3]\].

## Project structure

The main parts of this project can be found in the following files:

* `SHMConduction/package.mo` contains a full description of the models in this project.
* `SHMConduction/Components/MonolithicConduction.mo` contains the monolithic version of the contraction model.
* `SHMConduction/Components/ModularConduction.mo` is the main file for the modular version binding all submodules together.
* `SHMConduction/Components/PVC/ModularConductionX.mo` is the main file for the extended modular version with PVCs.
* `SHMConduction/Examples/ModularExample.mo` contains a simulation example that compares `MonolithicConduction.mo` with `ModularConduction.mo`.
* `SHMConduction/Examples/PVCExample.mo` contains a simulation example that tests the PVC extension for plausibility.

## Reproduction of plots from the paper

If you want to reproduce the plots in \[[3]\], you can alternatively use OMEdit (the IDE of OpenModelica), or the Julia script.

### OMEdit

To reproduce the plots with OMEdit you have to use the following steps:

1. Download and install [OpenModelica](https://openmodelica.org/).
2. Clone this repository with Git or download a [ZIP file of the current master branch](https://github.com/CSchoel/shm-contraction/archive/master.zip) and extract it with an archive manager of your choice.
3. Start OMEdit and open the folder `SHMConduction` with "File" → "Load Library".

For Figure 2:

* Open the model `SHMConduction.Examples.ModularExample` (select from "Libraries Browser" on the left hand side with a double click).
* Simulate the model with "Simulation" → "Simulate".
* In the "Variables Browser" on the right hand side select the variables `monC.T_cont` and `modC.T`.

For Figure 4:

* Open the model `SHMConduction.Examples.PVCExample` (select from "Libraries Browser" on the left hand side with a double click).
* Navigate to the "Text View" (![blue rectangle with white lines of code](TextViewOMEdit_13.gif)) in the gray bar under the tab `PVCExample`.
* Change the value of the parameter `with_sinus` either to `true` to produce Figure 4a or to `false` for Figure 4b.
* Simulate the model with "Simulation" → "Simulate".
* In the "Variables Browser" on the right hand side select the variable `con.T`.

### Julia script

Using the Julia script in `scripts/unittests.jl` requires additional software, but eliminates the need to interact with OMEdit and allows you to use a plotting library or tool of your choice.

To reproduce the plots you have to use the following steps:

1. Download and install [OpenModelica](https://openmodelica.org/).
2. Download and install [Julia](https://julialang.org/).
3. Clone this repository with Git or download a [ZIP file of the current master branch](https://github.com/CSchoel/shm-contraction/archive/master.zip) and extract it with an archive manager of your choice.
4. Run the following commands in a terminal from the repository folder:
  * `julia -e 'ENV["PYTHON"]=""; using Pkg; Pkg.add(PackageSpec(url="https://github.com/THM-MoTE/ModelicaScriptingTools.jl.git"))'`
  * `julia scripts/unittests.jl`
5. This should create the folder `out` with the following result files:
  * `SHMConduction.Examples.ModularExample_res.csv` contains the data for Figure 2 in the columns `time`, `monC.T_cont` and `modC.T`.
  * `SHMConduction.Examples.PVCExample_res.csv` contains the data for Figure 4a in the columns `time` and `con.T`.
  * `PVCNoSinus_res.csv` contains the data for Figure 4b in the columns `time` and `con.T`
6. Produce the plots with a plotting tool or library of your choice or use the already existing Python script in `scripts/plot_mc_compare.py` which will write the plots as PDF files in to the `out` folder.


## References

[1]: #seidel1997
[2]: #schoelzel2015
[3]: #schoelzel2021

\[<a name="seidel1997">1</a>\] H. Seidel, “Nonlinear dynamics of physiological rhythms,” PhD thesis, Technische Universität Berlin, Berlin, Germany, 1997.

\[<a name="schoelzel2015">2</a>] C. Schölzel, A. Goesmann, G. Ernst, and A. Dominik, “Modeling biology in Modelica: The human baroreflex,” in Proceedings of the 11th International Modelica Conference, Versailles, France, 2015, pp. 367–376.

\[<a name="schoelzel2021">3</a>] C. Schölzel, V. Blesius, G. Ernst, and A. Dominik, “Characteristics of mathematical modeling languages that facilitate model reuse in systems biology: A software engineering perspective,” bioRxiv, preprint 10.1101/2019.12.16.875260v6, 2021. doi: <a href="https://doi.org/10.1101/2019.12.16.875260">10.1101/2019.12.16.875260</a>.
