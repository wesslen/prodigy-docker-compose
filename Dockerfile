FROM python:3.9-slim-buster
RUN mkdir /app
WORKDIR /app

RUN pip install --upgrade pip \ 
    && pip install prodigy -f https://${PRODIGY_KEY}@download.prodi.gy \ 
    && pip install -r requirements.txt \
    && python -m spacy download en_core_web_sm

RUN rm -rf *.whl
COPY data ./data/
COPY prodigy.json .
COPY prodigy.sh .

ENV PRODIGY_ALLOWED_SESSIONS "user1,user2"
# RUN useradd python
EXPOSE 8080
CMD ["bash","prodigy.sh"]