FROM python:3.9.4-buster

COPY app.py requirements.txt ./

RUN pip install -r requirements.txt

EXPOSE 5000

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0" ]