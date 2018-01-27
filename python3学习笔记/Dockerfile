FROM jupyter/base-notebook:27ba57364579
ENV PATH ~/.local/bin/:/usr/local/bin/:$PATH
WORKDIR /code/source/python3学习笔记
COPY requirements.txt ./
COPY *.ipynb ./
RUN pip install jupyter_contrib_nbextensions -i https://pypi.tuna.tsinghua.edu.cn/simple/
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
RUN jupyter contrib nbextension install --user
COPY .jupyter /home/jovyan/.jupyter
