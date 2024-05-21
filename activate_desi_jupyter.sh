#!/bin/bash

# This script is intended to be called from a jupyter kernel.json file
# with the desimodules version number and a "connection_file" parameter
# provided by jupyter, e.g. via a file like:
# $HOME/.local/share/jupyter/kernels/desi-17.6/kernel.json
#

# {
# "language": "python",
# "argv": [
#   "/global/common/software/desi/activate_desi_jupyter.sh",
#   "17.6",
#   "{connection_file}"
#   ],
# "display_name": "DESI 17.6"
# }

_i=bash
[[ $(basename ${SHELL}) == "zsh" ]] && _i=zsh
[[ $(declare -F module) ]] || source /usr/share/lmod/lmod/init/${_i}

if [[ $# == 3 ]]; then
    version=$1
    release=$2
    connection_file=$3
else
    version=$1
    release=''
    connection_file=$2
fi

source /global/common/software/desi/desi_environment.sh ${version}
if [[ -n "${release}" ]]; then
    module switch desitree/${release}
fi
exec python -m ipykernel_launcher -f ${connection_file}
