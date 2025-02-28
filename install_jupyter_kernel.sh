#!/bin/sh
#
# Licensed under a 3-clause BSD style license - see LICENSE.rst
#
# Install a Jupyter kernel definition in a user's home directory.
#
function usage() {
    local execName=$(basename $0)
    (
    echo "DEPRECATED: this still works, but please use install_jupyter_kernel (without .sh) instead"
    echo ""
    echo "${execName} [-h] [-v] RELEASE"
    echo ""
    echo "Install a Jupyter kernel definition."
    echo ""
    echo "        -h = Print this message and exit."
    echo "        -v = Verbose mode. Print extra information for debugging."
    echo "   RELEASE = Name of software release. Required."
    ) >&2
}
#
# Get options
#
verbose=False
while getopts hv argname; do
    case ${argname} in
        h) usage; exit 0 ;;
        v) verbose=True ;;
        *) usage; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

echo "DEPRECATED: while this script still works, please use install_jupyter_kernel (without .sh) instead"

#
# Make sure release actually exists.
#
if [ $# -lt 1 ]; then
    echo "You must specify a release!" >&2
    usage
    exit 1
fi
[ "${verbose}" = "True" ] && echo "release=$1"
release=$1
if [ -z "${DESIMODULES}" ]; then
    echo "The DESIMODULES environment variable does not appear to be set!" >&2
    exit 1
fi
if [ ! -f ${DESIMODULES}/${release} ]; then
    echo "Release ${release} does not appear to exist!" >&2
    exit 1
fi
#
# Set up kernel directory.
#
kernelDir=${HOME}/.local/share/jupyter/kernels/desi-${release}
if [ -d ${kernelDir} ]; then
    echo "Release ${release} is already installed in ${kernelDir}, aborting." >&2
    exit 1
fi
[ "${verbose}" = "True" ] && echo mkdir -p ${kernelDir}
mkdir -p ${kernelDir}
#
# Check $SHELL.
#
b=$(basename ${SHELL})
if [ "${b}" = "csh" -o "${b}" = "tcsh" ]; then
    suffix=csh
else
    suffix=sh
fi
[ "${verbose}" = "True" ] && echo "suffix=${suffix}"
#
# Create kernel.json file.
#
cat > ${kernelDir}/kernel.json <<EndOfKernel
{
 "language": "python",
 "argv": [
  "/global/common/software/desi/activate_desi_jupyter.${suffix}",
  "${release}",
  "{connection_file}"
 ],
 "display_name": "DESI ${release}"
}
EndOfKernel
[ "${verbose}" = "True" ] && cat ${kernelDir}/kernel.json
#
# Copy logo files.
#
[ "${verbose}" = "True" ] && echo "cp ${DESIMODULES}/*.png ${kernelDir}"
cp ${DESIMODULES}/*.png ${kernelDir}
