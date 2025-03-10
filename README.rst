===========
desimodules
===========

This package provides a set of meta-modules that can be used to load a default
set of DESI modules.  In addition there are a few shell scripts that are
useful for setting up these meta-modules:

``desi_environment.sh``
    Provides an easy way to set up the DESI environment on login.  This
    script is meant to be *sourced* inside an existing shell, not executed.
    For example::

        source /global/common/software/desi/desi_environment.sh 23.1

``activate_desi_jupyter.sh``
    Used to set up the DESI environment within Jupyter notebooks.  This
    script is meant to be *executed* by the NERSC Jupyter notebook system,
    so it explicitly has executable bits set.

There are equivalent scripts for tcsh.

The script ``install_juypter_kernel`` allows users to install Jupyter notebook
kernels in their home directories that are loaded with a particular
desimodules release.  To install a particular desimodules release, just do::

    install_jupyter_kernel -v 23.1

to install release 23.1.

To obtain the version of desimodules programmatically, just use the value
of the environment variable ``DESIMODULES_VERSION``.  You can also reconstruct
the full path to a desimodules Module file with::

    $DESIMODULES/$DESIMODULES_VERSION

This package is specifically designed to be a valid Modules directory on
its own.  To install this package, all that is required is::

    cd modulefiles
    git clone https://github.com/desihub/desimodules.git

and the modules defined here will appear, assuming the ``modulefiles`` directory
has been added with a ``module use`` command.

Valid Module files begin with the characters ``#%Module1.0``.  Files that
do *not* begin with these characters are ignored by the Modules system.
This allows us to freely mix Module files with non-Module files.

In preparation for a software release:

1. Create (but do not check in) a ``test-release`` file with the desired versions.
   You can call this file *e.g.* ``test-25.1`` if you need a more specific
   release candidate to refer to.
2. Load the ``test-release`` environment and run tests.
3. When the tests pass, copy ``test-release`` to a new file, *e.g.* ``25.1``,
   and edit the version information.
4. Add the new file.
5. Check the ``.version`` and ``main`` files for consistency.
6. Merge any PR and tag this package with the name of the new file.
