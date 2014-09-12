#
# This code is meant to be sourced, not executed.
#
# $Id$
#
if [[ $(basename ${SHELL}) == "bash" || $(basename ${SHELL}) == "sh" ]]; then
    source /project/projectdirs/cmb/modules/hpcports_NERSC.sh
    if [[ "${NERSC_HOST}" == "carver" || "${NERSC_HOST}" == "hopper" ]]; then
        hpcports gnu
    fi
    if [[ "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ]]; then
        hpcports
    fi
    if [[ "${NERSC_HOST}" == "edison" ]]; then
        hpcports shared_gnu
    fi
    if [[ -d /project/projectdirs/desi/software/modules/${NERSC_HOST} ]]; then
        module use /project/projectdirs/desi/software/modules/${NERSC_HOST}
        module load desiModules
    else
        echo "Could not find DESI modules for ${NERSC_HOST}!"
    fi
else
    echo "You are not sourcing the correct file for your shell!"
fi
