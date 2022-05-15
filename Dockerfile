FROM jupyter/base-notebook

USER root

## update Debian libraries
RUN apt-get update && apt-get install -y \
    clang \
    curl \
    graphviz

USER $NB_UID

## install pythonnet, pymc, etc.
RUN mamba install --quiet --yes \
    'altair' \
    'arviz' \
    'jupytext' \
    'matplotlib' \
    'networkx' \
    'numpy' \
    'pandas' \
    'pycparser' \
    'pymc3' \
    'pythonnet' \
    'xarray'

USER root

## install infer.net packages and copy all dlls to same folder (so pythonnet can find them)
RUN curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe \
    && apt install -y gnupg ca-certificates \
    && cert-sync /etc/ssl/certs/ca-certificates.crt \
    # && apt-get update \
    && mkdir -p /root/dotNet/packages && cd /root/dotNet/packages \
    && export NUGET="mono /usr/local/bin/nuget.exe install -ExcludeVersion" \
    && ${NUGET} Microsoft.ML.Probabilistic \
    && ${NUGET} Microsoft.ML.Probabilistic.Compiler \
    && mkdir -p /root/dotNet/libs \
    && find /root/dotNet/packages/ -type f -name '*.dll' -exec cp -n {} /root/dotNet/libs ';'

## tweak jupyter lab
# RUN jupyter labextension install @jupyterlab/toc && \
#     jupyter labextension install jupyterlab-jupytext && \
RUN printf '\nc.NotebookApp.contents_manager_class = "jupytext.TextFileContentsManager"\nc.ContentsManager.default_jupytext_formats = "ipynb,Rmd"' >> /etc/jupyter/jupyter_notebook_config.py


## Configure container
CMD ["start.sh"]

WORKDIR $HOME/notebooks/
