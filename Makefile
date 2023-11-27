# Developer notes
#
# Manually created files:
# Makefile - this file. Use it to set up the developer environment and automatic API creation.
# resources/openapi.cfg - Configuration for openapi-python-client.
# resources/requirements.txt - python package requirements for openapi-python-client.
#
# Automatically created files:
# arcticspas/* - the arcticspas python package.
# resources/arctic-spas-openapi-*.json - the arcticspas OpenAPI definitions.
#
# Automatically created files that are then manually updated:
# README.md - User documentation
#

STAMP?=$(shell date +%Y%m%d)

download-openapi-definition:
	curl -s https://api.myarcticspa.com/docs/arctic-spas-openapi.json --output resources/arctic-spas-openapi-$(STAMP).json

setup-devenv:
	if [ ! -f venv/bin/activate ]; then python3 -m virtualenv venv ; source venv/bin/activate && pip3 install -r resources/requirements.txt ; fi

create-library: setup-devenv
	source venv/bin/activate && cd .. && openapi-python-client generate --path resources/arctic-spas-openapi-$(STAMP).json --config resources/openapi.cfg --fail-on-warning --meta setup

update-library: setup-devenv
	source venv/bin/activate && cd .. && openapi-python-client update --path resources/arctic-spas-openapi-$(STAMP).json --config resources/openapi.cfg --fail-on-warning --meta setup
