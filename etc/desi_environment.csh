#
# This code is meant to be sourced, not executed.
#
# $Id$
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    source /project/projectdirs/cmb/modules/hpcports_NERSC.csh
    if ( "${NERSC_HOST}" == "carver" || "${NERSC_HOST}" == "hopper" )  then
        hpcports gnu
    endif
    if ( "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ) then
        hpcports
    endif
    if ( "${NERSC_HOST}" == "edison" ) then
        hpcports shared_gnu
    endif
    if ( -d /project/projectdirs/desi/software/modules/${NERSC_HOST} ) then
        module use /project/projectdirs/desi/software/modules/${NERSC_HOST}
        module load desiModules
    else
        echo "Could not find DESI modules for ${NERSC_HOST}!"
    endif
else
    echo "You are not sourcing the correct file for your shell!"
endif
