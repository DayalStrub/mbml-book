# MBML book: Worked examples and exercises

Worked examples and exercises from Winn et al.'s [MBML book](http://www.mbmlbook.com/toc.html).

## Folder structure

```
│
├── data                  <- Data from the book.
│
├── exploration           <- Messy notebooks used to try stuff out.
│
├── notebooks             <- Solutions to exercises and worked examples.
│
├── src                   <- Extra code used in notebooks.
│
├── .gitignore
├── Dockerfile            <- Dockerised notebook environment.
├── README.md             <- This file.
│
```

## Some other solutions to book exercises

* Official solutions in [infer.NET](https://github.com/dotnet/mbmlbook).
* Solutions in [PyMC](https://github.com/ricardoV94/mbmlbook_PyMC3).
* ForneyLab demos
  * Note: Only [Ch.1](https://github.com/biaslab/ForneyLab.jl/blob/master/demo/bayes_rule_discrete.ipynb), and an explanation on how to implement an [`And` factor](https://github.com/biaslab/ForneyLab.jl/blob/master/demo/implementing_additional_nodes.ipynb), which is necessary for Ch.2 (see discussions [here](https://github.com/biaslab/ForneyLab.jl/issues/100), [here](https://github.com/biaslab/ForneyLab.jl/issues/200) and also in [ReactiveMP](https://github.com/biaslab/ReactiveMP.jl/issues/102)).
* Some solutions in [Pyro](https://github.com/mengqvist/data_analysis_mbml)
  * Note: Only Ch.1 and part of Ch.2 for now.

## Other useful references

* infer.NET
  * The [python tests](https://github.com/dotnet/infer/blob/master/test/TestPython/test_tutorials.py) are the only reference where infer.NET is used via pythonnet.
  * pythonnet [documentation](https://pythonnet.github.io/).
  * [Tobimaru's repo](https://github.com/Tobimaru/InferNet-pythonnet/) with some infer.NET in pythonnet examples.

## Setting up a work environment

For simplicity, we have a Docker image that has 

* JupyterLab (as it is built off of the JupyterStack),
* infer.NET, as well as pythonnet to run it via Python,
* PyMC and other python packages.

Setting up is as simple as
```bash
sudo docker build -t mbml .
```
Then, you can run the image from the location of your local copy of the repo in order to spin up JupyterLab.

```bash
sudo docker run -p 8888:8888 -v "$PWD":/home/jovyan/notebooks mbml jupyter lab --ContentsManager.allow_hidden=True --allow-root
```

NOTE: Notebooks are saved as Rmd files, which are easier to read and diff, but GitHub doesn't render them and they don't have any output _(messed up within the code)._

### Details 

#### infer.NET

We run [Infer.NET](https://dotnet.github.io/infer/default.html) via [pythonnet](http://pythonnet.github.io/) using mono.
If you install mono as a pythonnet dependency, via mamba, then everything seems to work, if instead you install it separately, and then use pip for pythonnet, you need to choose `Compiler`, that is set
```
engine.Compiler.CompilerChoice = CompilerChoice.CodeDom
```
see github [issue](https://github.com/dotnet/infer/issues/297#issuecomment-710653001).
