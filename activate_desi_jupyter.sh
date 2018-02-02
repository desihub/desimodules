#!/bin/bash

# This script is intended to be called from a jupyter kernel.json file
# with the desimodules version number and a "connection_file" parameter
# provided by jupyter, e.g. via a file like:
# $HOME/.local/share/jupyter/kernels/desi-17.6/kernel.json
#

# {
# "language": "python",
# "argv": [
#   "/project/projectdirs/desi/software/activate_desi_jupyter.sh",
#   "17.6",
#   "{connection_file}"
#   ],
# "display_name": "DESI 17.6"
# }

version=$1
connection_file=$2

# module use /global/common/${NERSC_HOST}/contrib/desi/modulefiles/
# module load desimodules/$version
source /project/projectdirs/desi/software/desi_environment.sh $version
exec python -m ipykernel -f $connection_file

