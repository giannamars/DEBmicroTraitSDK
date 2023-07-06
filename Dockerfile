FROM kbase/sdkpython:3.8.0
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update \
    && apt-get -y install wget

WORKDIR /kb/deployment/bin
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.2-linux-x86_64.tar.gz \
    && tar zxvf julia-1.9.2-linux-x86_64.tar.gz \
    && rm -rf julia-1.9.2-linux-x86_64.tar.gz
ENV PATH="/kb/deployment/bin/julia-1.9.2/bin/:${PATH}"


# -----------------------------------------

COPY ./ /kb/module
RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
