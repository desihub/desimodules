#
# Template Makefile for use with desiInstall.  You can assume that
# desiInstall will set these environment variables:
#
# WORKING_DIR   : The directory containing the svn export
# INSTALL_DIR   : The directory the installed product will live in.
# (PRODUCT)_DIR : Where (PRODUCT) is replaced with the name of the
#                 product in upper case, e.g. TEMPLATE_DIR.  This should
#                 be the same as WORKING_DIR for typical installs.
#
# Use this shell to interpret shell commands, & pass its value to sub-make
#
export SHELL = /bin/sh
#
# This is like doing 'make -w' on the command line.  This tells make to
# print the directory it is in.
#
MAKEFLAGS = w
#
# This is a list of subdirectories that make should descend into.  Makefiles
# in these subdirectories should also understand 'make all' & 'make clean'.
# This list can be empty, but should still be defined.
#
SUBDIRS =
#
# This is a list of directories that make should copy to $INSTALL_DIR.
# If a Makefile is present in these directories, 'make install' will be
# called on them.  Otherwise it will just be a plain copy.
#
INSTALLDIRS =
#
# This is a message to make that these targets are 'actions' not files.
#
.PHONY : all install clean
#
# This should compile all code prior to it being installed.
#
all :
	@ for f in $(SUBDIRS); do if test -f $$f/Makefile; then $(MAKE) -C $$f all; fi; done
#
# This should handle the installation of files in $INSTALL_DIR.  Note that
# 'all' is a dependency of 'install'.
#
install : all
	@ if test -d /project/projectdirs/desi/software/modules; then \
		/bin/cp -v -f $(WORKING_DIR)/etc/desi_environment.* \
		/project/projectdirs/desi/software/modules; fi
#
# GNU make pre-defines $(RM).  The - in front of $(RM) causes make to
# ignore any errors produced by $(RM).
#
clean :
	- $(RM) *~ core
	@ for f in $(SUBDIRS); do $(MAKE) -C $$f clean ; done
