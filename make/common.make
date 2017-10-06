#!/usr/bin/make
#
##
## Common.make - common defs and rules (figures out machine dependent stuff)
##

#include $(NV_MAKE_TOOL_DATA)
#include $(NV_MAKE_MK_CHECK)

ECHO ?= echo
EXIT ?= exit

##
## _default should always be the first dependency (you can add extra local actions with default::)
##
_default:: default

##
## always include the top-level user-editable configuration file tree.make to pick up PROJECTS
##
#include $(DEPTH)/$(TREE_MAKE)
OUTDIR ?= outdir

# Check that PROJECTS is set (unless overridden through command line)
ifneq ($(origin PROJECTS),command line)
  ifeq (,$(strip $(PROJECTS)))
    ifneq (,$(wildcard $(TREE_MAKE)))
      $(error Please enter a project name in 'export PROJECTS := <project name>' in your tree.make, exiting...)
    endif
  endif
endif

# use the gnu tools in preference to others
#include $(DEPTH)/make/tools.mk
CPP  := /home/gnu/bin/cpp
SED  := /bin/sed

# this gross little gmakism returns the last directory component of PWD
#PWD := $(shell pwd)
#DIRNAME := $(subst .,,$(suffix $(subst /,.,$(PWD))))

##
## paths to useful places in the tree
##

#DEFDIR := $(DEPTH)/defs
#MANDIR := $(DEPTH)/manuals
#MAKDIR := $(DEPTH)/make
#CMODDIR := $(DEPTH)/cmod
#VMODDIR := $(DEPTH)/vmod
#VINCDIR := $(VMODDIR)/include
#VLIBDIR := $(VMODDIR)/vlibs
#SYNTH_RAMDIR := $(VMODDIR)/rams/synth
#MODEL_RAMDIR := $(VMODDIR)/rams/model

# include $(OUTDIR)/$(PROJECT)/defs/project.mk

# Useful target to get the value of a variable.
ifneq (,$(filter getvar_%,$(MAKECMDGOALS)))
$(filter getvar_%,$(MAKECMDGOALS)): getvar_% :
	@echo $($*)
endif
