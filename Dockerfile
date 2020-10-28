FROM python:3.8.3-alpine3.12

RUN apk add --no-cache jq curl

COPY assume-role /
COPY requirements.txt /tmp

RUN pip install --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org --no-cache-dir -r /tmp/requirements.txt


CMD ["sh", "-c", "source /assume-role && aws --version"]
