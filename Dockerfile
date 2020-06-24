FROM governmentpaas/awscli:848d890e2aa7ffb049801c23dc85f981b49e491a

RUN apk add --no-cache jq py-pip

COPY assume-role /
COPY requirements.txt /tmp

RUN pip install --trusted-host=pypi.python.org --trusted-host=pypi.org --trusted-host=files.pythonhosted.org --no-cache-dir -r /tmp/requirements.txt


CMD ["sh", "-c", "source /assume-role && aws --version"]
