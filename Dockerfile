FROM nvidia/cuda:7.5-cudnn4-runtime
RUN ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.4 /usr/lib/x86_64-linux-gnu/libcudnn.so
RUN echo '\
    deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main\n\
    deb mirror://mirrors.ubuntu.com/mirrors.txt trusty universe\n\
    deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main\n\
    deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty main\n\
    deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty universe\n\
    deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main\n'\
    > /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y \
        gcc \
        libopenblas-base \
        libzookeeper-mt-dev \
        ca-certificates \
        python-dev \
        git-core \
	python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose python-tk && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/cache/apt /var/lib/apt/lists
RUN python -c 'import urllib2;exec(urllib2.urlopen("https://bootstrap.pypa.io/get-pip.py").read())' --no-cache-dir --timeout 1000 && \
    pip install --no-cache-dir --timeout 1000 -r "https://raw.githubusercontent.com/douban/tfmesos/master/requirements.txt" && \
    pip install --no-cache-dir --timeout 1000 "git+https://github.com/douban/tfmesos.git@master#egg=tfmesos"
