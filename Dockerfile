FROM python

WORKDIR /usr/app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY hello.py hello.py