set -xeo pipefail

MULTIDICT_ROOT=$(cd "$(dirname "$0")/.."; pwd;)


docker info

# In order for the conda-build process in the container to write to the mounted
# volumes, we need to run with the same id as the host machine, which is
# normally the owner of the mounted volumes, or at least has write permission
export HOST_USER_ID=$(id -u)
ARTIFACTS="$MULTIDICT_ROOT/build_artifacts"
mkdir -p "$ARTIFACTS"

docker run ${DOCKER_RUN_ARGS} \
           -v "${MULTIDICT_ROOT}":/home/conda/multidict_root:rw,z \
           -e TEST_START_INDEX \
           -e TEST_COUNT \
           -e HOST_USER_ID \
           -e CI \
           $DOCKER_IMAGE \
           bash /home/conda/feedstock_root/.azure-pipelines/build_steps.sh

# verify that the end of the script was reached
test -f "$DONE_CANARY"
