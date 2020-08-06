# PLEASE NOTE: This script has been automatically generated by conda-smithy. Any changes here
# will be lost next time ``conda smithy rerender`` is run. If you would like to make permanent
# changes to this script, consider a proposal to conda-smithy so that other feedstocks can also
# benefit from the improvement.

set -xeuo pipefail
export PYTHONUNBUFFERED=1
export MULTIDICT_ROOT=$(cd "$(dirname "$0")/.."; pwd;)

#cat >~/.condarc <<CONDARC

#conda-build:
 #root-dir: ${MULTIDICT_ROOT}/build_artifacts

#CONDARC

yum update -y
yum install gcc gcc-c++ python3-devel wget make enchant-devel -y
#export CONDA_ENV='azure'
cd '/home/multidict_root'
pwd
ls
#echo "Installing miniforge"
#bash .azure-pipelines/install_conda_aarch64.sh
export PATH='/opt/bin':${PATH}
echo "Installing requirement"
#pip install -r requirements/lint.txt
#make flake8
#pip install -e .
#export MULTIDICT_NO_EXTENSIONS='1'
#make mypy
#pip install -r requirements/doc-spelling.txt
#pip install -r requirements/towncrier.txt
#towncrier --yes
#pip install -U twine wheel
echo "${(python.version)}"
/opt/python/${(python.version)}/bin/pip install virtualenv
/opt/python/${(python.version)}/bin/python -m virtualenv .venv
.venv/bin/pip install --upgrade pip setuptools wheel
.venv/bin/python setup.py bdist_wheel
#twine check dist/*
echo "#################################### Dist LS #################################"
ls dist
.venv/bin/python setup.py install
.venv/bin/python -m pip install -r requirements/pytest.txt
.venv/bin/pip install pytest-azurepipelines
.venv/bin/python -m pytest tests -vv
.venv/bin/python -m coverage xml
.venv/bin/python -m pip install codecov
.venv/bin/python -m codecov -f coverage.xml -X gcov
echo "test complete"
