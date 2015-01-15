#
# This code is meant to be sourced, not executed.
# It currently only supports NERSC hosts.
#
# $Id$
#
if ( `basename ${SHELL}` == "csh" || `basename ${SHELL}` == "tcsh" ) then
    source /project/projectdirs/cmb/modules/hpcports_NERSC.csh
    if ( "${NERSC_HOST}" == "edison" ) then
        hpcports shared_gnu
    endif
    if ( "${NERSC_HOST}" == "hopper" )  then
        hpcports shared_gnu
    endif
    if ( "${NERSC_HOST}" == "carver" )  then
        if ( "${CHOS}" != "sl6carver" ) then
            echo "ERROR: The DESI environment requires Scientific Linux 6 (SL6) on carver."
            echo "Please switch to SL6 first by creating a .chos-carver file in your home"
            echo 'directory with contents "sl6carver" and then login again;'
            echo 'or run "export CHOS=sl6carver; chos bash -l" to temporarily switch to SL6.'
            echo
            echo "For more details about CHOS and SL5 vs SL6 on carver, see"
            echo "https://www.nersc.gov/users/computational-systems/carver/user-environment/"
            echo
            echo "After switching to SL6, source desi_environment.csh again."
            exit
        endif
        hpcports gnu
    endif
    if ( "${NERSC_HOST}" == "datatran" || "${NERSC_HOST}" == "scigate" ) then
        hpcports
    endif
    if ( -d /project/projectdirs/desi/software/modules/${NERSC_HOST} ) then
        module use /project/projectdirs/desi/software/modules/${NERSC_HOST}

        if ( $# > 0 ) then
            module load desiModules/$1
        else
            module load desiModules
        endif
    else
        echo "Could not find DESI modules for ${NERSC_HOST}!"
    endif
else
    echo "You are not sourcing the correct file for your shell!"
endif
