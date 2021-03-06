

#set -xeuo pipefail
#export PYTHONUNBUFFERED=1
echo "exporting Mutlidict root directory"
export MULTIDICT_ROOT=$(cd "$(dirname "$0")/.."; pwd;)
yum update -y
echo "Installing build dependencies"
yum install gcc gcc-c++ python3-devel wget make enchant-devel -y
cd '/home/multidict_root'
export PATH='/opt/bin':${PATH}
echo "Installing requirement"
/opt/_internal/cpython-$1*/bin/python -m pip install -U setuptools wheel
echo "Building wheels"
/opt/_internal/cpython-$1*/bin/python setup.py bdist_wheel
ls dist
/opt/_internal/cpython-$1*/bin/python setup.py install
/opt/_internal/cpython-$1*/bin/python -m pip install -r requirements/pytest.txt
/opt/_internal/cpython-$1*/bin/python -m pip install pytest-azurepipelines
/opt/_internal/cpython-$1*/bin/python -m pytest tests -vv
/opt/_internal/cpython-$1*/bin/python -m coverage xml
/opt/_internal/cpython-$1*/bin/python -m pip install codecov
/opt/_internal/cpython-$1*/bin/python -m codecov -f coverage.xml -X gcov
echo "test complete"
