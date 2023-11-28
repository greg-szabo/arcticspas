# OpenAPI download datestamp
STAMP ?= 20231126

download-openapi-definition:
	curl -s https://api.myarcticspa.com/docs/arctic-spas-openapi.json --output resources/arctic-spas-openapi-$(shell date +%Y%m%d).json

setup-devenv:
	if [ ! -f venv/bin/activate ]; then python3 -m virtualenv venv ; source venv/bin/activate && pip3 install -r resources/requirements.txt ; fi

update-package: setup-devenv
	source venv/bin/activate && cd .. && openapi-python-client update --path arcticspas/resources/arctic-spas-openapi-$(STAMP).json --config arcticspas/resources/openapi.cfg --fail-on-warning --meta setup

lint:
	source venv/bin/activate && autoflake -i -r --remove-all-unused-imports --remove-unused-variables --ignore-init-module-imports arcticspas tests
	source venv/bin/activate && isort arcticspas tests
	source venv/bin/activate && black arcticspas tests
