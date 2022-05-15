# MBML book: Exercises and learnings

Working through the [MBML book](http://www.mbmlbook.com/toc.html)...

## Some other solutions to book exercises

* Official solutions in [infer.NET](https://github.com/dotnet/mbmlbook).
* Solutions in [PyMC](https://github.com/ricardoV94/mbmlbook_PyMC3).
* ForneyLab demos
  * Note: Only [Ch.1](https://github.com/biaslab/ForneyLab.jl/blob/master/demo/bayes_rule_discrete.ipynb) and an explanation on how to implement an [`And` factor](https://github.com/biaslab/ForneyLab.jl/blob/master/demo/implementing_additional_nodes.ipynb), necessary for Ch.2 (see discussions [here](https://github.com/biaslab/ForneyLab.jl/issues/100), [here](https://github.com/biaslab/ForneyLab.jl/issues/200) and also in [ReactiveMP](https://github.com/biaslab/ReactiveMP.jl/issues/102)).
* Somone's solutions in [Pyro](https://github.com/mengqvist/data_analysis_mbml)
  * Note: Only Ch.1 and part of Ch.2 for now.

## Other useful references

* infer.NET
  * The [python tests](https://github.com/dotnet/infer/blob/master/test/TestPython/test_tutorials.py) are the only reference where infer.NET is used via pythonnet.
  * pythonnet

## Setting up a work environment

For simplicity, we have a Docker image that has 

* JupyterLab (as it's built off of the JupyterStack),
* infer.NET, as well as pythonnet in order to run it via Python.

Setting up is as simple as

* Build:

```bash
sudo docker build -t mbml .
```

* Run:

```bash
sudo docker run -p 8888:8888 -v "$PWD":/home/jovyan/notebooks mbml jupyter lab --ContentsManager.allow_hidden=True --allow-root
```

### Details 

#### infer.NET

We run [Infer.NET](https://dotnet.github.io/infer/default.html) via [pythonnet](http://pythonnet.github.io/) using mono.

If you install mono as a pythonnet dependency (i.e. via mamba), then everything seems to work, if instead you install it separately (and then using pip for pythonnet), you need to choose `Compiler`, namely set

```
engine.Compiler.CompilerChoice = CompilerChoice.CodeDom
```

see github [issue](https://github.com/dotnet/infer/issues/297#issuecomment-710653001).
