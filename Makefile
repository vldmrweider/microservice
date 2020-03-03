.EXPORT_ALL_VARIABLES:
.SILENT:
.ONESHELL:
SHELL=/bin/bash

define BUILD_NAME
microservice
endef

define PYTHON_VERSION
3.7.4
endef

define REQUIREMENTS_PATH
./requirements.txt
endef

define DEFAULT
echo BUILD_ENV:

  if [ -z "$(PYTHON_VERSION)" ]
  then
  	printf '$(PYTHON_VERSION) is empty.\n'
   	exit 1
  fi
  PYENV_VIRTUALENV_DISABLE_PROMPT=1
  pyenv install -s "$(PYTHON_VERSION)" || printf 'Python $(PYTHON_VERSION) is already installed.\n'
  pyenv virtualenv "$(PYTHON_VERSION)" "$(BUILD_NAME)_$(PYTHON_VERSION)" || printf '$(BUILD_NAME)_$(PYTHON_VERSION) is already initialized.\n'
  eval "$$(pyenv init -)"
  eval "$$(pyenv virtualenv init -)"
  pyenv activate "$(BUILD_NAME)_$(PYTHON_VERSION)"
  if [ "$$(uname -s)" = Darwin ]
  then
    export LDFLAGS='-L/usr/local/lib -L/usr/local/opt/openssl/lib -L/usr/local/opt/readline/lib' \
    && brew install openssl \
    && brew link --force openssl \
    && brew install postgresql mysql-connector-c \
    || printf ''
  fi
echo :BUILD_ENV
endef

define PACK
	rm -r ./build/* \
	&& rm -r ./dist/*
	pip install setuptools wheel \
	&& export WHEEL_NAME=$(BUILD_NAME) \
	&& export WHEEL_VERSION=$$(date '+%Y.%m%d.%H%M%S') \
	&& export WHEEL_DEPENDENCIES="$$(cat $(REQUIREMENTS_PATH))" \
	&& python setup.py bdist_wheel --dist-dir ./dist/


endef

define REINST
  pip uninstall -y $(BUILD_NAME) && pip install ./dist/*.whl
endef

default:
	$(DEFAULT)

build:
	$(DEFAULT)
	pip install -r $(REQUIREMENTS_PATH)
	pip install pylint \
	&& pylint --rcfile ./pylintrc $(BUILD_NAME) \
	&& python . collectstatic

test:
	$(DEFAULT)
	$(PACK)
	$(REINST)
	python -m unittest discover
