FROM public.ecr.aws/d3j8x8q7/olympus-base-python:latest

WORKDIR /app

COPY . /app

RUN poetry install

CMD ["/bin/bash"]
