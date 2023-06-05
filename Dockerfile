FROM python:3.9-slim-buster
RUN mkdir /app
WORKDIR /app

# install gettext for envsubst
RUN apt-get update
RUN apt-get install -y gettext-base

COPY requirements.txt .
COPY wheels/*.whl .

RUN pip install --upgrade pip \
    && pip install prodigy -f *.whl \
    && pip install -r requirements.txt \
    && python -m spacy download en_core_web_sm

COPY data ./data/
COPY prodigy.json.template .
RUN envsubst < prodigy.json.template > prodigy.json
COPY prodigy.sh .

ENV PRODIGY_ALLOWED_SESSIONS "user1,user2"
# RUN useradd python
EXPOSE 8080
CMD ["bash","prodigy.sh"]
