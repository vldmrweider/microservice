import os
from setuptools import setup, find_packages

NAME = os.environ['WHEEL_NAME']
VERSION = os.environ['WHEEL_VERSION']
DEPENDENCIES = os.environ['WHEEL_DEPENDENCIES'].split()


def requirements():
    return DEPENDENCIES


setup(name=NAME,
      version=VERSION,
      description='',
      packages=find_packages(exclude=[]),
      # if you need extra packages
      # `package_data={'': ['']},`
      include_package_data=True,
      install_requires=requirements(),
      entry_points={'console_scripts': ['%s = %s.main:main' % (NAME, NAME)]})
