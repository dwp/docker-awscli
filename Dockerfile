FROM python:3-alpine

RUN apk add --no-cache jq curl gnumeric ttf-freefont

COPY assume-role /
COPY requirements.txt /tmp

RUN pip install --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org --no-cache-dir -r /tmp/requirements.txt


CMD ["sh", "-c", "source /assume-role && aws --version"]
